//
//  ExchangeLocationView.h
//  Demo
//
//  Created by 杨涛 on 16/10/13.
//  Copyright © 2016年 www.mepadi.me. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ExchangeLocationView : UIView

@property(nonatomic, strong)NSArray *rects;
@property(nonatomic, strong)NSMutableArray *views;//views ，rects 一一对应初始化 最后得到的view顺序就是显示顺序

- (BOOL)loadViewsWithArray:(NSMutableArray *)arrayViews andRects:(NSArray *)rect;
//直接返回frame
+ (NSArray *)rectsWithCount:(int) count;
//
+ (NSArray *)rectsFlowLayoutWithCount:(int) count;

@end
