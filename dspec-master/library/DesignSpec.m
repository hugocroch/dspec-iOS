//
//  DesignSpec.m
//
//Greatly inspired from the Android library dspec. This is like the copy of the library but for iOS.
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "DesignSpec.h"
#import "UIColor+CreateColors.h"

#define DEFAULT_BASELINE_GRID_VISIBLE true
#define DEFAULT_SPACINGS_VISIBLE true
#define DEFAULT_KEYLINES_VISIBLE true
#define DEFAULT_BASELINE_GRID_CELL_SIZE_DIP  8.0f
#define KEYLINE_STROKE_WIDTH 1.1f

@interface DesignSpec ()

@property (nonatomic) BOOL mBaselineVisible;
@property (nonatomic) UIColor *mBaselineColor;
@property (nonatomic) IBInspectable float baselineCellSize;
@property (nonatomic) int spaceBaseLine;

@property (nonatomic) BOOL mKeylineVisible;
@property (nonatomic) UIColor *mKeylineColor;
@property (nonatomic) NSMutableArray *keyLines;

@property (nonatomic) BOOL mSpacingVisible;
@property (nonatomic) UIColor *mSpacingColor;
@property (nonatomic) NSMutableArray *spacings;
@end

@implementation DesignSpec

NSString *const DEFAULT_BASELINE_GRID_COLOR = @"#44C2185B";
NSString *const DEFAULT_KEYLINE_COLOR = @"#CCC2185B";
NSString *const DEFAULT_SPACING_COLOR = @"#CC89FDFD";

NSString *const JSON_KEY_BASELINE_GRID_VISIBLE = @"baselineGridVisible";
NSString *const JSON_KEY_BASELINE_GRID_CELL_SIZE = @"baselineGridCellSize";
NSString *const JSON_KEY_BASELINE_GRID_COLOR = @"baselineGridColor";

NSString *const JSON_KEY_KEYLINES_VISIBLE = @"keylinesVisible";
NSString *const JSON_KEY_KEYLINES_COLOR = @"keylinesColor";
NSString *const JSON_KEY_KEYLINES = @"keylines";

NSString *const JSON_KEY_OFFSET = @"offset";
NSString *const JSON_KEY_SIZE = @"size";
NSString *const JSON_KEY_FROM = @"from";

NSString *const JSON_KEY_SPACINGS_VISIBLE = @"spacingsVisible";
NSString *const JSON_KEY_SPACINGS_COLOR = @"spacingsColor";
NSString *const JSON_KEY_SPACINGS = @"spacings";

- (instancetype)init {
    self = [super init];
    if (self) {
        self.baselineGridCellSize = DEFAULT_BASELINE_GRID_CELL_SIZE_DIP;
        self.mBaselineVisible = DEFAULT_BASELINE_GRID_VISIBLE;
        self.mKeylineVisible = DEFAULT_KEYLINES_VISIBLE;
        self.mSpacingVisible = DEFAULT_SPACINGS_VISIBLE;
    }
    return self;
}

#pragma mark - Properties

- (NSMutableArray *)spacings {
    if (!_spacings)
        _spacings = [NSMutableArray new];
    return _spacings;
}

- (NSMutableArray *)keyLines {
    if (!_keyLines)
        _keyLines = [NSMutableArray new];
    return _keyLines;
}

- (CGRect)getRect   {
    return self.hostView.frame;
}

- (UIColor *)mBaselineColor {
    if (!_mBaselineColor) {
        _mBaselineColor = [UIColor colorWithHex:DEFAULT_BASELINE_GRID_COLOR];
    }
    return _mBaselineColor;
}

- (UIColor *)mKeylineColor {
    if (!_mKeylineColor) {
        _mKeylineColor = [UIColor colorWithHex:DEFAULT_KEYLINE_COLOR];
    }
    return _mKeylineColor;
}

- (UIColor *)mSpacingColor {
    if (!_mSpacingColor) {
        _mSpacingColor = [UIColor colorWithHex:DEFAULT_SPACING_COLOR];
    }
    return _mSpacingColor;
}

#pragma mark - Setter

- (DesignSpec *)setBaselineGridColor:(UIColor *)color {
    if (CGColorEqualToColor(self.mBaselineColor.CGColor, color.CGColor)) {
        return self;
    }
    self.mBaselineColor = color;
    [self.delegate onRedraw];
    return self;
}

- (DesignSpec *)setBaselineGridCellSize:(float)cellSize {
    if (self.baselineCellSize == cellSize) {
        return self;
    }
    
    self.baselineCellSize = cellSize;
    [self.delegate onRedraw];
    return self;
}

#pragma mark - Draw Function

- (void)draw:(CGContextRef)context {
    CGContextClearRect(context, [self getRect]);
    [self drawSpacings:context];
    [self drawBaseline:context];
    [self drawKeylines:context];
}

#pragma mark - Baseline

- (BOOL)isBaselineVisible {
    return _mBaselineVisible;
}

