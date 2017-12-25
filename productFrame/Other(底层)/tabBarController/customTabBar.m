//
//  productMainTabBarController.h
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "customTabBar.h"

@interface customTabBar ()

@property (nonatomic, strong) UIImageView *centerBtn;

@end

@implementation customTabBar

#pragma mark - Life Cycle

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 设置tabBarItem选中状态时的颜色
        self.tintColor = [UIColor redColor];
        // 添加中间按钮到tabBar上
        [self addSubview:self.centerBtn];
    }
    
    return self;
}

// 重新布局tabBarItem（这里需要具体情况具体分析，本例是中间有个按钮，两边平均分配按钮）
- (void)layoutSubviews
{
    [super layoutSubviews];
    // 把tabBarButton取出来（把tabBar的SubViews打印出来就明白了）
    NSMutableArray *tabBarButtonArray = [NSMutableArray array];
    for (UIView *view in self.subviews) {
        if ([view isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabBarButtonArray addObject:view];
        }
    }
    
    CGFloat barWidth = self.bounds.size.width;
    CGFloat barHeight = self.bounds.size.height;
    CGFloat centerBtnWidth = CGRectGetWidth(self.centerBtn.frame);
    CGFloat centerBtnHeight = CGRectGetHeight(self.centerBtn.frame);
    // 设置中间按钮的位置，居中，凸起一丢丢
    if (KIsiPhoneX) {
        self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 5 - 40);
    }else{
        self.centerBtn.center = CGPointMake(barWidth / 2, barHeight - centerBtnHeight/2 - 5 - 10);
    }
    
    // 重新布局其他tabBarItem
    // 平均分配其他tabBarItem的宽度
    CGFloat barItemWidth = (barWidth - centerBtnWidth) / tabBarButtonArray.count;
    // 逐个布局tabBarItem，修改UITabBarButton的frame
    [tabBarButtonArray enumerateObjectsUsingBlock:^(UIView *  _Nonnull view, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CGRect frame = view.frame;
        if (idx >= tabBarButtonArray.count / 2) {
            // 重新设置x坐标，如果排在中间按钮的右边需要加上中间按钮的宽度
            frame.origin.x = idx * barItemWidth + centerBtnWidth;
        } else {
            frame.origin.x = idx * barItemWidth;
        }
        // 重新设置宽度
        frame.size.width = barItemWidth;
        view.frame = frame;
    }];
    // 把中间按钮带到视图最前面
    [self bringSubviewToFront:self.centerBtn];
}

#pragma mark - Actions

- (void)clickCenterBtn
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"点击了中间的按钮" message:@"do something!" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alertController dismissViewControllerAnimated:YES completion:nil];
    }];
    [alertController addAction:action];
    NSLog(@"点击了中间的按钮");
    // 可以这样获取tabBarController
    if ([[UIApplication sharedApplication].delegate.window.rootViewController isKindOfClass:[rootIncludeController class]]) {
        rootIncludeController *mainVC = (rootIncludeController *)[UIApplication sharedApplication].delegate.window.rootViewController;
        [mainVC.currentVC presentViewController:alertController animated:YES completion:nil];
    }
    
//    id delegate = [UIApplication sharedApplication].delegate;
//    UITabBarController *tabBarController = [delegate tabBarController];
    
//    [tabBarController.selectedViewController presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - Getter

- (UIImageView *)centerBtn
{
    if (_centerBtn == nil) {
        _centerBtn = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 60)];
        _centerBtn.image = [UIImage imageNamed:@"centerIcon"];
        _centerBtn.userInteractionEnabled = YES;
        _centerBtn.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickCenterBtn)];
        [_centerBtn addGestureRecognizer:tap];
    }
    return _centerBtn;
}

#pragma mark - UIViewGeometry

// 重写hitTest方法，让超出tabBar部分也能响应事件
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event
{
    if (self.clipsToBounds || self.hidden || (self.alpha == 0.f)) {
        return nil;
    }
    UIView *result = [super hitTest:point withEvent:event];
    // 如果事件发生在tabbar里面直接返回
    if (result) {
        return result;
    }
    // 这里遍历那些超出的部分就可以了，不过这么写比较通用。
    for (UIView *subview in self.subviews) {
        // 把这个坐标从tabbar的坐标系转为subview的坐标系
        CGPoint subPoint = [subview convertPoint:point fromView:self];
        result = [subview hitTest:subPoint withEvent:event];
        // 如果事件发生在subView里就返回
        if (result) {
            return result;
        }
    }
    return nil;
}

@end
