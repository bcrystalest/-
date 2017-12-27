//
//  NetWorkRequest.h
//  productFrame
//
//  Created by 陈威利 on 2017/12/25.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessedBlock)(id successDic);
typedef void(^FailureBlock)(id failureDic);
@interface NetWorkRequest : NSObject
@property (nonatomic, copy) SuccessedBlock successBlock;
@property (nonatomic, copy) FailureBlock failureBlock;

/**
 post请求(持续5秒)

 @param urlString <#urlString description#>
 @param para <#para description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure;



/**
 get请求(持续5秒)

 @param urlString <#urlString description#>
 @param para <#para description#>
 @param success <#success description#>
 @param failure <#failure description#>
 @return <#return value description#>
 */
- (NSURLSessionTask *)getNetWorkRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure;
@end
