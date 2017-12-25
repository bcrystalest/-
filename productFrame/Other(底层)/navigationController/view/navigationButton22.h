//
//  navigationButton.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger {
    leftImgRightText,   ///左图右字
    leftTextRightImage,  /// 左字右图
    upImgDownText, /// 上字下图
    upTextDownImg, /// 上图下字
    onlyImg, ///纯图
    onlyText ///纯文字
}navButtonType;


@interface navigationButton : UIButton

- (instancetype)initWithType:(navButtonType)type;

@end
