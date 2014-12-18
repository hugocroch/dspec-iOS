//
//  TableViewController.m
//  dspec
//
//  Created by Hugo Crochetière on 2014-12-17.
//  Copyright (c) 2014 Hugo Crochetiere. All rights reserved.
//

#import "TableViewController.h"
#import "CustomCell.h"
#import "DesignSpecView.h"

@implementation TableViewController

DesignSpecView *designView;

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"customCell" forIndexPath:indexPath];
    cell.image.image = [UIImage imageNamed:@"image1.jpg"];
    return cell;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    designView = [[DesignSpecView alloc] initWithFrame:self.view.frame];
    [[[[UIApplication sharedApplication] delegate] window] addSubview:designView];
    [designView.designSpec loadSpecFromFileName:@"main_activity_spec"];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [designView removeFromSuperview];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

@end
