//
//  navigationView.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "navigationView.h"

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
//        _backButton.backgroundColor = [UIColor redColor];
        [_backButton setImage:[[UIImage imageNamed:@"backButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [_backButton setImage:[[UIImage imageNamed:@"backButton"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_backButton setTitle:@"返回" forState:UIControlStateNormal];
        [_backButton setTitleColor:[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1.00] forState:UIControlStateNormal];
    }
    return _backButton;
}

- (navigationButton *)rightButton{
    if (_rightButton == nil) {
        _rightButton = [[navigationButton alloc]initWithType:upImgDownText];
        [_rightButton setImage:[[UIImage imageNamed:@"remark"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateHighlighted];
        [_rightButton setImage:[[UIImage imageNamed:@"remark"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_rightButton setTitle:@"回返回返回" forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:13];
        _rightButton.titleLabel.textAlignment = NSTextAlignmentCenter;
        [_rightButton setTitleColor:[UIColor colorWithRed:0.749 green:0.749 blue:0.749 alpha:1.00] forState:UIControlStateNormal];
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

- (void)addNavigationBarTitle:(NSString *)titleString{
    _titleLabel.text = titleString;
    
}

- (void)addBackButton{
    foreoWeakSelf;
    [self addSubview:self.backButton];

    [_backButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf.mas_left).offset(5);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(edgeY);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(70);
    }];
    [_backButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)addRightButton{
    foreoWeakSelf;
    [self addSubview:self.rightButton];
    [_rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.centerY.equalTo(weakSelf.mas_centerY).offset(edgeY);
        make.height.mas_equalTo(50);
        make.width.mas_equalTo(70);
    }];
    [_rightButton addTarget:self action:@selector(rightClickAction) forControlEvents:UIControlEventTouchUpInside];
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
