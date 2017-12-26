//
//  ActivityViewController.m
//  productFrame
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "ActivityViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "ActivityCollectionViewCell.h"
#import "LogInViewController.h"
#import "ShareView.h"
#import <UMSocialCore/UMSocialCore.h>

@interface ActivityViewController ()<UICollectionViewDataSource,UICollectionViewDataSource,CHTCollectionViewDelegateWaterfallLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) ShareView *shareView;

@end

@implementation ActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarTitle:@"activity" withPopButton:NO];
        
    CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    layout.columnCount = 2;
    layout.sectionInset = UIEdgeInsetsMake(5, 5, 5, 5);
    layout.minimumColumnSpacing = 5;
    layout.minimumInteritemSpacing = 5;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 64,SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.alwaysBounceVertical = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.backgroundColor = RGBA(240, 240, 240,1);
    [self.collectionView registerClass:[ActivityCollectionViewCell class] forCellWithReuseIdentifier:@"ActivityCollectionViewCell"];
    [self.view addSubview:self.collectionView];
    
}

- (ShareView *)shareView{
    if (!_shareView) {
        _shareView = [[ShareView alloc] initWithFrame:self.view.bounds];
        WS(weakSelf)
        
        _shareView.shareType = ^ (FOShareSocialType type){
            [weakSelf shareOnPlatform:type];
        };
        
        _shareView.clicked = ^ (ShareView *shareView, NSInteger buttonIndex){
            if (buttonIndex == 0) {
                [weakSelf shareViewDismiss];
            }else{
                
            }
        };
    }
    return _shareView;
}


- (void)shareViewDismiss{
//    self.tabBarController.tabBar.hidden = NO;
    [self.shareView dismissCompletion:^(BOOL finished) {
        [self.shareView removeFromSuperview];
        self.shareView = nil;

    }];
    
}
- (void)shareOnPlatform:(FOShareSocialType)type{
    if (type == FOSocialSnsTypeWechatTimeline) {
        [self shareImageToPlatformType:UMSocialPlatformType_WechatTimeLine];
    }else if (type == FOSocialSnsTypeWechatSession){
//        [self shareImageToPlatformType:UMSocialPlatformType_WechatSession];
        [self shareWebPageToPlatformType:UMSocialPlatformType_WechatSession];
    }else if (type == FOSocialSnsTypeSina){
        [self shareImageToPlatformType:UMSocialPlatformType_Sina];
    }else if (type == FOSocialSnsTypeMobileQQ){
        [self shareImageToPlatformType:UMSocialPlatformType_QQ];
    }else if (type == FOSocialSnsTypeQzone){
        [self shareImageToPlatformType:UMSocialPlatformType_Qzone];
    }else if (type == FOSocialSnsTypeFacebook){
        [self shareImageToPlatformType:UMSocialPlatformType_Facebook];
    }else if (type == FOSocialSnsTypeTwitter){
        [self shareImageToPlatformType:UMSocialPlatformType_Twitter];
    }else if (type == FOSocialSnsTypeInstagram){
        [self shareImageToPlatformType:UMSocialPlatformType_Instagram];
    }

}

- (void)shareImageToPlatformType:(UMSocialPlatformType)platformType
{
    UIImage *waterImage = [UIImage imageNamed:@"foreo.png"];

    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    //创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    //如果有缩略图，则设置缩略图
    [shareObject setShareImage:waterImage];
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;

    [self shareViewDismiss];
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {

        if (error) {
            NSLog(@"************Share fail with error %@*********",error);
        }else{
            NSLog(@"response data is %@",data);
        }
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType
{
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
//    NSString* thumbURL =  @"https://mobile.umeng.com/images/pic/home/social/img-1.png";
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"Foreo" descr:@"foreo describ" thumImage:[UIImage imageNamed:@"foreo.png"]];
    //设置网页地址
    shareObject.webpageUrl = @"https://www.baidu.com";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            //取消分享
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
//                成功
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
    }];
    [self shareViewDismiss];
}


#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(150,200);
}


#pragma mark - UICollectionViewDataSource && UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 30;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ActivityCollectionViewCell *cell = (ActivityCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"ActivityCollectionViewCell"
                                                                                                             forIndexPath:indexPath];
  
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.item == 0) {
        
        LogInViewController *loginVC = [[LogInViewController alloc] init];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginVC];
        
        [self presentViewController:nav animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
            
        }];
    }else{
        [[UIApplication sharedApplication].keyWindow addSubview:self.shareView];
        [self.shareView show];
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
