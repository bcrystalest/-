//
//  newViewController.m
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "newViewController.h"

@interface newViewController ()<UIAlertViewDelegate>
@property (nonatomic, strong) CALayer *gradientLayer;
@property (nonatomic, strong) UIView *touchGetView;
@property (nonatomic, strong) UIButton *scanButton;
@property (nonatomic, assign)BOOL isSelected;
@end

@implementation newViewController
{
    UIView *mainImageView;
    NSMutableArray *layerArray;
    NSMutableArray *imageIconArray;
    CGFloat wwidth;
    UIView *centerView;
    UIImageView *testView;
    CAShapeLayer *judgeLayer;
    CGRect basicFrame;
    NSInteger willBeChangedModelID;
    BOOL isStart;
}
- (UIButton *)scanButton{
    if (_scanButton == nil) {
        _scanButton = [UIButton new];
        [_scanButton setImage:[UIImage imageNamed:@"scanButton"] forState:UIControlStateNormal];
        [_scanButton setImage:[UIImage imageNamed:@"scanButton"] forState:UIControlStateSelected];
        [_scanButton addTarget:self action:@selector(beginScan) forControlEvents:UIControlEventTouchUpInside];
    }
    return _scanButton;
}

- (UIView *)touchGetView{
    if (_touchGetView == nil) {
        _touchGetView = [UIView new];
        CGFloat width = SCREEN_WIDTH - 83;
        _touchGetView.frame = CGRectMake(0, 0, width, width);
        _touchGetView.center = self.view.center;
        _touchGetView.backgroundColor = [UIColor clearColor];
    }
    return _touchGetView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configUI];
    // Do any additional setup after loading the view.
    
}

