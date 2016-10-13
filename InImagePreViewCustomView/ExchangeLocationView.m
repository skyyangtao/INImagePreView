//
//  ExchangeLocationView.m
//  Demo
//
//  Created by 杨涛 on 16/10/13.
//  Copyright © 2016年 www.mepadi.me. All rights reserved.
//

#import "ExchangeLocationView.h"

@interface ExchangeLocationView ()
@property (nonatomic, assign)CGPoint touchRelativePoint;
@end

#define screenWidth  ([UIScreen mainScreen].bounds.size.width)
#define outterPadding  20.0f
#define innerPadding  8.0f
#define upperPadding  120.0f

@implementation ExchangeLocationView

-(NSMutableArray *)views {
    if (!_views) {
        _views = [NSMutableArray new];
    }
    return _views;
}

- (BOOL)loadViewsWithArray:(NSMutableArray *)arrayViews andRects:(NSArray *)rect {
    _views = arrayViews;
    _rects = rect;
    if (!_views || !_rects || _views.count != _rects.count) {
        return NO;
    }
    if (_views) {
        for (int i = 0; i < _views.count; i ++) {
            UIView *iv = _views[i];
            iv.tag = i;
            iv.frame = CGRectFromString(_rects[i]);
            iv.userInteractionEnabled = YES;
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
            [iv addGestureRecognizer:pan];
            [self addSubview:iv];
        }
    }
    return YES;
}

- (void)panGestureAction:(UIPanGestureRecognizer *)panGesture {
    UIView *iv = panGesture.view;
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:{
            iv.alpha = 0.5;
            CGPoint center = [panGesture locationInView:self];
            _touchRelativePoint = CGPointMake(center.x - iv.center.x, center.y - iv.center.y);
            [self bringSubviewToFront:iv];
        }
            break;
        case UIGestureRecognizerStateChanged:
        {
            CGPoint center = [panGesture locationInView:self];
            iv.center = CGPointMake(center.x - _touchRelativePoint.x, center.y - _touchRelativePoint.y);
            for(int i = 0; i < _views.count;i ++) {
                CGRect frame = CGRectFromString(_rects[i]);
                if (i != iv.tag) {
                    if (CGRectContainsPoint(frame, iv.center)) {
                        [self updateViewsLocationWithIv:iv andIndex:i];
                        break;
                    }
                }
                
            }
        }
            
            break;
        default://UIGestureRecognizerStateCancelled  UIGestureRecognizerStateEnded
        {
    
            [UIView animateWithDuration:.3 animations:^{
                iv.frame = CGRectFromString(_rects[iv.tag]);
                iv.alpha = 1;
            }];
        }
            break;
    }

}

- (void)updateViewsLocationWithIv:(UIView *)iv andIndex:(int)index {
   
    [_views removeObject:iv];
    [_views insertObject:iv atIndex:index];
    for(int i = 0; i < _views.count;i ++) {
        UILabel *label = _views[i];
        label.tag = i;
    }

    for(int i = 0; i < _views.count;i ++) {
        UIView *view = _views[i];
        if (view != iv) {
            CGRect targetRect = CGRectFromString(_rects[view.tag]);
            if (!CGRectEqualToRect(view.frame, targetRect)) {
                [UIView animateWithDuration:.25 animations:^{
                    view.frame = CGRectFromString(_rects[view.tag]);
                }];
            }
        }
        
    }

}

+ (NSArray *)rectsWithCount:(int) count {
 
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    switch (count) {
        case 1:
            return @[NSStringFromCGRect(CGRectMake(outterPadding, upperPadding, screenWidth - 2 *outterPadding,screenHeight - 2 * upperPadding))];
            break;
        case 2:
        {
            float samllWidth = (screenWidth - 2 * (outterPadding + innerPadding)) / 3 ;

            return @[NSStringFromCGRect(CGRectMake(outterPadding, upperPadding, screenWidth - 2 *outterPadding,samllWidth * 2 + innerPadding)),NSStringFromCGRect(CGRectMake(outterPadding, upperPadding + samllWidth * 2 + 2 * innerPadding, screenWidth - 2 *outterPadding,samllWidth * 2 + innerPadding))];
        }
            break;
        case 3:
        case 4:
        case 7:
        case 9:
        {
            int rowCount = (count < 5) ? count - 1 : ((count - 1) / 2);
            float samllWidth = (screenWidth - 2 * outterPadding - innerPadding * (rowCount - 1)) / rowCount;
            
            
            float tempWidth = (screenWidth - 2 * outterPadding - innerPadding * 2) / 3;
            NSMutableArray *rects = [NSMutableArray array];
            for (int i = 0; i < count; i ++) {
                if (0 == i) {
                    [rects addObject:NSStringFromCGRect(CGRectMake(outterPadding, upperPadding, screenWidth - 2 * outterPadding,tempWidth * 2 + innerPadding))];
                }else{
                    int row = (i - 1) / rowCount;
                    [rects addObject:NSStringFromCGRect(CGRectMake(outterPadding + (samllWidth + innerPadding) * ((i - 1) % rowCount), upperPadding + (tempWidth + innerPadding) * (2 + row) , samllWidth,samllWidth))];
                    
                }
            }
            return rects;

        }
            break;
        case 5:
        case 6:
        {
            float samllWidth = (screenWidth - 2 * (outterPadding + innerPadding)) / 3 ;
            float middleWidth = (screenWidth - 2 * outterPadding - innerPadding) / 2 ;
            NSMutableArray *rects = [NSMutableArray array];
            for (int i = 0; i < count; i ++) {
                if (0 == i) {
                    [rects addObject:NSStringFromCGRect(CGRectMake(outterPadding, upperPadding, samllWidth * 2 + innerPadding,samllWidth * 2 + innerPadding))];
                }
                else if (i < 3){
                    [rects addObject:NSStringFromCGRect(CGRectMake(screenWidth - samllWidth - outterPadding, upperPadding + (innerPadding + samllWidth) * (i - 1), samllWidth ,samllWidth ))];
                }
                else{
                    float bottomUnitWidth = (count == 5) ? middleWidth : samllWidth;
                    [rects addObject:NSStringFromCGRect(CGRectMake(outterPadding + (i - 3) * (innerPadding + bottomUnitWidth), upperPadding + (samllWidth + innerPadding) * 2, bottomUnitWidth,bottomUnitWidth))];
                }
            }
            return rects;

        }
            break;
        case 8:
        {
            float samllWidth = (screenWidth - 2 * outterPadding - innerPadding * 2) / 3;
            float bigWidth = (screenWidth - 2 * outterPadding - innerPadding) / 2;
            NSMutableArray *rects = [NSMutableArray array];
            for (int i = 0; i < count; i ++) {
                if (i < 2) {
                    [rects addObject:NSStringFromCGRect(CGRectMake(outterPadding + i *(bigWidth + innerPadding), upperPadding, bigWidth,bigWidth))];
                }else{
                    int row = (i - 2) / 3;
                    [rects addObject:NSStringFromCGRect(CGRectMake(outterPadding + (samllWidth + innerPadding) * ((i - 2) % 3), upperPadding + bigWidth + innerPadding + (samllWidth + innerPadding) *  row , samllWidth,samllWidth))];
                    
                }
            }
            return rects;
            
        }
            break;

        default:
            break;
    }
    return @[];
}

