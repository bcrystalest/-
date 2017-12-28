//
//  navigationView.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonClickBlock)(void);
typedef enum :NSInteger {
    leftImgRightText,   ///左图右字
    leftTextRightImage,  /// 左字右图
    upImgDownText, /// 上字下图
    upTextDownImg, /// 上图下字
    onlyImg, ///纯图
    onlyText ///纯文字
}navButtonType;
@interface navigationView : UIView
@property (nonatomic, copy) buttonClickBlock gobackBlock;
@property (nonatomic, copy) buttonClickBlock rightClickBlock;
- (void)setNavigationBarTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font;
- (void)addBackButton;
- (void)addRightButtonWithType:(navButtonType)btnType andTitle:(NSString *)title andImage:(UIImage *)image andTextFont:(CGFloat)font;

@end
