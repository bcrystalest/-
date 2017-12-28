//
//  ProductionDetailViewController.m
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "ProductionDetailViewController.h"
#import "payView.h"

@interface ProductionDetailViewController ()

@property (nonatomic, strong) payView *payView;

@end

@implementation ProductionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    [self setNavigationBarTitle:@"production" color:[UIColor blackColor] font:[UIFont systemFontOfSize:14] withPopButton:YES];

    UIImageView *productionImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 68, SCREEN_WIDTH, 300)];
    productionImage.image = [UIImage imageNamed:@"foreo1.png"];
    productionImage.contentMode = UIViewContentModeScaleAspectFit;
    [self.view addSubview:productionImage];
    
    UIButton *buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    buyButton.frame = CGRectMake(0, SCREEN_HEIGHT - 50, SCREEN_WIDTH, 50);
    [buyButton setTitle:@"Buy" forState:UIControlStateNormal];
    [self.view addSubview:buyButton];
    [buyButton addTarget:self action:@selector(buy:) forControlEvents:UIControlEventTouchUpInside];
//    [buyButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [buyButton setBackgroundColor:[UIColor orangeColor]];
}

- (payView *)payView{
    if (!_payView) {
        _payView = [[payView alloc] initWithFrame:self.view.bounds];
        WS(weakSelf)
        
        _payView.shareType = ^ (FOPayType type){
            [weakSelf shareOnPlatform:type];
        };
        
        _payView.clicked = ^ (payView *payView, NSInteger buttonIndex){
            if (buttonIndex == 0) {
                [weakSelf payViewDismiss];
            }else{
                
            }
        };
    }
    return _payView;
}

- (void)payViewDismiss{
    [self.payView dismissCompletion:^(BOOL finished) {
        [self.payView removeFromSuperview];
        self.payView = nil;
    }];
}

- (void)shareOnPlatform:(FOPayType )type{
    if (type == FOPayTypeWeChat) {
        NSLog(@"wechatPay");
    }else if (type == FOPayTypeAlipay){
        NSLog(@"alipay");
    }else if (type == FOPayTypeStripe){
        NSLog(@"stripe");
    }
}



- (void)buy:(UIButton *)sender{
    NSLog(@"buy");
    [self.view addSubview:self.payView];
    [self.payView show];
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
