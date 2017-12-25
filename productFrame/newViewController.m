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
{
    NSMutableArray *layerArray;
    CGFloat wwidth;
    UIView *centerView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    layerArray = [NSMutableArray new];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationBar];
    [self setNavigationBarTitle:@"whenever" withPopButton:YES];//扫码
    [self setRightButtonWithType:upImgDownText andTitle:@"扫码" andImage:[UIImage imageNamed:@"scan"] andTextFont:11];
    
    centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    centerView.backgroundColor = [UIColor grayColor];
    centerView.center = self.view.center;
    [self.view addSubview:centerView];
    wwidth = centerView.frame.size.width;
    for (NSInteger i = 0; i<8; i++) {
        [self drawCycleWithStart:0.25*i and:i];
    }
//    [self drawcycle];
//    [UIView animateWithDuration:1.0 animations:^{
//        [self goAnimatiom];
//    } completion:^(BOOL finished) {
//        [self goAnimatiom];
//    }];
    
    
}

- (void)drawcycle{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 10;
    //圆环的颜色
    layer.strokeColor = [UIColor redColor].CGColor;
    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //指定线的边缘是圆的
    layer.lineCap = kCALineCapRound;
    //设置半径为10
    CGFloat radius = 200/2.0f - layer.lineWidth/2.0f;
    //按照顺时针方向
    BOOL clockWise = true;
    //初始化一个路径
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200/2.0f, 200/2.0f) radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:clockWise];
    layer.path = [path CGPath];
    [centerView.layer addSublayer:layer];
}

- (void)drawCycleWithStart:(CGFloat )startAngle and:(NSInteger)i{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = 60;
    
    //圆环的颜色
    if (i%2 == 0) {
        layer.strokeColor = [UIColor redColor].CGColor;
    }else{
        layer.strokeColor = [UIColor brownColor].CGColor;
    }

    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //设置半径为10
    CGFloat radius = 50;
    //按照顺时针方向
    BOOL clockWise = true;
    //初始化一个路径
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(200/2.0f, 200/2.0f) radius:radius startAngle:(startAngle+0.003)*M_PI endAngle:(startAngle+0.247)*M_PI clockwise:clockWise];
    //设置线宽

    layer.path = [path CGPath];
    [centerView.layer addSublayer:layer];
    
  

}

- (void)goAnimatiom{
    NSLog(@"goAnimatiom");
        
        CGFloat width = centerView.bounds.size.width;
        if (width == wwidth) {
            width=wwidth*1.5;
        }else{
            width = wwidth;
        }
        centerView.bounds=CGRectMake(centerView.bounds.origin.x, centerView.bounds.origin.y, width, width);

    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClickAction{
    codeScannerVC *scanner = [[codeScannerVC alloc] init];
    [self presentViewController:scanner animated:YES completion:nil];
    scanner.resultBlock = ^(NSString *value) {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:value message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alertView show];
    };
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
