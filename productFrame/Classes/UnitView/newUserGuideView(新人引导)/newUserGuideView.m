//
//  newUserGuideView.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/7.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "newUserGuideView.h"

@implementation newUserGuideView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI{
    self.backgroundColor = [UIColor grayColor];
    UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(100, 100, 50, 50)];
    [self addSubview:btn];
    [btn addTarget:self action:@selector(goback) forControlEvents:UIControlEventTouchDown];
    btn.backgroundColor = [UIColor whiteColor];
}

- (void)goback{
    if (_block) {
        _block();
    }
}

@end
