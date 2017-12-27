//
//  NetWorkRequest.m
//  productFrame
//
//  Created by 陈威利 on 2017/12/25.
//  Copyright © 2017年 陈威利. All rights reserved.
//

#import "NetWorkRequest.h"

@implementation NetWorkRequest
- (NSURLSessionTask *)postNetWorkRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];

    NSURLSessionTask *task = [manager POST:urlString parameters:para progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject)
    {
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if ([newJson[@"code"] isEqualToString:@"00"]) {
            
            success(newJson);
        }else{
            failure(newJson);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:@"error" forKey:@"code"];
        [dic setObject:error forKey:@"message"];
        failure(dic);
    }];
    
    return task;
}

- (NSURLSessionTask *)getNetWorkRequest:(NSString *)urlString hideAfterGetData:(BOOL)isHide para:(NSDictionary *)para success:(SuccessedBlock)success failure:(FailureBlock)failure{
    
    AFHTTPSessionManager *manager =[AFHTTPSessionManager manager];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.securityPolicy.validatesDomainName = NO;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    [manager.requestSerializer willChangeValueForKey:@"timeoutInterval"];
    manager.requestSerializer.timeoutInterval = 5;
    [manager.requestSerializer didChangeValueForKey:@"timeoutInterval"];
    //如果报接受类型不一致请替换一致text/html或别的
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/plain", @"text/html" ,@"image/jpeg", nil];
    
    NSURLSessionTask *task = [manager GET:urlString parameters:para progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *newJson = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *isDdebug = newJson[@"debug"];
        if (isDdebug.integerValue == 1) {
            
            success(newJson);
        }else{
            failure(newJson);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSMutableDictionary *dic = [NSMutableDictionary new];
        [dic setObject:@"error" forKey:@"code"];
        [dic setObject:error forKey:@"message"];
        failure(dic);
    }];
    
    
    return task;
}

@end
