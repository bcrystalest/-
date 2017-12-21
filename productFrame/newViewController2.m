//
//  newViewController2.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/7.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "newViewController2.h"

@interface newViewController2 ()

@end

@implementation newViewController2

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor brownColor];
    
    [self setNavigationBarTitle:@"what!" withPopButton:NO];
    UIButton *btn = [UIButton new];
    [self.view addSubview:btn];
    btn.frame = CGRectMake(100, 100, 50, 50);
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(gogogo) forControlEvents:UIControlEventTouchDown];
    [self pageChangeAction];
}

//- (void)setNavigationBar{
//    
//    [self.navBar addNavigationBarTitle:@"whatever"];
//}

- (void)gogogo{
    newViewController *vc = [newViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
