//
//  UserInfo.m
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"uid" : @"id",
             @"udescription":@"description"};
}

- (BOOL)isLogin{
    return [self.token length] ? YES : NO;
}

@end
