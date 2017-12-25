//
//  navigationButton2.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/22.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^navBarBtnClickBlock)(void);

@interface navigationButton : UIView
@property (nonatomic, strong)UIImageView *imageView;
@property (nonatomic, strong)UILabel *titleLabel;
@property (nonatomic, copy) navBarBtnClickBlock clickBlock;

- (instancetype)initWithType:(navButtonType)type;
- (void)setTitle:(NSString *)title andImage:(UIImage *)image;
@end
