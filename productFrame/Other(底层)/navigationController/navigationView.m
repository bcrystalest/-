//
//  navigationView.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "navigationView.h"
#import "navigationButton.h"
@interface navigationView()
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, strong)navigationButton *backButton;
@property (nonatomic, strong)navigationButton *rightButton;
@end
@implementation navigationView
{
    CGFloat edgeY;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:20];
    }
    return _titleLabel;
}

- (navigationButton *)backButton{
    if (_backButton == nil) {
        _backButton = [[navigationButton alloc]initWithType:leftImgRightText];
        [_backButton setTitle:@"返回" andImage:[UIImage imageNamed:@"backButton"]];
    }
    return _backButton;
}

- (navigationButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [navigationButton new];
    }
    return _rightButton;
}

- (instancetype)init{
    if (self == [super init]) {
        [self configUI];
    }
   
    return self;
}

- (void)configUI{
    if (KIsiPhoneX) {
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 100);
        edgeY = 20;
    }else{
        self.frame = CGRectMake(0, 0, SCREEN_WIDTH, 70);
        edgeY = 10;
    }
    self.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    foreoWeakSelf;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(edgeY);
        make.height.mas_equalTo(weakSelf.frame.size.height-edgeY*2);
        
    }];
}

- (void)setNavigationBarTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font{
    _titleLabel.text = title;
    _titleLabel.textColor = color;
    _titleLabel.font = font;
}

- (void)addBackButton{
    foreoWeakSelf;
    [self addSubview:self.backButton];

    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(5);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(edgeY);
        make.height.mas_equalTo(40);

    }];
    
    _backButton.clickBlock = ^{
        [weakSelf goBackAction];
    };
}

- (void)addRightButtonWithType:(navButtonType)btnType andTitle:(NSString *)title andImage:(UIImage *)image andTextFont:(CGFloat)font{
    foreoWeakSelf;
    navigationButton *btn = [[navigationButton alloc]initWithType:btnType];
//    [[navigationButton alloc]initWithType:upImgDownText];
    btn.titleLabel.font = [UIFont systemFontOfSize:font];
    [btn setTitle:title andImage:image];
    self.rightButton = btn;
    [self addSubview:self.rightButton];
    /*typedef enum :NSInteger {
     leftImgRightText,   ///左图右字
     leftTextRightImage,  /// 左字右图
     upImgDownText, /// 上字下图
     upTextDownImg, /// 上图下字
     onlyImg, ///纯图
     onlyText ///纯文字
     }navButtonType;
*/
    
    [_rightButton mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(-5);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(edgeY);
        if (btnType == leftImgRightText || btnType == leftImgRightText){
            make.height.mas_equalTo(40);
        }else{
            make.width.mas_equalTo(50);
        }
    }];
    

    _rightButton.clickBlock = ^{
        [weakSelf rightClickAction];
    };
}



- (void)goBackAction{
    if (_gobackBlock) {
        _gobackBlock();
    }
}

- (void)rightClickAction{
    if (_rightClickBlock) {
        _rightClickBlock();
    }
}

//- (void)addButtonWith

@end
