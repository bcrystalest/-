//
//  UserInfo.h
//  productFrame
//
//  Created by admin on 2017/12/26.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject

@property (nonatomic, assign) long coin;
@property (nonatomic, strong) NSString *created_at;
@property (nonatomic, strong) NSString *udescription;
@property (nonatomic, strong) NSString *phone;
@property (nonatomic, strong) NSString *uid;
@property (nonatomic, strong) NSString *identity;
@property (nonatomic, strong) NSString *ip;
@property (nonatomic, strong) NSString *location;
@property (nonatomic, strong) NSString *nick;
@property (nonatomic, assign) long rank;
@property (nonatomic, assign) NSUInteger sex;
@property (nonatomic, strong) NSString *token;
@property (nonatomic, strong) NSString *updated_at;
@property (nonatomic, assign) long source;
@property (nonatomic, strong) NSString *headimg;
@property (nonatomic, readonly) BOOL isLogin;

@end
