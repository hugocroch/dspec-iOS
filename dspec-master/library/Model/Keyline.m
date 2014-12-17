//
//  Keyline.m
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "Keyline.h"

@implementation Keyline

- (id)initWithPosition:(float)position From:(From)from {
    self = [super init];
    
    if (self) {
        _position = position;
        _from = from;
    }
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Keyline class]]) {
        return false;
    }
    Keyline *keyline = object;
    
    return (keyline == self || (_position == keyline.position && _from == keyline.from));
}

@end
