//
//  Spacing.m
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "Spacing.h"

@implementation Spacing

- (id)initWithOffset:(float)offset Size:(float)size From:(From)from {
    self = [super init];
    
    if (self) {
        _offset = offset;
        _size = size;
        _from = from;
    }
    
    return self;
}

- (BOOL)isEqual:(id)object {
    if (![object isKindOfClass:[Spacing class]]) {
        return false;
    }
    Spacing *spacing = object;
    
    return (spacing == self || (_offset == spacing.offset && _size == spacing.size && _from == spacing.from));
}

@end