- (DesignSpec *)setBaselineGridVisible:(BOOL)visible {
    if (self.mBaselineVisible == visible) {
        return self;
    }
    
    self.mBaselineVisible = visible;
    [self.delegate onRedraw];
    return self;
}

- (void)drawBaseline:(CGContextRef)context {
    if ([self isBaselineVisible]) {
        CGContextSetStrokeColorWithColor(context, self.mBaselineColor.CGColor); //change color here
        CGFloat lineWidth = 1.0; //change line width here
        CGContextSetLineWidth(context, lineWidth);
        
        float x = self.baselineCellSize;
        while (x < [self getRect].size.width) {
            CGContextMoveToPoint(context, x, 0);
            CGContextAddLineToPoint(context, x, [self getRect].size.height);
            
            CGContextStrokePath(context);
            x += self.baselineCellSize;
        }
        
        float y = self.baselineCellSize;
        while (y < [self getRect].size.height) {
            CGContextMoveToPoint(context, 0, y);
            CGContextAddLineToPoint(context, [self getRect].size.width, y);
            CGContextStrokePath(context);
            y += self.baselineCellSize;
        }
    }
}

#pragma mark - Keyline

- (DesignSpec *)addKeyline:(float)position From:(From)from {
    Keyline *keyline = [[Keyline alloc] initWithPosition:position From:from];
    if ([self.keyLines containsObject:keyline]) {
        return self;
    }
    
    [self.keyLines addObject:keyline];
    return self;
}

- (BOOL)areKeylinesVisible {
    return _mKeylineVisible;
}

- (DesignSpec *)setKeylineVisible:(BOOL)visible {
    if (self.mKeylineVisible == visible) {
        return self;
    }
    
    self.mKeylineVisible = visible;
    [self.delegate onRedraw];
    return self;
}

- (DesignSpec *)setKeylineColor:(UIColor *)color {
    if (CGColorEqualToColor(self.mKeylineColor.CGColor, color.CGColor)) {
        return self;
    }
    self.mKeylineColor = color;
    [self.delegate onRedraw];
    return self;
}

- (void)drawKeylines:(CGContextRef)context {
    if ([self areKeylinesVisible]) {
        float width = [self getRect].size.width;
        float height = [self getRect].size.height;
        for (Keyline *keyline in self.keyLines) {
            float position;
            switch (keyline.from) {
                case LEFT:
                case TOP:
                    position = keyline.position;
                    break;
                    
                case RIGHT:
                    position = width - keyline.position;
                    break;
                    
                case BOTTOM:
                    position = height - keyline.position;
                    break;
                    
                case VERTICAL_CENTER:
                    position = (height / 2) + keyline.position;
                    break;
                    
                case HORIZONTAL_CENTER:
                    position = (width / 2) + keyline.position;
                    break;
            }
            
            switch (keyline.from) {
                case LEFT:
                case RIGHT:
                case HORIZONTAL_CENTER: {
                    CGContextSetStrokeColorWithColor(context, self.mKeylineColor.CGColor); //change color here
                    CGContextSetLineWidth(context, KEYLINE_STROKE_WIDTH);
                    CGContextMoveToPoint(context, position, 0);
                    CGContextAddLineToPoint(context, position, height);
                    CGContextStrokePath(context);
                    break;
                }
                    
                case TOP:
                case BOTTOM:
                case VERTICAL_CENTER: {
                    CGContextSetStrokeColorWithColor(context, self.mKeylineColor.CGColor); //change color here
                    CGContextSetLineWidth(context, KEYLINE_STROKE_WIDTH);
                    CGContextMoveToPoint(context, 0, position);
                    CGContextAddLineToPoint(context, width, position);
                    CGContextStrokePath(context);
                    break;
                }
            }
        }
    }
}

#pragma mark - Spacing

- (DesignSpec *)addSpacing:(float)offset Size:(float)size From:(From)from {
    Spacing *spacing = [[Spacing alloc] initWithOffset:offset Size:size From:from];
    if ([self.spacings containsObject:spacing]) {
        return self;
    }
    
    [self.spacings addObject:spacing];
    return self;
}

- (BOOL)areSpacingsVisible {
    return _mSpacingVisible;
}

- (DesignSpec *)setSpacingVisible:(BOOL)visible {
    if (self.mSpacingVisible == visible) {
        return self;
    }
    
    self.mKeylineVisible = visible;
    [self.delegate onRedraw];
    return self;
}

- (DesignSpec *)setSpacingColor:(UIColor *)color {
    if (CGColorEqualToColor(self.mSpacingColor.CGColor, color.CGColor)) {
        return self;
    }
    self.mSpacingColor = color;
    [self.delegate onRedraw];
    return self;
}

