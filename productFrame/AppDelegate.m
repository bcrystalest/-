//
//  AppDelegate.m
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "AppDelegate.h"
#import "newViewController.h"
#import "GuideViewController.h"
#import <UMSocialCore/UMSocialCore.h>
#import <AlipaySDK/AlipaySDK.h>
#import "WXApi.h"
#import "STPPaymentContext.h"

#define kAppDelegate ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface AppDelegate ()<WXApiDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    foreoWeakSelf;
    /*****  strip 集成 *****/
    [[STPPaymentConfiguration sharedConfiguration] setPublishableKey:@"pk_test_6pRNASCoBOKtIshFeQd4XMUh"];

    /* 打开调试日志 */
    [[UMSocialManager defaultManager] openLog:YES];
    
    /* 设置友盟appkey */
    [[UMSocialManager defaultManager] setUmSocialAppkey:@"5628c1d067e58e6f68004a32"];
    
    //设置微信的appKey和appSecret
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:@"wxdc1e388c3822c80b" appSecret:@"3baf1193c85774b3fd9d18447d76cab0" redirectURL:@"http://mobile.umeng.com/social"];
    
    //设置新浪的appKey和appSecret
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:@"3921700954" appSecret:@"04b48b094faeb16683c32669824ebdad" redirectURL:@"http://sns.whalecloud.com/sina2/callback"];
    
   
    /***** 注册微信支付 *****/
    [WXApi registerApp:@"wxb4ba3c02aa476ea1"];

    // 1.创建窗口
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    NSUserDefaults *useDef = [NSUserDefaults standardUserDefaults];
    //判断是否第一次进入
//    if (![useDef objectForKey:@"First2"]) {
//        //第一次进入显示新手引导
////        GuideViewController *guide = [[GuideViewController alloc]init];
//        // 2.设置窗口的根控制器
//        rootIncludeController *vc = [rootIncludeController new];
//        subModelForIncludeController *guideModel = [subModelForIncludeController new];
//        guideModel.selfViewController = [GuideViewController new];
//        subModelForIncludeController *mainPageModel = [subModelForIncludeController new];
//        mainPageModel.selfViewController = [customTabBarController new];
//        vc.vcArray = [NSMutableArray arrayWithObjects:guideModel,mainPageModel, nil];
//        [vc inSequence];
//        self.window.rootViewController = vc;
//
//    }else{
//        //显示主页面
//        newViewController *vc = [newViewController new];
//        // 2.设置窗口的根控制器
//        self.window.rootViewController = vc;
//        vc.block = ^{
////            productMainTabBarController *tabBarVC = [[productMainTabBarController alloc]init];
////            weakSelf.window.rootViewController = tabBarVC;
//        };
//    }
    weakSelf.window.rootViewController = [customTabBarController new];
//    productMainTabBarController *tabBarVC = [[productMainTabBarController alloc]init];
//    weakSelf.window.rootViewController = tabBarVC;
    // 3.显示窗口
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)getUserInfoForPlatform:(UMSocialPlatformType)platformType
{
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:platformType currentViewController:self completion:^(id result, NSError *error) {
        
        UMSocialUserInfoResponse *resp = result;
        
        // 第三方登录数据(为空表示平台未提供)
        // 授权数据
        NSLog(@" uid: %@", resp.uid);
        NSLog(@" openid: %@", resp.openid);
        NSLog(@" accessToken: %@", resp.accessToken);
        NSLog(@" refreshToken: %@", resp.refreshToken);
        NSLog(@" expiration: %@", resp.expiration);
        
        // 用户数据
        NSLog(@" name: %@", resp.name);
        NSLog(@" iconurl: %@", resp.iconurl);
        NSLog(@" gender: %@", resp.unionGender);
        
        // 第三方平台SDK原始数据
        NSLog(@" originalResponse: %@", resp.originalResponse);
    }];
}

// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }else if ([url.host isEqualToString:@"pay"]) {
            // 处理微信的支付结果
            [WXApi handleOpenURL:url delegate:self];
        }
        return YES;
        
        
    }
    return result;
}

- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url
{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

// NOTE: 9.0以后Aplipay使用新API接口
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options
{
    BOOL result = [[UMSocialManager defaultManager]  handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        if ([url.host isEqualToString:@"safepay"]) {
            //跳转支付宝钱包进行支付，处理支付结果
            [[AlipaySDK defaultService] processOrderWithPaymentResult:url standbyCallback:^(NSDictionary *resultDic) {
                NSLog(@"result = %@",resultDic);
            }];
        }else if ([url.host isEqualToString:@"pay"]) {
            // 处理微信的支付结果
            [WXApi handleOpenURL:url delegate:self];
        }
        
        return YES;
    }
    return result;
}

//显示支付结果的
-(void)onResp:(BaseResp*)resp
{
    //启动微信支付的response
    NSString *payResoult = [NSString stringWithFormat:@"errcode:%d", resp.errCode];
    if([resp isKindOfClass:[PayResp class]]){
        //支付返回结果，实际支付结果需要去微信服务器端查询
        switch (resp.errCode) {
            case 0:
                payResoult = @"支付结果：成功！";
                break;
            case -1:
                payResoult = @"支付结果：失败！";
                break;
            case -2:
                payResoult = @"用户已经退出支付！";
                break;
            default:
                payResoult = [NSString stringWithFormat:@"支付结果：失败！retcode = %d, retstr = %@", resp.errCode,resp.errStr];
                break;
        }
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
