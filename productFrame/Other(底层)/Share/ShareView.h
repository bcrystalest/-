//
//  ShareView.h
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//


#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FOShareSocialType) {
    FOSocialSnsTypeNone = 100,
    FOSocialSnsTypeSina,             //sina weibo
    FOSocialSnsTypeQzone,
    FOSocialSnsTypeTenc,             //tencent weibo
    FOSocialSnsTypeRenr,             //renren
    FOSocialSnsTypeWechatSession,
    FOSocialSnsTypeWechatTimeline,
    FOSocialSnsTypeMobileQQ,
    FOSocialSnsTypeFacebook,
    FOSocialSnsTypeTwitter,
    FOSocialSnsTypeInstagram,
};

@interface ShareView : UIView

@property (nonatomic, copy) void (^shareType)(FOShareSocialType type);
@property (nonatomic, copy) void (^clicked)(ShareView *shareView, NSInteger buttonIndex);

//上方按钮Title
@property (nonatomic, copy) NSString *buttonTitle;

- (void)show;
- (void)dismissCompletion:(void (^)(BOOL finished))completion;

@end



@interface FOShareButton : UIButton

@property (nonatomic, assign) FOShareSocialType type;
- (instancetype)initWithType:(FOShareSocialType)type;

@end