+ (NSArray *)rectsFlowLayoutWithCount:(int) count {
 
    float screenHeight = [UIScreen mainScreen].bounds.size.height;
    
    NSMutableArray *sizes = [NSMutableArray array];
    switch (count) {
        case 1:
            sizes = [@[NSStringFromCGSize(CGSizeMake( screenWidth - 2 * outterPadding,screenHeight - 2 * upperPadding))] mutableCopy];
            break;
        case 2:
        {
            float samllWidth = (screenWidth - 2 * (outterPadding + innerPadding)) / 3 ;
            sizes = [@[
                      NSStringFromCGSize(CGSizeMake(screenWidth - 2 * outterPadding,samllWidth * 2 + innerPadding)),
                      NSStringFromCGSize(CGSizeMake(screenWidth - 2 * outterPadding,samllWidth * 2 + innerPadding))
                      ] mutableCopy ] ;
        }
            
            break;
        case 3:
        case 4:
        case 7:
        case 9:
        {
            int rowCount = (count < 5) ? count - 1 : ((count - 1) / 2);
            float samllWidth = (screenWidth - 2 * outterPadding - innerPadding * (rowCount - 1)) / rowCount;
            float tempWidth = (screenWidth - 2 * outterPadding - innerPadding * 2) / 3;
            for (int i = 0; i < count; i ++) {
                if (0 == i) {
                    [sizes addObject:NSStringFromCGSize(CGSizeMake( screenWidth - 2 * outterPadding,tempWidth * 2 + innerPadding))];
                }else{
                    [sizes addObject:NSStringFromCGSize(CGSizeMake( samllWidth,samllWidth))];
                    
                }
            }
            
        }
            break;
        case 5:
        case 6:
        {
            float samllWidth = (screenWidth - 2 * (outterPadding + innerPadding)) / 3 ;
            float middleWidth = (screenWidth - 2 * outterPadding - innerPadding) / 2 ;
            for (int i = 0; i < count; i ++) {
                if (0 == i) {
                    [sizes addObject:NSStringFromCGSize(CGSizeMake(samllWidth * 2 + innerPadding,samllWidth * 2 + innerPadding))];
                }
                else if (i < 3){
                    [sizes addObject:NSStringFromCGSize(CGSizeMake(samllWidth ,samllWidth ))];
                }
                else{
                    float bottomUnitWidth = (count == 5) ? middleWidth : samllWidth;
                    [sizes addObject:NSStringFromCGSize(CGSizeMake(bottomUnitWidth,bottomUnitWidth))];
                }
            }
            
        }
            break;
        case 8:
        {
            float samllWidth = (screenWidth - 2 * outterPadding - innerPadding * 2) / 3;
            float bigWidth = (screenWidth - 2 * outterPadding - innerPadding) / 2;
            for (int i = 0; i < count; i ++) {
                if (i < 2) {
                    [sizes addObject:NSStringFromCGSize(CGSizeMake(bigWidth,bigWidth))];
                }else{
                    [sizes addObject:NSStringFromCGSize(CGSizeMake(samllWidth,samllWidth))];
                    
                }
            }
        }
  
        default:
            break;
    }
    return [ExchangeLocationView flowLayoutWithRects:sizes];;
}


+ (NSArray *)flowLayoutWithRects:(NSArray *)rects {
 
    float x = outterPadding;
    float y = upperPadding;
    float maxY = upperPadding;
    NSMutableArray *frames = [NSMutableArray array];
    
    for(int i = 0;i < rects.count;i ++){
        CGSize size = CGSizeFromString(rects[i]);
        float w = size.width;
        float h = size.height;
         [frames addObject:NSStringFromCGRect(CGRectMake(x, y, w , h))];
        x = x + w + innerPadding;
        maxY = MAX(maxY, y + h + innerPadding);
        if (x >= screenWidth - 2 * outterPadding) {
            y = y + innerPadding + h;
            x = y < maxY ? x - innerPadding - w : outterPadding;
 
        }
    }
    
    return frames;
}


@end