- (void)configUI{
    foreoWeakSelf;
    layerArray = [NSMutableArray new];
    self.view.backgroundColor = [UIColor whiteColor];
    [self addNavigationBar];
    [self setNavigationBarTitle:@"我的 U F O" color:[UIColor colorWithRed:0.882 green:0.122 blue:0.522 alpha:1.00] font:[UIFont systemFontOfSize:18] withPopButton:YES];
    [self setRightButtonWithType:onlyImg andTitle:nil andImage:[UIImage imageNamed:@"menu"] andTextFont:11];
    
    //    centerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
    //    centerView.backgroundColor = [UIColor grayColor];
    //    centerView.center = self.view.center;
    //    [self.view addSubview:centerView];
    imageIconArray = [NSMutableArray new];
    for (NSInteger i = 0; i<8; i++) {
        [self drawCycleWithStart:0.25*i and:i andGap:0.001];
    }
    
    //    [self drawcycle];
    //    [UIView animateWithDuration:1.0 animations:^{
    //        [self goAnimatiom];
    //    } completion:^(BOOL finished) {
    //        [self goAnimatiom];
    //    }];
    
    //    mainImageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_WIDTH)];
    //    mainImageView.center = self.view.center;
    //    [self.view addSubview:mainImageView];
    //    mainImageView.image = [UIImage imageNamed:@"1703326970"];
    //    mainImageView.contentMode = UIViewContentModeScaleAspectFit;
    
    [self.view addSubview:self.touchGetView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(judge:)];
    [self.touchGetView addGestureRecognizer:tap];
    
    CGFloat r = (SCREEN_WIDTH - 135)/2;
    CGPoint centerPoint = self.view.center;
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 10, 10)];
    //    image.image = [UIImage imageNamed:@"xz"];
    image.backgroundColor = [UIColor blackColor];
    image.center = centerPoint;
    [self.view addSubview:image];
    
    CGFloat centerPointX = centerPoint.x;
    CGFloat centerPointY = centerPoint.y;
    
    CGFloat x = r*sin(M_PI/(180/22.5));
    
    if (x<0) {
        x=-x;
    }
    CGFloat y = r*cos(M_PI/(180/22.5));
    if (y<0) {
        y=-y;
    }
    
    CGPoint centerPoint1 = CGPointMake(centerPointX + x, centerPointY - y);
    CGPoint centerPoint2 = CGPointMake(centerPointX + y, centerPointY - x);
    CGPoint centerPoint3 = CGPointMake(centerPointX + x, centerPointY + y);
    CGPoint centerPoint4 = CGPointMake(centerPointX + y, centerPointY + x);
    CGPoint centerPoint5 = CGPointMake(centerPointX - x, centerPointY + y);
    CGPoint centerPoint6 = CGPointMake(centerPointX - y, centerPointY + x);
    CGPoint centerPoint7 = CGPointMake(centerPointX - x, centerPointY - y);
    CGPoint centerPoint8 = CGPointMake(centerPointX - y, centerPointY - x);
    NSArray *array = [[NSArray alloc]initWithObjects:[NSValue valueWithCGPoint:centerPoint1],[NSValue valueWithCGPoint:centerPoint2],[NSValue valueWithCGPoint:centerPoint4],[NSValue valueWithCGPoint:centerPoint3],[NSValue valueWithCGPoint:centerPoint5],[NSValue valueWithCGPoint:centerPoint6],[NSValue valueWithCGPoint:centerPoint8],[NSValue valueWithCGPoint:centerPoint7], nil];
    for (NSInteger i = 0; i < 8; i++) {
        UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 30, 30)];
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"number_H_%ld",(long)(i)]];
        NSValue *value = array[i];
        CGPoint point = [value CGPointValue];
        image.center = point;
        [self.view addSubview:image];
        [imageIconArray addObject:image];
        
    }
    
    
    testView = [UIImageView new];
    testView.userInteractionEnabled = YES;
    testView.frame = CGRectMake(self.view.center.x-40, SCREEN_HEIGHT-180, 50, 50);
    testView.backgroundColor = [UIColor redColor];
    testView.contentMode = UIViewContentModeScaleAspectFit;
    testView.image = [UIImage imageNamed:@"number_0"];
    [self.view addSubview:testView];
    testView.hidden = YES;
    
    basicFrame = CGRectMake(self.view.center.x-40, SCREEN_HEIGHT-180, 50, 50);
    
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(judge2:)];
    [testView addGestureRecognizer:pan];
    
    
    //    UIPanGestureRecognizer *pan2 = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(actionStart:)];
    //    [testView addGestureRecognizer:pan2];
    //    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(actionStart)];
    //    [testView addGestureRecognizer:tap];
    
    [self.view addSubview:self.scanButton];
    [_scanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.touchGetView.mas_bottom).offset(10);
        make.centerX.equalTo(weakSelf.view.mas_centerX);
        make.width.height.mas_equalTo(40);
    }];
    
}
- (void)judge:(UITapGestureRecognizer *)recognizer{
    CGPoint translation = [recognizer locationInView:self.touchGetView];
    CGFloat x = (SCREEN_WIDTH - 83)/2;
    CGFloat y = (SCREEN_WIDTH - 83)/2;
    
    CGFloat trueX = fabs(x-translation.x);
    CGFloat trueY = fabs(y-translation.y);
    
    if ((trueX*trueX +trueY*trueY) < ((SCREEN_WIDTH - 15)/2)*((SCREEN_WIDTH - 15)/2)) {
        NSLog(@"true,接触");
        if (x-translation.x>0 && y-translation.y > 0) {
            if (trueX>trueY) {
                NSLog(@"7区");
                [self showNormalAlert:6];
            }else{
                NSLog(@"8区");
                [self showNormalAlert:7];
            }
            
        }else if (x-translation.x>0 && y-translation.y < 0){
            if (trueX>trueY) {
                NSLog(@"6区");
                [self showNormalAlert:5];
            }else{
                NSLog(@"5区");
                [self showNormalAlert:4];
            }
        }else if (x-translation.x<0 && y-translation.y > 0){
            if (trueX>trueY) {
                NSLog(@"2区");
                [self showNormalAlert:1];
            }else{
                NSLog(@"1区");
                [self showNormalAlert:0];
            }
        }else{
            if (trueX>trueY) {
                NSLog(@"3区");
                [self showNormalAlert:2];
            }else{
                NSLog(@"4区");
                [self showNormalAlert:3];
            }
        }
    }else{
        NSLog(@"false,未接触");
    }
}

