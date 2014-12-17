//
//  From.m
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "FromEnum.h"

@implementation FromEnum
+ (From)getFromByString:(NSString *)string {
    if ([string isEqualToString:@"LEFT"]) {
        return LEFT;
    }
    
    if ([string isEqualToString:@"RIGHT"]) {
        return RIGHT;
    }
    
    if ([string isEqualToString:@"TOP"]) {
        return TOP;
    }
    
    if ([string isEqualToString:@"BOTTOM"]) {
        return BOTTOM;
    }
    
    return LEFT;
}

@end
