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

@end

@implementation ViewController

DesignSpecView *designView;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    DesignSpecView *designView = [[DesignSpecView alloc] initWithFrame:self.view.frame];
    //    [[[[UIApplication sharedApplication] delegate] window] addSubview:designView];
    [[[[UIApplication sharedApplication] windows] objectAtIndex:0] addSubview:designView];
    [designView.designSpec loadSpecFromFileName:@"main_activity_spec"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [designView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
