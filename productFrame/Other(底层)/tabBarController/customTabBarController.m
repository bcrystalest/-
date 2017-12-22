//
//  productMainTabBarController.h
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "customTabBarController.h"
#import "customTabBar.h"
#import "newViewController2.h"

@interface customTabBarController ()

@end

@implementation customTabBarController

#pragma mark - Life Cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // 利用KVO来使用自定义的tabBar
    [self setValue:[[customTabBar alloc] init] forKey:@"tabBar"];
    
    [self addAllChildViewController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Private Methods

// 添加全部的 childViewcontroller
- (void)addAllChildViewController
{
    newViewController2 *homeVC = [[newViewController2 alloc] init];
    [self addChildViewController:homeVC title:@"首页" imageNamed:@"tabBar_home"];
    
    newViewController2 *activityVC = [[newViewController2 alloc] init];
    [self addChildViewController:activityVC title:@"活动" imageNamed:@"tabBar_activity"];
    
    newViewController2 *findVC = [[newViewController2 alloc] init];
    [self addChildViewController:findVC title:@"发现" imageNamed:@"tabBar_find"];
    
    newViewController2 *mineVC = [[newViewController2 alloc] init];
    [self addChildViewController:mineVC title:@"我的" imageNamed:@"tabBar_mine"];
}

// 添加某个 childViewController
- (void)addChildViewController:(UIViewController *)vc title:(NSString *)title imageNamed:(NSString *)imageNamed
{
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
    // 如果同时有navigationbar 和 tabbar的时候最好分别设置它们的title
    vc.navigationItem.title = title;
    nav.tabBarItem.title = title;
    nav.tabBarItem.image = [UIImage imageNamed:imageNamed];
    
    [self addChildViewController:nav];
}

@end
