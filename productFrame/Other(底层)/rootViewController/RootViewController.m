//
//  productMainTabBarController.m
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//
#import "RootViewController.h"

@interface RootViewController ()

@end

@implementation RootViewController

- (navigationView *)navBar{
    if (_navBar == nil) {
        _navBar = [[navigationView alloc]init];
    }
    return _navBar;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 1) {
        self.tabBarController.tabBar.hidden = YES;
    }else{
        self.tabBarController.tabBar.hidden = NO;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addNavigationBar];
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)addNavigationBar{
    foreoWeakSelf;
    self.navigationController.navigationBar.hidden = YES;
    [self.view addSubview:self.navBar];
    
    _navBar.gobackBlock = ^{
        [weakSelf goBack];
    };
}
///设置title和返回按钮
- (void)setNavigationBarTitle:(NSString *)title withPopButton:(BOOL)show{
    [self.navBar addNavigationBarTitle:title];
    if (show == YES) {
        [self.navBar addBackButton];
    }
}
- (void)setRightButtonWithType:(navButtonType *)type andTitle:(NSString *)title andImage:(UIImage *)image andTextFont:(CGFloat)font
{
    foreoWeakSelf;
    [self.navBar addRightButtonWithType:type andTitle:title andImage:image andTextFont:font];
    _navBar.rightClickBlock = ^{
        [weakSelf rightClickAction];
    };
}


-(void)leftClick:(UIButton *)btn{
    NSLog(@"子类需要重写leftClick:方法");
}
-(void)rightClickAction{
    
    NSLog(@"子类需要重写rightClick:方法");
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)pageChangeAction{
    if (_pageChangeActionBlock) {
        _pageChangeActionBlock();
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
