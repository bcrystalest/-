//
//  navigationView.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/21.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^buttonClickBlock)(void);

@interface navigationView : UIView
@property (nonatomic, copy) buttonClickBlock gobackBlock;
@property (nonatomic, copy) buttonClickBlock rightClickBlock;
- (void)addNavigationBarTitle:(NSString *)titleString;
- (void)addBackButton;
- (void)addRightButton;

@end
