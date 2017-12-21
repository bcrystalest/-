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

//添加titleView
-(void)addTitleView:(NSString *)name;
//添加左右按钮
-(void)addBarItem:(NSString *)title withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;
-(void)leftClick:(UIButton *)btn;
-(void)rightClick:(UIButton *)btn;
- (void)pageChangeAction;
//-(void)addBarItem:(NSString *)title withImage:(NSString *)imageName withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;


@end