- (void)judge2:(UIPanGestureRecognizer *)recognizer{
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        if (isStart == NO) {
            [self beginShark];
            isStart = YES;
        }
    }
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointZero inView:self.view];
    CGPoint centerPoint = self.view.center;
    CGFloat x = centerPoint.x;
    CGFloat y = centerPoint.y;
    CGFloat trueX = fabs(x-recognizer.view.center.x);
    CGFloat trueY = fabs(y-recognizer.view.center.y);
    
    if ((trueX*trueX +trueY*trueY) < (SCREEN_WIDTH/2+25)*(SCREEN_WIDTH/2+25)) {
        NSLog(@"true,接触");
        
        if (x-recognizer.view.center.x>0 && y-recognizer.view.center.y > 0) {
            if (trueX>trueY) {
                NSLog(@"7区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:6];
            }else{
                NSLog(@"8区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:7];
            }
            
        }else if (x-recognizer.view.center.x>0 && y-recognizer.view.center.y < 0){
            if (trueX>trueY) {
                NSLog(@"6区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:5];
            }else{
                NSLog(@"5区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:4];
            }
        }else if (x-recognizer.view.center.x<0 && y-recognizer.view.center.y > 0){
            if (trueX>trueY) {
                NSLog(@"2区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:1];
            }else{
                NSLog(@"1区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:0];
            }
        }else{
            if (trueX>trueY) {
                NSLog(@"3区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:2];
            }else{
                NSLog(@"4区");
                if (recognizer.state != UIGestureRecognizerStateEnded) {
                    return;
                }
                [self showAlert:3];
            }
        }
    }else{
        NSLog(@"false,未接触");
        if (recognizer.state != UIGestureRecognizerStateEnded) {
            return;
        }
        [UIView animateWithDuration:0.3 animations:^{
            testView.frame = basicFrame;
        }];
    }
    
}

- (void)showAlert:(NSInteger)i{
    testView.hidden = YES;
    willBeChangedModelID = i;
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您即将要将%ld号模式进行更新",i+1] delegate:self cancelButtonTitle:@"好" otherButtonTitles:@"取消",nil];
    alertView.tag = 1001;
    [alertView show];
    
}


- (void)showNormalAlert:(NSInteger)i{

    for (NSInteger j = 0; j<imageIconArray.count; j++) {
        UIImageView *imageView = imageIconArray[j];
        if (j==i) {
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"number_%ld",j]];
        }else{
            imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"number_H_%ld",j]];
        }
    }
//    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"您已点选了第%ld块区域",i+1] delegate:self cancelButtonTitle:@"好" otherButtonTitles:nil];
//    alertView.tag = 1002;
//    [alertView show];
    
}

//根据被点击按钮的索引处理点击事件
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 1001) {
        if (buttonIndex == 0) {
            UIImageView *imageView = imageIconArray[willBeChangedModelID];
            imageView.image = testView.image;
            
            [self endShark];
        }else{
            testView.hidden = NO;
            [UIView animateWithDuration:0.3 animations:^{
                testView.frame = basicFrame;
            }];
        }
        NSLog(@"clickButtonAtIndex:%ld",(long)buttonIndex);
    }else if (alertView.tag == 1002){
        
    }
    
}


//- (void)drawcycle{
//    CAShapeLayer *layer = [CAShapeLayer new];
//    layer.lineWidth = 10;
//    //圆环的颜色
//    layer.strokeColor = [UIColor redColor].CGColor;
//    //背景填充色
//    layer.fillColor = [UIColor clearColor].CGColor;
//    //指定线的边缘是圆的
//    layer.lineCap = kCALineCapRound;
//    //设置半径为10
//    CGFloat radius = 200/2.0f - layer.lineWidth/2.0f;
//    //按照顺时针方向
//    BOOL clockWise = true;
//    //初始化一个路径
//    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:(-0.5f*M_PI) endAngle:1.5f*M_PI clockwise:clockWise];
//    layer.path = [path CGPath];
//    [self.view.layer addSublayer:layer];
//
//    //生成渐变色
//    _gradientLayer = [CALayer layer];
//
//    //左侧渐变色
//    CAGradientLayer *leftLayer = [CAGradientLayer layer];
//    leftLayer.frame = CGRectMake(self.view.center.x-SCREEN_WIDTH/4, self.view.center.y-SCREEN_WIDTH/4, SCREEN_WIDTH / 2, SCREEN_WIDTH);    // 分段设置渐变色
//    leftLayer.locations = @[@0.3, @0.9, @1];
//    leftLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor greenColor].CGColor];
//    [_gradientLayer addSublayer:leftLayer];
//
//    //右侧渐变色
//    CAGradientLayer *rightLayer = [CAGradientLayer layer];
//    rightLayer.frame = CGRectMake(self.view.center.x+SCREEN_WIDTH/4, self.view.center.y-SCREEN_WIDTH/4, SCREEN_WIDTH/2, SCREEN_WIDTH);
//    rightLayer.locations = @[@0.3, @0.9, @1];
//    rightLayer.colors = @[(id)[UIColor yellowColor].CGColor, (id)[UIColor redColor].CGColor];
//    [_gradientLayer addSublayer:rightLayer];
//
//    [self.view.layer setMask:layer]; //用progressLayer来截取渐变层
//    [self.view.layer addSublayer:_gradientLayer];
//}

