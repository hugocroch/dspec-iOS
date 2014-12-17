//
//  Keyline.h
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FromEnum.h"

@interface Keyline : NSObject
@property (nonatomic) float position;
@property (nonatomic) From from;

- (id)initWithPosition:(float)position From:(From)from;

@end
