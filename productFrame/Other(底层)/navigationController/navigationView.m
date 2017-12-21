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
@end
@implementation navigationView

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
    }
    return _titleLabel;
}

- (instancetype)init{
    if (self == [super init]) {
        [self configUI];
    }
   
    return self;
}

- (void)configUI{
    [self addSubview:self.titleLabel];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    foreoWeakSelf;
    [_titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf.mas_centerX);
        make.centerY.equalTo(weakSelf.mas_centerY);
        make.height.equalTo(weakSelf.mas_height);
    }];
}

@end
