//
//  Spacing.h
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FromEnum.h"

@interface Spacing : NSObject
@property (nonatomic) float offset;
@property (nonatomic) float size;
@property (nonatomic) From from;

- (id)initWithOffset:(float)offset Size:(float)size From:(From)from;

@end
