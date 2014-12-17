//
//  IntegrationLayout.h
//  integrationUI
//
//  Created by Hugo Crochetière on 2014-12-13.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DesignSpec.h"

@interface DesignSpecView : UIView <DesignSpecDelegate>
@property (nonatomic) DesignSpec *designSpec;
@end
