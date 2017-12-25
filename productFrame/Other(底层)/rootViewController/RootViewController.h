//
//  productMainTabBarController.m
//  productFrame
//
//  Created by 陈威利 on 2017/11/6.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Define.h"
//#import "HttpManager.h"
//#import "UIImageView+WebCache.h"
typedef void(^choicePageBlock)(void);
@interface RootViewController : UIViewController

@property (nonatomic, copy) choicePageBlock pageChangeActionBlock;

@property (nonatomic, strong)navigationView *navBar;
//添加titleView
-(void)addTitleView:(NSString *)name;
//添加左右按钮
-(void)addBarItem:(NSString *)title withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;
-(void)leftClick:(UIButton *)btn;
-(void)rightClickAction;
- (void)pageChangeAction;
///设置navigaiotnBar的属性
- (void)addNavigationBar;
- (void)setNavigationBarTitle:(NSString *)title withPopButton:(BOOL)isHidden;
- (void)setRightButtonWithType:(navButtonType *)type andTitle:(NSString *)title andImage:(UIImage *)image andTextFont:(CGFloat)font;
//-(void)addBarItem:(NSString *)title withImage:(NSString *)imageName withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;


@end
