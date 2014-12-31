//
//  ViewController.m
//  dspec
//
//  Created by Hugo Crochetière on 2014-12-17.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "ViewController.h"
#import "DesignSpecView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DesignSpecView *designView;

@end

@implementation ViewController

DesignSpecView *designView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.designView.designSpec addSpacing:185 Size:16 From:TOP];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
