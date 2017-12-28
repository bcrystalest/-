
//
//  navigationButton2.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/22.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "navigationButton.h"
@interface navigationButton()
@property (nonatomic, assign)navButtonType selfType;
@end
@implementation navigationButton
- (UIImageView *)imageView{
    if (_imageView == nil) {
        _imageView = [UIImageView new];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _imageView;
}

- (UILabel *)titleLabel{
    if (_titleLabel == nil) {
        _titleLabel = [UILabel new];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor colorWithRed:0.882 green:0.122 blue:0.522 alpha:1.00];
    }
    return _titleLabel;
}
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
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickEvent)];
    [self addGestureRecognizer:tap];
    [self addSubview:self.imageView];
    [self addSubview:self.titleLabel];
}

- (void)setTitle:(NSString *)title andImage:(UIImage *)image{
    if (title) {
        _titleLabel.text = title;
    }
    if (image) {
        _imageView.image = image;
    }
    
    [self layoutIfNeeded];
}

- (void)clickEvent{
    if (_clickBlock) {
        _clickBlock();
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
     foreoWeakSelf;
     if (_selfType == leftImgRightText) {
         [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(weakSelf.mas_left).offset(3);
             make.top.equalTo(weakSelf.mas_top).offset(10);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
             make.height.mas_equalTo(weakSelf.imageView.mas_width).multipliedBy(1.0);
         }];
    
         [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(weakSelf.imageView.mas_right).offset(3);
             make.top.equalTo(weakSelf.mas_top).offset(3);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-3);
             make.right.mas_equalTo(weakSelf.mas_right).offset(-3);
         }];
         
     }else if (_selfType == leftTextRightImage) {
         [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(weakSelf.mas_right).offset(-3);
             make.top.equalTo(weakSelf.mas_top).offset(10);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
             make.height.mas_equalTo(weakSelf.imageView.mas_width).multipliedBy(1.0);
         }];
         [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(weakSelf.mas_left).offset(3);
             make.top.equalTo(weakSelf.mas_top).offset(3);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-3);
             make.right.mas_equalTo(weakSelf.imageView.mas_left).offset(-3);
         }];
     }else if (_selfType == upImgDownText) {
         [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(weakSelf.mas_right).offset(-13);
             make.top.equalTo(weakSelf.mas_top).offset(3);
             make.left.equalTo(weakSelf.mas_left).offset(13);
             make.height.mas_equalTo(weakSelf.imageView.mas_width).multipliedBy(1.0);
         }];
         [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(weakSelf.mas_left).offset(1);
             make.top.equalTo(weakSelf.imageView.mas_bottom).offset(2);
             make.right.mas_equalTo(weakSelf.mas_right).offset(-1);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(0);
         }];
     }else if (_selfType == upTextDownImg) {
         [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(weakSelf.mas_right).offset(-13);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-2);
             make.left.equalTo(weakSelf.mas_left).offset(13);
             make.height.mas_equalTo(weakSelf.imageView.mas_width).multipliedBy(1.0);
         }];
         [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.left.equalTo(weakSelf.mas_left).offset(1);
             make.top.equalTo(weakSelf.mas_top).offset(2);
             make.right.mas_equalTo(weakSelf.mas_right).offset(-1);
             make.bottom.equalTo(weakSelf.imageView.mas_top).offset(-2);
         }];
     }else if (_selfType == onlyImg) {
         [_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(weakSelf.mas_right).offset(-8);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-8);
             make.left.equalTo(weakSelf.mas_left).offset(8);
             make.top.equalTo(weakSelf.mas_top).offset(8);
             make.height.mas_equalTo(weakSelf.imageView.mas_width).multipliedBy(1.0);
         }];
     }else if (_selfType == onlyText) {
         [_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
             make.right.equalTo(weakSelf.mas_right).offset(-3);
             make.bottom.equalTo(weakSelf.mas_bottom).offset(-10);
             make.left.equalTo(weakSelf.mas_left).offset(3);
             make.top.equalTo(weakSelf.mas_top).offset(10);
         }];
     }
    
}



@end
