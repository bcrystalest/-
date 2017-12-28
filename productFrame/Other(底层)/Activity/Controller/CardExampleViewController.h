//
//  CardExampleViewController.h
//  productFrame
//
//  Created by admin on 2017/12/28.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ExampleViewControllerDelegate;

@interface CardExampleViewController : RootViewController

@property (nonatomic, weak) id<ExampleViewControllerDelegate> delegate;


@end