- (void)drawCycleWithStart:(CGFloat )startAngle and:(NSInteger)i andGap:(CGFloat)gap{
    CAShapeLayer *layer = [CAShapeLayer new];
    layer.lineWidth = SCREEN_WIDTH/3/2.5;
    //圆环的颜色
//    if (i%2 == 0) {
//        layer.strokeColor = [UIColor redColor].CGColor;
//    }else{
//        layer.strokeColor = [UIColor brownColor].CGColor;
//    }
    layer.strokeColor = [UIColor colorWithRed:0.969 green:0.765 blue:0.898 alpha:1.00].CGColor;
    //背景填充色
    layer.fillColor = [UIColor clearColor].CGColor;
    //设置半径为10
    CGFloat radius = SCREEN_WIDTH/3;
    //按照顺时针方向
    BOOL clockWise = true;
    //初始化一个路径
    
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.view.center radius:radius startAngle:(startAngle+gap)*M_PI endAngle:(startAngle+0.25-gap)*M_PI clockwise:clockWise];

    layer.path = [path CGPath];
    [layerArray addObject:layer];
    [self.view.layer addSublayer:layer];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)rightClickAction{
//    codeScannerVC *scanner = [[codeScannerVC alloc] init];
//    [self presentViewController:scanner animated:YES completion:nil];
//    scanner.resultBlock = ^(NSString *value) {
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:value message:@"" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
//        [alertView show];
//    };
    [self beginScan];
}

- (void)beginScan{
    [SVProgressHUD setBackgroundColor:[UIColor lightGrayColor]];
    [SVProgressHUD showWithStatus:@"模拟扫描中"];
    [SVProgressHUD dismissWithDelay:1.0f completion:^{
        testView.hidden = NO;
    }];
}

- (void)beginShark{
//    for (UIImageView *imageView in imageIconArray) {
//        srand([[NSDate date] timeIntervalSince1970]);
//        float rand=(float)random();
//        CFTimeInterval t=rand*0.0000000001;
//        [UIView animateWithDuration:0.2 delay:t options:0  animations:^{
//            imageView.transform = CGAffineTransformMakeScale(0.9, 0.9);
//        } completion:^(BOOL finished) {
//            [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
//             {
//                 imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
//             } completion:^(BOOL finished) {}];
//        }];
//
//    }
    
    
    
    for (UIImageView *imageView in imageIconArray) {
        srand([[NSDate date] timeIntervalSince1970]);
        float rand=(float)random();
        CFTimeInterval t=rand*0.0000000001;

        [UIView animateWithDuration:0.1 delay:t options:0  animations:^
         {
             imageView.transform=CGAffineTransformMakeRotation(-0.1);
         } completion:^(BOOL finished)
         {
             [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionRepeat|UIViewAnimationOptionAutoreverse|UIViewAnimationOptionAllowUserInteraction  animations:^
              {
                  imageView.transform=CGAffineTransformMakeRotation(0.1);
              } completion:^(BOOL finished) {}];
         }];
    }
}
-(void)endShark
{
    for (UIImageView *imageView in imageIconArray) {
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionAllowUserInteraction|UIViewAnimationOptionBeginFromCurrentState animations:^
         {
             imageView.transform = CGAffineTransformMakeScale(1.0, 1.0);
             imageView.transform=CGAffineTransformIdentity;
         } completion:^(BOOL finished) {}];
    }
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
