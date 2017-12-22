//
//  newViewController.m
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "newViewController.h"

@interface newViewController ()

@end

@implementation newViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationBar];
    [self setNavigationBarTitle:@"whenever" withPopButton:YES];
    [self setRightButton];
//    newUserGuideView *view =[[newUserGuideView alloc]initWithFrame:self.view.bounds];
//    [self.view addSubview:view];
//    foreoWeakSelf;
//    view.block = ^{
//        if (weakSelf.block) {
//            weakSelf.block();
//        }
//    };
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClickAction{
//    NSLog(@"1231231");
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
