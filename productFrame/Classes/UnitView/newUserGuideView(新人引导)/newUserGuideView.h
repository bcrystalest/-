//
//  newUserGuideView.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/7.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^choicePageBlock)(void);
@interface newUserGuideView : UIView

@property (nonatomic, copy) choicePageBlock block;
@end
