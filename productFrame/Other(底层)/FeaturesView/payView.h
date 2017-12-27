//
//  payView.h
//  productFrame
//
//  Created by admin on 2017/12/27.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FOPayType) {
    FOPayTypeNone = 100,
    FOPayTypeWeChat = 101,
    FOPayTypeAlipay = 102,
    FOPayTypeStripe = 103
};

@interface payView : UIView

@property (nonatomic, copy) void (^shareType)(FOPayType type);
@property (nonatomic, copy) void (^clicked)(payView  *payView, NSInteger buttonIndex);

//上方按钮Title
@property (nonatomic, copy) NSString *buttonTitle;

- (void)show;
- (void)dismissCompletion:(void (^)(BOOL finished))completion;

@end

@interface FOPayButton : UIButton

@property (nonatomic, assign) FOPayType type;
- (instancetype)initWithType:(FOPayType)type;

@end

