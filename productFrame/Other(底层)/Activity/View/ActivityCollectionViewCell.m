//
//  ActivityCollectionViewCell.m
//  productFrame
//
//  Created by admin on 2017/12/25.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "ActivityCollectionViewCell.h"

@interface ActivityCollectionViewCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *brandLabel;
@property (nonatomic, strong) UILabel *productionTitleLabel;
@property (nonatomic, strong) UILabel *priceLabel;

@end


@implementation ActivityCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        
        self.picImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, 0, frame.size.width - 40, frame.size.height - 70)];
        [self.contentView addSubview:self.picImageView];
        self.picImageView.image = [UIImage imageNamed:@"foreo.png"];
        self.picImageView.contentMode = UIViewContentModeScaleAspectFit;
        
        self.brandLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.picImageView.bounds.size.height, frame.size.width - 20, 20)];
        self.brandLabel.text = @"FOREO";
        self.brandLabel.font = [UIFont boldSystemFontOfSize:15];
        [self.contentView addSubview:self.brandLabel];
        
        self.productionTitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, frame.size.height - 50, frame.size.width - 20, 20)];
        self.productionTitleLabel.text = @"菲洛尔露娜洁面仪";
        self.productionTitleLabel.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:self.productionTitleLabel];
        
        self.priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, frame.size.height - 30, frame.size.width - 20, 20)];
        self.priceLabel.text = @"￥1280";
        self.priceLabel.font = [UIFont systemFontOfSize:15];
        self.priceLabel.textColor = [UIColor redColor];
        [self.contentView addSubview:self.priceLabel];

        
        
        
    }
    return self;
}


@end
