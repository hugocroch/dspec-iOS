//
//  Greatly inspired from the Android library dspec. This is like the copy of the library but for iOS.
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "DesignSpecView.h"

IB_DESIGNABLE

@interface DesignSpecView ()
@property (nonatomic) NSArray *constraint_V;
@property (nonatomic) NSArray *constraint_H;

@property (nonatomic) IBInspectable float baselineCellSize;
@end

@implementation DesignSpecView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(deviceOrientationDidChangeNotification:)
         name:UIDeviceOrientationDidChangeNotification
         object:nil];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.userInteractionEnabled = NO;
        [[NSNotificationCenter defaultCenter]
         addObserver:self
         selector:@selector(deviceOrientationDidChangeNotification:)
         name:UIDeviceOrientationDidChangeNotification
         object:nil];
    }
    return self;
}

- (void)deviceOrientationDidChangeNotification:(NSNotification *)note {
    [self onRedraw];
}

- (void)drawRect:(CGRect)rect {
    CGContextRef context = UIGraphicsGetCurrentContext();
    [self.designSpec draw:context];
}

- (void)didMoveToSuperview {
    //    NSDictionary *viewsDictionary = @{ @"view" : self };
    //    self.constraint_V = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[view]|" options:0 metrics:nil views:viewsDictionary];
    //    self.constraint_H = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[view]|" options:0 metrics:nil views:viewsDictionary];
    //    self.translatesAutoresizingMaskIntoConstraints = NO;
    //    [self.superview addConstraints:self.constraint_V];
    //    [self.superview addConstraints:self.constraint_H];
}

#pragma mark - Properties

- (DesignSpec *)designSpec {
    if (!_designSpec) {
        _designSpec = [DesignSpec new];
        _designSpec.hostView = self;
        if (self.baselineCellSize >= 1) {
            [_designSpec setBaselineGridCellSize:self.baselineCellSize];
        }
        _designSpec.delegate = self;
    }
    return _designSpec;
}

#pragma mark - DesignSpec Delegate

- (void)onRedraw {
    [self.layer display];
    [self setNeedsDisplay];
}

@end
