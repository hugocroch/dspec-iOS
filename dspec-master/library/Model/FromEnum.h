//
//  From.h
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    LEFT,
    RIGHT,
    TOP,
    BOTTOM,
    VERTICAL_CENTER,
    HORIZONTAL_CENTER
} From;

@interface FromEnum : NSObject
+ (From)getFromByString:(NSString *)string;
@end