- (void)drawSpacings:(CGContextRef)context {
    if ([self areSpacingsVisible]) {
        float width = [self getRect].size.width;
        float height = [self getRect].size.height;
        
        for (Spacing *spacing in self.spacings) {
            float position1;
            float position2;
            position2 = spacing.size;
            switch (spacing.from) {
                case LEFT:
                case TOP:
                    position1 = spacing.offset;
                    break;
                    
                case RIGHT:
                    position1 = width - (spacing.offset + spacing.size);
                    break;
                    
                case BOTTOM:
                    position1 = height - (spacing.offset + spacing.size);
                    break;
                    
                case VERTICAL_CENTER:
                    position1 = (height / 2) + spacing.offset;
                    break;
                    
                case HORIZONTAL_CENTER:
                    position1 = (width / 2) + spacing.offset;
                    break;
            }
            
            switch (spacing.from) {
                case LEFT:
                case RIGHT:
                case HORIZONTAL_CENTER: {
                    CGRect rectangle = CGRectMake(position1, 0, position2, height);
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    CGContextSetFillColorWithColor(context, self.mSpacingColor.CGColor);
                    CGContextFillRect(context, rectangle);
                    break;
                }
                    
                case TOP:
                case BOTTOM:
                case VERTICAL_CENTER: {
                    CGRect rectangle = CGRectMake(0, position1, width, position2);
                    CGContextRef context = UIGraphicsGetCurrentContext();
                    CGContextSetFillColorWithColor(context, self.mSpacingColor.CGColor);
                    CGContextFillRect(context, rectangle);
                    break;
                }
            }
        }
    }
}

#pragma mark - JSON

- (NSDictionary *)getJSONWithName:(NSString *)name {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

- (void)loadSpecFromFileName:(NSString *)name {
    NSDictionary *json = [self getJSONWithName:name];
    
    
    
    [self setBaselineCellSize:[[json allKeys] containsObject:JSON_KEY_BASELINE_GRID_CELL_SIZE] ? [[json objectForKey:JSON_KEY_BASELINE_GRID_CELL_SIZE] floatValue]:DEFAULT_BASELINE_GRID_CELL_SIZE_DIP];
    //
    [self setBaselineGridVisible:[[json allKeys] containsObject:JSON_KEY_BASELINE_GRID_VISIBLE] ? [[json objectForKey:JSON_KEY_BASELINE_GRID_VISIBLE] boolValue]:DEFAULT_BASELINE_GRID_VISIBLE];
    
    [self setKeylineVisible:[[json allKeys] containsObject:JSON_KEY_KEYLINES_VISIBLE] ? [[json objectForKey:JSON_KEY_KEYLINES_VISIBLE] boolValue]:DEFAULT_KEYLINES_VISIBLE];
    
    [self setBaselineGridVisible:[[json allKeys] containsObject:JSON_KEY_SPACINGS_VISIBLE] ? [[json objectForKey:JSON_KEY_SPACINGS_VISIBLE] boolValue]:DEFAULT_SPACINGS_VISIBLE];
    
    [self setBaselineGridVisible:[[json allKeys] containsObject:JSON_KEY_SPACINGS_VISIBLE] ? [[json objectForKey:JSON_KEY_SPACINGS_VISIBLE] boolValue]:DEFAULT_SPACINGS_VISIBLE];
    
    [self setBaselineGridColor:[UIColor colorWithHex:[[json allKeys] containsObject:JSON_KEY_BASELINE_GRID_COLOR] ? [json objectForKey:JSON_KEY_BASELINE_GRID_COLOR]:DEFAULT_BASELINE_GRID_COLOR]];
    
    [self setKeylineColor:[UIColor colorWithHex:[[json allKeys] containsObject:JSON_KEY_KEYLINES_COLOR] ? [json objectForKey:JSON_KEY_KEYLINES_COLOR]:DEFAULT_KEYLINE_COLOR]];
    
    [self setSpacingColor:[UIColor colorWithHex:[[json allKeys] containsObject:JSON_KEY_SPACINGS_COLOR] ? [json objectForKey:JSON_KEY_SPACINGS_COLOR]:DEFAULT_SPACING_COLOR]];
    
    NSArray *keylines = [[json allKeys] containsObject:JSON_KEY_KEYLINES] ? [json objectForKey:JSON_KEY_KEYLINES] : [NSArray new];
    
    for (int index = 0; index < keylines.count; index++) {
        NSDictionary *dictionary = [keylines objectAtIndex:index];
        @try {
            [self addKeyline:[[dictionary objectForKey:JSON_KEY_OFFSET] floatValue]
                        From:[FromEnum getFromByString:[dictionary objectForKey:JSON_KEY_FROM]]];
        }
        @catch (NSException *exception)
        {
            continue;
        }
    }
    
    
    NSArray *spacings = [[json allKeys] containsObject:JSON_KEY_SPACINGS] ? [json objectForKey:JSON_KEY_SPACINGS] : [NSArray new];
    
    for (int index = 0; index < spacings.count; index++) {
        NSDictionary *dictionary = [spacings objectAtIndex:index];
        @try {
            [self addSpacing:[[dictionary objectForKey:JSON_KEY_OFFSET] floatValue] Size:[[dictionary objectForKey:JSON_KEY_SIZE] floatValue] From:[FromEnum getFromByString:[dictionary objectForKey:JSON_KEY_FROM]]];
        }
        @catch (NSException *exception)
        {
            continue;
        }
    }
}

@end
