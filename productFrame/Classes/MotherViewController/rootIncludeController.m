//
//  SNLineStoreReplaceController.m
//  SonyApp
//
//  Created by 陈威利 on 2017/12/8.
//  Copyright © 2017年 Chen. All rights reserved.
//

#import "rootIncludeController.h"


@interface rootIncludeController ()



@end

@implementation rootIncludeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configUI];
}

- (void)configUI{
    __weak typeof(self) weakSelf = self;
    self.view.backgroundColor = [UIColor whiteColor];
    
    
//    self.vc1 = [[subVC1 alloc]init];
//    [self.vc1.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
//
//    [self addChildViewController:self.vc1];
//    self.vc1.block = ^{
//
//        [weakSelf replaceController:weakSelf.currentVC newController:weakSelf.vc2];
//    };
//
//    self.vc2 = [[subVC2 alloc] init];
//    [self.vc2.view setFrame:self.view.bounds];
//    self.vc2.block = ^{
//
//        [weakSelf replaceController:weakSelf.currentVC newController:weakSelf.vc1];
//    };
    
//    [self addChildViewController:self.vc1];
//    //  默认,第一个视图(你会发现,全程就这一个用了addSubview)
//    [self.view addSubview:self.vc1.view];
//    self.currentVC = self.vc1;
}

- (void)inSequence{
    foreoWeakSelf;
    for (NSInteger i = 0; i < _vcArray.count; i++) {
        if (i == 0) {
            subModelForIncludeController *nextModel = _vcArray[i+1];
            subModelForIncludeController *model = _vcArray[i];
            self.currentVC = model.selfViewController;
            RootViewController *vc = model.selfViewController;
            [self addChildViewController:vc];
            [self.view addSubview:vc.view];
            [vc.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            vc.pageChangeActionBlock = ^{

                [weakSelf replaceController:weakSelf.currentVC newController:nextModel.selfViewController];
            };
        }else{
            
            subModelForIncludeController *model = _vcArray[i];
            RootViewController *vc = model.selfViewController;
            [vc.view setFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height)];
            [self addChildViewController:vc];

        }
    }
}



//  切换各个标签内容
- (void)replaceController:(RootViewController *)oldController newController:(RootViewController *)newController
{
    [self addChildViewController:newController];
    [self transitionFromViewController:oldController toViewController:newController duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:nil completion:^(BOOL finished) {
        if (finished) {
            [newController didMoveToParentViewController:self];
            [oldController willMoveToParentViewController:nil];
            [oldController removeFromParentViewController];
            self.currentVC = newController;
        }else{
            self.currentVC = oldController;
        }
    }];
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


