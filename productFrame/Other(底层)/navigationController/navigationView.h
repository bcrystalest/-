//
//  navigationView.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^backBlock)(void);

@interface navigationView : UIView
@property (nonatomic, copy) backBlock gobackBlock;
- (void)addNavigationBarTitle:(NSString *)titleString;
- (void)addBackButton;


@end
