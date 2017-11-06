//
//  RootViewController.h
//  FavoriteLimit
//
//  Created by 沈家林 on 15/11/30.
//  Copyright (c) 2015年 沈家林. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "Define.h"
//#import "HttpManager.h"
//#import "UIImageView+WebCache.h"
@interface RootViewController : UIViewController


//添加titleView
-(void)addTitleView:(NSString *)name;

//第一个问题，下面的方法的写法，还有好处
//添加左右按钮
-(void)addBarItem:(NSString *)title withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;
-(void)leftClick:(UIButton *)btn;
-(void)rightClick:(UIButton *)btn;

//-(void)addBarItem:(NSString *)title withImage:(NSString *)imageName withBackGroundImage:(NSString *)backGroundImage withDirection:(NSString *)direction;


@end
