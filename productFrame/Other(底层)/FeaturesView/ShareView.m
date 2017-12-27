
//
//  ShareView.m
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "ShareView.h"

@interface ShareView ()

@property (nonatomic, strong) UIView *platFormView;
@property (nonatomic, strong) UIButton *deleteButton;

@end

@implementation ShareView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = RGBA(0, 0, 0, 0);
        
        self.platFormView = [[UIView alloc] initWithFrame:CGRectMake(0, SCREEN_HEIGHT, SCREEN_WIDTH, 300)];
        self.platFormView.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.platFormView];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 30)];
        titleLabel.text = @"share";
        titleLabel.textColor = RGBA(155, 155, 155, 1);
        titleLabel.font = [UIFont systemFontOfSize:18];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.platFormView addSubview:titleLabel];
        
        
        NSDictionary *configDict = @{@"icons": @[@"bt_share_friendcircle.png",
                                                 @"bt_share_wechat.png",
                                                 @"bt_share_weibo.png"],
                                     @"type":@[[NSNumber numberWithInteger:FOSocialSnsTypeWechatTimeline],
                                               [NSNumber numberWithInteger:FOSocialSnsTypeWechatSession],
                                               [NSNumber numberWithInteger:FOSocialSnsTypeSina]]
                                     };
        
        
        
        int columns = 3;
        int thirdCount = 3;
        CGFloat thirdButtonSize = 80;
        //间距
        CGFloat margin = (self.platFormView.width - columns * thirdButtonSize) / (columns + 1);
        
        CGFloat oneY = titleLabel.bottom;
        CGFloat oneX = margin;
        for (int i = 0; i<thirdCount; i++) {
            int col = i % columns;
            int row = i / columns;
            
            CGFloat x = oneX + col * (thirdButtonSize + margin);
            CGFloat y = oneY + row * (thirdButtonSize + 5) + 40;
            
            FOShareButton *button = [[FOShareButton alloc] initWithType:[configDict[@"type"][i] integerValue]];
            button.frame = CGRectMake(x, y, thirdButtonSize, thirdButtonSize);
            [button setImage:[UIImage imageNamed:configDict[@"icons"][i]] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(shareTo:) forControlEvents:UIControlEventTouchUpInside];
            [self.platFormView addSubview:button];
        }
        
        UIImageView *lineView  = [[UIImageView alloc] initWithFrame:CGRectMake(5, 210 + 20, SCREEN_WIDTH - 10, 1)];
//        lineView.image         = lineImage;
        lineView.contentMode   = UIViewContentModeBottom;
        lineView.clipsToBounds = YES;
        [self.platFormView addSubview:lineView];
        lineView.backgroundColor = RGBA(155, 155, 155, 0.5);
        
//        self.deleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.deleteButton.frame = CGRectMake(0, lineView.bottom, SCREEN_WIDTH, 45);
//        [self.deleteButton setTitle:@"delete" forState:UIControlStateNormal];
//        [self.deleteButton setTitleColor:RGBA(255, 135, 135, 1) forState:UIControlStateNormal];
//        self.deleteButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [self.deleteButton setBackgroundImage:bgImage forState:UIControlStateHighlighted];
//        [self.deleteButton setBackgroundImage:bgImage forState:UIControlStateSelected];
//        [self.deleteButton addTarget:self action:@selector(tapTheButton:) forControlEvents:UIControlEventTouchUpInside];
//        [self.platFormView addSubview:self.deleteButton];
        
        UIImageView *lineView1  = [[UIImageView alloc] initWithFrame:CGRectMake(0, lineView.bottom, SCREEN_WIDTH, 1)];
//        lineView1.image         = lineImage;
        lineView1.contentMode   = UIViewContentModeBottom;
        lineView1.clipsToBounds = YES;
        [self.platFormView addSubview:lineView1];
        
        
        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeCustom];
        cancelButton.frame = CGRectMake(0, lineView1.bottom, SCREEN_WIDTH, 60);
        [cancelButton setTitle:@"cancel" forState:UIControlStateNormal];
        [cancelButton setTitleColor:RGBA(74, 74, 74, 1) forState:UIControlStateNormal];
        cancelButton.titleLabel.font = [UIFont systemFontOfSize:15];
//        [cancelButton setBackgroundImage:bgImage forState:UIControlStateHighlighted];
//        [cancelButton setBackgroundImage:bgImage forState:UIControlStateSelected];
        [cancelButton addTarget:self action:@selector(tapTheCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self.platFormView addSubview:cancelButton];
        
        
    }
    
    
    
    return self;
}


- (void)tapTheCancel:(UIButton *)sender{
    if (self.clicked) {
        self.clicked(self,0);
    }
}

- (void)tapTheButton:(UIButton *)sender{
    if (self.clicked) {
        self.clicked(self,1);
    }
}


- (void)setButtonTitle:(NSString *)buttonTitle{
    [self.deleteButton setTitle:buttonTitle forState:UIControlStateNormal];
}


- (void)show{
    [UIView animateWithDuration:0.2f animations:^{
        self.backgroundColor = RGBA(0, 0, 0, 0.5f);
        self.platFormView.top = SCREEN_HEIGHT - 300;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismissCompletion:(void (^)(BOOL finished))completion{
    [UIView animateWithDuration:0.2f animations:^{
        self.platFormView.top = SCREEN_HEIGHT;
        self.backgroundColor = RGBA(0, 0, 0, 0);
    } completion:^(BOOL finished) {
        completion ? completion (finished) : nil;
    }];
}




- (void)shareTo:(FOShareButton *)sender
{
    if (self.shareType) {
        self.shareType(sender.type);
    }
}

@end



@interface FOShareButton ()

@end

@implementation FOShareButton

- (instancetype)initWithType:(FOShareSocialType)type{
    self = [super init];
    if (self) {
        self.type = type;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
