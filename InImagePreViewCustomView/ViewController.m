//
//  ViewController.m
//  InImagePreViewCustomView
//
//  Created by 杨涛 on 16/10/13.
//  Copyright © 2016年 www.mepadi.me. All rights reserved.
//

#import "ViewController.h"
#import "ExchangeLocationView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     // custome
    ExchangeLocationView *iv = [[ExchangeLocationView alloc] initWithFrame:[UIScreen mainScreen].bounds];
     [self.view addSubview:iv];

    int count = 5;
    NSMutableArray *views = [NSMutableArray new];
    for (int i = 0; i < count; i ++) {
        UILabel *label = [[UILabel alloc] init];
        label.backgroundColor = [UIColor orangeColor];
        label.font = [UIFont boldSystemFontOfSize:50];
        label.text = [NSString stringWithFormat:@"%d",i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor whiteColor];
        [views addObject:label];
    }
    
    [iv loadViewsWithArray:views andRects:[ExchangeLocationView rectsFlowLayoutWithCount:count]];
   
    // custome
    
    // collection
    
    // collection
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
