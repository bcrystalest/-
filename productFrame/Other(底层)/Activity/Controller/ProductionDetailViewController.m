//
//  ProductionDetailViewController.m
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "ProductionDetailViewController.h"
#import "payView.h"
#import "NSString+MD5.h"
#import "WXApi.h"
#import <AlipaySDK/AlipaySDK.h>
#import "Alipay.h"


@interface ProductionDetailViewController ()<WXApiDelegate>

//商户关键信息 ,微信分配给商户的appID,商户号,商户的密钥
@property (nonatomic,strong) NSString *appId,*mchId,*spKey;

@property (nonatomic, strong) payView *payView;

@end

@implementation ProductionDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor = [UIColor whiteColor];
    
    [self setNavigationBarTitle:@"production" withPopButton:YES];

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
    
    if([WXApi isWXAppInstalled]){
        // 监听一个通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(getOrderPayResult:) name:@"ORDER_PAY_NOTIFICATION" object:nil];
    }
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
        [self wechatPay];
    }else if (type == FOPayTypeAlipay){
        NSLog(@"alipay");
        [self apliPay];
    }else if (type == FOPayTypeStripe){
        NSLog(@"stripe");
    }
}

- (void)buy:(UIButton *)sender{
    NSLog(@"buy");
    [self.view addSubview:self.payView];
    [self.payView show];
}

#pragma mark - alipay

- (void)apliPay{
    
    // 重要说明
    // 这里只是为了方便直接向商户展示支付宝的整个支付流程；所以Demo中加签过程直接放在客户端完成；
    // 真实App里，privateKey等数据严禁放在客户端，加签过程务必要放在服务端完成；
    // 防止商户私密数据泄露，造成不必要的资金损失，及面临各种安全风险；
    /*============================================================================*/
    /*=======================需要填写商户app申请的===================================*/
    /*============================================================================*/
    NSString *appID = @"";
    
    // 如下私钥，rsa2PrivateKey 或者 rsaPrivateKey 只需要填入一个
    // 如果商户两个都设置了，优先使用 rsa2PrivateKey
    // rsa2PrivateKey 可以保证商户交易在更加安全的环境下进行，建议使用 rsa2PrivateKey
    // 获取 rsa2PrivateKey，建议使用支付宝提供的公私钥生成工具生成，
    // 工具地址：https://doc.open.alipay.com/docs/doc.htm?treeId=291&articleId=106097&docType=1
    NSString *rsa2PrivateKey = @"";
    NSString *rsaPrivateKey = @"";
    /*============================================================================*/
    /*============================================================================*/
    /*============================================================================*/
    
    //partner和seller获取失败,提示
    if ([appID length] == 0 ||
        ([rsa2PrivateKey length] == 0 && [rsaPrivateKey length] == 0))
    {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示"
                                                                       message:@"缺少appId或者私钥,请检查参数设置"
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"知道了"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action){
                                                           
                                                       }];
        [alert addAction:action];
        [self presentViewController:alert animated:YES completion:^{ }];
        return;
    }
    
    /*
     *生成订单信息及签名
     */
    //将商品信息赋予AlixPayOrder的成员变量
    Alipay *order = [Alipay new];
    order.appID= appID;
//
    order.outTradeNO = @""; //订单ID（由商家自行制定）
    order.subject = @""; //商品标题
    order.body = @""; //商品描述
    order.totalFee = @""; //商品价格
    order.notifyURL =  @""; //回调URL
    order.service = @"mobile.securitypay.pay";
    order.paymentType = @"1";
    order.inputCharset = @"utf-8";
    order.itBPay = @"30m";
    order.showURL = @"m.alipay.com";
    

    //将商品信息拼接成字符串
    NSString *orderInfo = [order description];

    // NOTE: 获取私钥并将商户信息签名，外部商户的加签过程请务必放在服务端，防止公私钥数据泄露；
    //       需要遵循RSA签名规范，并将签名字符串base64编码和UrlEncode
//    NSString *signedString = nil;
//    APRSASigner* signer = [[APRSASigner alloc] initWithPrivateKey:((rsa2PrivateKey.length > 1)?rsa2PrivateKey:rsaPrivateKey)];
//    if ((rsa2PrivateKey.length > 1)) {
//        signedString = [signer signString:orderInfo withRSA2:YES];
//    } else {
//        signedString = [signer signString:orderInfo withRSA2:NO];
//    }

    // NOTE: 如果加签成功，则继续执行支付
//    if (signedString != nil) {
//        //应用注册scheme,在AliSDKDemo-Info.plist定义URL types
//        NSString *appScheme = @"alisdkdemo";
//
//        // NOTE: 将签名成功字符串格式化为订单字符串,请严格按照该格式
//        NSString *orderString = [NSString stringWithFormat:@"%@&sign=%@",
//                                 orderInfo, signedString];

        // NOTE: 调用支付结果开始支付
//        [[AlipaySDK defaultService] payOrder:orderString fromScheme:appScheme callback:^(NSDictionary *resultDic) {
//            NSLog(@"reslut = %@",resultDic);
//        }];
//    }


}


#pragma mark - wechatpay

/**
*
*  http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php为测试数据,一般可以从这儿拿到的数据都可以让服务器端去完成,客户端只需获取到然后配置到PayReq,即可吊起微信;
*/
-(void)wechatPay{
    
    /***** 模拟支付 *****/

    //调起微信支付
    PayReq* req             = [[PayReq alloc] init];
    req.partnerId           = @"1900000109";
    req.prepayId            = @"WX1217752501201407033233368018";
    req.nonceStr            = @"5K8264ILTKCH16CQ2502SI8ZNMTM67VS";
    req.timeStamp           = 1412000000;
    req.package             = @"Sign=WXPay";
    req.sign                = @"9A0A8659F005D6984697E2CA0A9CF3B7";
    [WXApi sendReq:req];
   
}

