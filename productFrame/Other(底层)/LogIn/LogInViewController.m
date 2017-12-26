//
//  LogInViewController.m
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "LogInViewController.h"
#import <UMSocialCore/UMSocialCore.h>

@interface LogInViewController ()

@end

@implementation LogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.view.backgroundColor = RGBA(40, 40, 40,1);
    [self.navigationController setNavigationBarHidden:YES];

    [self creatView];
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void)creatView
{
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(0, 10, 50, 40);
    [backButton setImage:[UIImage imageNamed:@"btn_login_quite.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(tapTheBackButton:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
    
    UILabel *alertLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, 10, 200, 40)];
    alertLabel.text = @"请登录";
    alertLabel.textColor = [UIColor whiteColor];
    alertLabel.font = [UIFont systemFontOfSize:20];
    alertLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:alertLabel];
    
    UIButton *logInButton = [UIButton buttonWithType:UIButtonTypeCustom];
    logInButton.frame = CGRectMake(SCREEN_WIDTH/2 - 120, alertLabel.bottom + 69, 240, 32);
    [self.view addSubview:logInButton];
    [logInButton setBackgroundImage:[[UIImage imageNamed:@"image_yellow_round.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5,20,5,20)]  forState:UIControlStateNormal];
//    [logInButton addTarget:self action:@selector(pushLogIn:) forControlEvents:UIControlEventTouchUpInside];
    [logInButton setTitle:@"手机号登录" forState:UIControlStateNormal];
    [logInButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    UIButton *registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    registerButton.frame = CGRectMake(SCREEN_WIDTH/2 - 120, logInButton.bottom + 25, 240, 32);
    [self.view addSubview:registerButton];
    [registerButton setBackgroundImage:[[UIImage imageNamed:@"img_white_round.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(5,20,5,20)] forState:UIControlStateNormal];
//    [registerButton addTarget:self action:@selector(pushRegister:) forControlEvents:UIControlEventTouchUpInside];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton setTitleColor:RGBA(222, 168, 0,1) forState:UIControlStateNormal];
    
    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 100, SCREEN_HEIGHT/2, 200, 1)];
    lineLabel.backgroundColor = RGBA(124, 122, 116,1);
    [self.view addSubview:lineLabel];
    
    UILabel *thirdLoginLabel = [[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 45, SCREEN_HEIGHT/2 - 10, 90, 20)];
    thirdLoginLabel.textColor = RGBA(205, 205, 205,1);
    thirdLoginLabel.font = [UIFont systemFontOfSize:10];
    thirdLoginLabel.textAlignment = NSTextAlignmentCenter;
    thirdLoginLabel.text = @"第三方登录";
    thirdLoginLabel.backgroundColor = RGBA(40, 40, 40, 1);
    [self.view addSubview:thirdLoginLabel];
    
    
    NSArray *icons = @[@"icon_thirdlogin_microblog.png",
                       @"btn_thirdlogin_wechat.png"];
    
    
    UIView *thirdLoginView = [[UIView alloc] initWithFrame:CGRectMake(SCREEN_WIDTH/2 - 130, thirdLoginLabel.bottom + 10, 260, 170)];
    [self.view addSubview:thirdLoginView];
    
    int columns = 2;
    int thirdCount = 2;
    CGFloat thirdButtonSize = 80.0f;
    //间距
    CGFloat margin = (thirdLoginView.width - columns * thirdButtonSize) / (columns + 1);
    
    thirdLoginView.height = margin + 2 * thirdButtonSize;
    
    CGFloat oneY = 0;
    CGFloat oneX = margin;
    for (int i = 0; i<thirdCount; i++) {
        int col = i % columns;
        int row = i / columns;
        
        CGFloat x = oneX + col * (thirdButtonSize + margin);
        CGFloat y = oneY + row * (thirdButtonSize + margin);
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(x, y, thirdButtonSize, thirdButtonSize);
        button.tag = 100 + i;
        [button setImage:[UIImage imageNamed:icons[i]] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(thirdLogin:) forControlEvents:UIControlEventTouchUpInside];
        [thirdLoginView addSubview:button];
    }
    
    UILabel *testLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, thirdLoginView.bottom + 10, SCREEN_WIDTH, 30)];
    testLabel.textAlignment = NSTextAlignmentCenter;
    
    NSMutableAttributedString *AttributedStr = [[NSMutableAttributedString alloc]initWithString:@"登录即代表你同意《XXXX使用协议》"];
    
    [AttributedStr addAttribute:NSFontAttributeName
     
                          value:[UIFont systemFontOfSize:12.0]
     
                          range:NSMakeRange(0, AttributedStr.length)];
    
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:RGBA(222, 168, 0,1)
     
                          range:NSMakeRange(9, 8)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor whiteColor]
     
                          range:NSMakeRange(0, 9)];
    
    [AttributedStr addAttribute:NSForegroundColorAttributeName
     
                          value:[UIColor whiteColor]
     
                          range:NSMakeRange(17, 1)];
    
    [AttributedStr addAttribute:NSUnderlineStyleAttributeName value:@(1) range:NSMakeRange(9, 8)];
    [AttributedStr addAttribute:NSUnderlineColorAttributeName value:RGBA(222, 168, 0,1) range:NSMakeRange(9, 8)];
    
//        [AttributedStr addAttribute:NSLinkAttributeName
//                                    value:@"http://www.cnblogs.com/sunyaxue/p/5580807.html"
//                                    range:[[AttributedStr string] rangeOfString:@"上海图淘使用协议"]];
    
    testLabel.attributedText = AttributedStr;
    
    [self.view addSubview:testLabel];
    
}

