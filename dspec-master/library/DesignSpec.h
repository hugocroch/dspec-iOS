//
//  DesignSpec.h
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Keyline.h"
#import "Spacing.h"
#import "FromEnum.h"

@protocol DesignSpecDelegate <NSObject>
- (void)onRedraw;
@end

@interface DesignSpec : NSObject
@property (nonatomic) id <DesignSpecDelegate> delegate;
@property (nonatomic) UIView *hostView;

//DRAW
- (void)draw:(CGContextRef)context;

//BASELINE
- (DesignSpec *)setBaselineGridColor:(UIColor *)color;
- (DesignSpec *)setBaselineGridCellSize:(float)cellSize;
- (BOOL)isBaselineVisible;
- (DesignSpec *)setBaselineGridVisible:(BOOL)visible;

//KEYLINE
- (BOOL)areKeylinesVisible;
- (DesignSpec *)setKeylineVisible:(BOOL)visible;
- (DesignSpec *)setKeylineColor:(UIColor *)color;
- (DesignSpec *)addKeyline:(float)position From:(From)from;

//SPACING
- (BOOL)areSpacingsVisible;
- (DesignSpec *)setSpacingVisible:(BOOL)visible;
- (DesignSpec *)setSpacingColor:(UIColor *)color;
- (DesignSpec *)addSpacing:(float)offset Size:(float)size From:(From)from;


//JSON
- (void)loadSpecFromFileName:(NSString *)name;
@end
