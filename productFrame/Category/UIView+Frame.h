//
//  UIView+Frame.h
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

// shortcuts for frame properties
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, assign) CGSize size;

// shortcuts for positions
@property (nonatomic) CGFloat centerX;
@property (nonatomic) CGFloat centerY;


@property (nonatomic) CGFloat top;
@property (nonatomic) CGFloat bottom;
@property (nonatomic) CGFloat right;
@property (nonatomic) CGFloat left;

@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;

@end