- (void)thirdLogin:(UIButton *)sender{
    NSInteger buttonTag = sender.tag;
    
    switch (buttonTag) {

        case 100:{
            //weibo
            [self getUserInfoForPlatform:UMSocialPlatformType_Sina];
        }
            break;
        case 101:{
            //weixin
            [self getUserInfoForPlatform:UMSocialPlatformType_WechatSession];
        }

        default:
            break;
    }
}

- (void)getUserInfoForPlatform:(UMSocialPlatformType)type
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        if (error) {
            NSLog(@"%@",error);
        } else {
            NSMutableDictionary *userDic = [NSMutableDictionary dictionary];
            
            UMSocialUserInfoResponse *resp = result;
            [userDic setValue:resp.openid ? resp.openid : @" " forKey:@"openid"];
            [userDic setValue:resp.name forKey:@"nickname"];
            [userDic setValue:resp.gender forKey:@"gender"];
            [userDic setValue:@"CN" forKey:@"location"];
            [userDic setValue:resp.iconurl forKey:@"profile_image_url"];
            [userDic setValue:resp.accessToken forKey:@"access_token"];
            [userDic setValue:resp.refreshToken ? resp.refreshToken : @" " forKey:@"refresh_token"];
            [userDic setValue:@" " forKey:@"description"];
            
            if (type == UMSocialPlatformType_QQ) {
                
            }else if (type == UMSocialPlatformType_Sina){
                
                [userDic setValue:resp.name forKey:@"description"];
            }else if (type == UMSocialPlatformType_WechatSession){
                
            }else if (type == UMSocialPlatformType_Twitter){
                
            }else if (type == UMSocialPlatformType_Facebook){
                
            }
            
//            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationUserLogin object:nil];
            
                        
            
            // 授权信息
                        NSLog(@"Wechat uid: %@", resp.uid);
                        NSLog(@"Wechat openid: %@", resp.openid);
                        NSLog(@"Wechat accessToken: %@", resp.accessToken);
                        NSLog(@"Wechat refreshToken: %@", resp.refreshToken);
                        NSLog(@"Wechat expiration: %@", resp.expiration);
            
            // 用户信息
                        NSLog(@"Wechat name: %@", resp.name);
                        NSLog(@"Wechat iconurl: %@", resp.iconurl);
                        NSLog(@"Wechat gender: %@", resp.gender);
            
            // 第三方平台SDK源数据
                        NSLog(@"Wechat originalResponse: %@", resp.originalResponse);
        }
    }];
}

- (void)tapTheBackButton:(UIButton *)sender{
    [self dismissViewControllerAnimated:YES completion:^{
        
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
