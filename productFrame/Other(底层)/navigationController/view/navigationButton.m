//
//  navigationButton.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "navigationButton.h"

@interface navigationButton()
@property (nonatomic, assign)navButtonType selfType;
@end

@implementation navigationButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithType:(navButtonType)type{
    if (self == [super init]) {
        _selfType = type;
        [self configUI];
    }
    
    return self;
}
/*leftImgRightText,   ///左图右字
 leftTextRightImage,  /// 左字右图
 upImgDownText, /// 上字下图
 upTextDownImg, /// 上图下字
 onlyImg, ///纯图
 onlyText ///纯文字*/
- (void)configUI{
//    self.frame = CGRectMake(0, 0, 70, 40);
    switch (_selfType) {
        case leftImgRightText:
            self.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, -28);
            break;
        case leftTextRightImage:
            self.imageEdgeInsets = UIEdgeInsetsMake(10, 40, 10, 10);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -120, 0, -28);
            break;
        case upImgDownText:
            self.imageEdgeInsets = UIEdgeInsetsMake(5, 25, 25, 25);
            self.titleEdgeInsets = UIEdgeInsetsMake(30, -65, 0, 0);
            break;
        case upTextDownImg:
            self.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, -28);
            break;
        case onlyImg:
            self.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, -28);
            break;
        case onlyText:
            self.imageEdgeInsets = UIEdgeInsetsMake(10, 10, 10, 40);
            self.titleEdgeInsets = UIEdgeInsetsMake(0, -60, 0, -28);
            break;
        default:
            break;
    }
}

@end