//真实生成订单走这个方法
- (void)bizPay {
    NSString *res = [self jumpToBizPay];
    if( ![@"" isEqual:res] ){
        UIAlertView *alter = [[UIAlertView alloc] initWithTitle:@"支付失败" message:res delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        [alter show];
    }
    
}
-(NSString *)jumpToBizPay{

    NSString *urlString   = @"http://wxpay.weixin.qq.com/pub_v2/app/app_pay.php?plat=ios";
    //解析服务端返回json数据
    NSError *error;
    //加载一个NSURL对象
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    //将请求的url数据放到NSData对象中
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    if ( response != nil) {
        
        NSMutableDictionary *dict = NULL;
        //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
        dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
        
        NSLog(@"url:%@",urlString);
        if(dict != nil){
            NSMutableString *retcode = [dict objectForKey:@"retcode"];
            if (retcode.intValue == 0){
                NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
                
                
                //调起微信支付
                PayReq* req             = [[PayReq alloc] init];
                req.partnerId           = [dict objectForKey:@"partnerid"];
                req.prepayId            = [dict objectForKey:@"prepayid"];
                req.nonceStr            = [dict objectForKey:@"noncestr"];
                req.timeStamp           = stamp.intValue;
                req.package             = [dict objectForKey:@"package"];
                req.sign                = [dict objectForKey:@"sign"];
                [WXApi sendReq:req];
                //日志输出
                NSLog(@"appid=%@\npartid=%@\nprepayid=%@\nnoncestr=%@\ntimestamp=%ld\npackage=%@\nsign=%@",[dict objectForKey:@"appid"],req.partnerId,req.prepayId,req.nonceStr,(long)req.timeStamp,req.package,req.sign );
                return @"";
            }else{
                return [dict objectForKey:@"retmsg"];
            }
        }else{
            return @"服务器返回错误，未获取到json对象";
        }
    }else{
        return @"服务器返回错误";
    }
}

#pragma mark - 收到支付成功的消息后作相应的处理
- (void)getOrderPayResult:(NSNotification *)notification
{
    if ([notification.object isEqualToString:@"success"]) {
        NSLog(@"支付成功");
    } else {
        NSLog(@"支付失败");
    }
    
}



#pragma mark -- ***************************************
//有的服务器没有对sign字段进行二次签名,需要客户端进行,下面这些是对吊起支付时的sign字段进行二次签名的,这些操作可以和服务器协商全让服务器做了,因为签名算法都是一样的,后台已经进行了第一次的签名,第二次只是多了prePayid,算法都是一样的没必要客户端再写一次算法

//注意:下面的方法不能直接使用,这里只是给出了算法和参数配置,相应的填充数据就行
//创建package签名
-(NSString*) createMd5Sign:(NSMutableDictionary*)dict
{
    NSMutableString *contentString  =[NSMutableString string];
    NSArray *keys = [dict allKeys];
    //按字母顺序排序
    NSArray *sortedArray = [keys sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        return [obj1 compare:obj2 options:NSNumericSearch];
    }];
    //拼接字符串
    for (NSString *categoryId in sortedArray) {
        if (   ![[dict objectForKey:categoryId] isEqualToString:@""]
            && ![categoryId isEqualToString:@"sign"]
            && ![categoryId isEqualToString:@"key"]
            )
        {
            [contentString appendFormat:@"%@=%@&", categoryId, [dict objectForKey:categoryId]];
        }
        
    }
    //添加key字段
    [contentString appendFormat:@"key=%@", self.spKey];
    //得到MD5 sign签名
    NSString *md5Sign =[contentString MD5];
    
    return md5Sign;
}

- (NSMutableDictionary*)payWithprePayid:(NSString*)prePayid

{
    if(prePayid == nil)
    {
        NSLog(@"prePayid 为空");
        return nil;
    }
    
    //获取到prepayid后进行第二次签名
    NSString    *package, *time_stamp, *nonce_str;
    //设置支付参数
    time_t now;
    time(&now);
    time_stamp  = [NSString stringWithFormat:@"%ld", now];
    nonce_str = [time_stamp MD5];
    //重新按提交格式组包，微信客户端暂只支持package=Sign=WXPay格式，须考虑升级后支持携带package具体参数的情况
    //package       = [NSString stringWithFormat:@"Sign=%@",package];
    package         = @"Sign=WXPay";
    //第二次签名参数列表
    NSMutableDictionary *signParams = [NSMutableDictionary dictionary];
    NSLog(@"%@",signParams);
    [signParams setObject: self.appId  forKey:@"appid"];
    [signParams setObject: self.mchId  forKey:@"partnerid"];
    [signParams setObject: nonce_str    forKey:@"noncestr"];
    [signParams setObject: package      forKey:@"package"];
    [signParams setObject: time_stamp   forKey:@"timestamp"];
    [signParams setObject: prePayid     forKey:@"prepayid"];
    
    //生成签名
    // NSString *sign  = @"7175C293D3F706F4B40EAD092A3FBAB8";
    NSString *sign  = [self createMd5Sign:signParams];
    
    //添加签名
    [signParams setObject: sign         forKey:@"sign"];
    
    
    //返回参数列表
    return signParams;
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
