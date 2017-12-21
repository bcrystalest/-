//
//  rootPageController.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/20.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "subModelForIncludeController.h"
@interface rootIncludeController : UIViewController
@property (nonatomic, strong)NSMutableArray *vcArray;
///按顺序排
- (void)inSequence;
@end
