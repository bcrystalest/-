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

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBar];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor=[UIColor whiteColor];
}

- (void)setNavigationBar{
    self.navigationController.navigationBar.hidden = YES;
}

-(void)addTitleView:(NSString *)name{
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 150*1, 44)];
//    label.textColor=KTITLEVIEWCOL;
    label.text = name;
    label.textAlignment=NSTextAlignmentCenter;
    label.font=[UIFont boldSystemFontOfSize:22];
    self.navigationItem.titleView=label;
}

-(void)addBarItem:(NSString *)title withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44*1, 30)];
    if (title!=nil) {
        [btn setTitle:title forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        btn.titleLabel.font=[UIFont systemFontOfSize:14];
    }
    if (backGroundImage!=nil) {
        [btn setBackgroundImage:[UIImage imageNamed:backGroundImage] forState:UIControlStateNormal];
    }
    UIBarButtonItem *barBtn=[[UIBarButtonItem alloc]initWithCustomView:btn];
    if ([direction isEqualToString:@"left"]) {
        [btn addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem=barBtn;
    }else if([direction isEqualToString:@"right"]){
        [btn addTarget:self action:@selector(rightClick:) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.rightBarButtonItem=barBtn;
    }
}

-(void)leftClick:(UIButton *)btn{
    NSLog(@"子类需要重写leftClick:方法");
}
-(void)rightClick:(UIButton *)btn{
    NSLog(@"子类需要重写rightClick:方法");
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
