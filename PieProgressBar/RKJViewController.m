//
//  RKJViewController.m
//  PieProgressBar
//
//  Created by Ronak Jangir on 26/11/13.
//  Copyright (c) 2013 Ronak. All rights reserved.
//

#import "RKJViewController.h"

@interface RKJViewController ()

@end

@implementation RKJViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    progressView = [[RKJPieProgressView alloc] initWithFrame:CGRectMake(20, 20, 200, 200)];
    [self.view addSubview:progressView];
    progressView.delegate = self;
    [progressView progressToValue:.7 duration:20];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) didFinishAnimation:(RKJPieProgressView *)progressView {
}

@end
