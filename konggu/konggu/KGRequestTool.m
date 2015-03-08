//
//  KGRequestTool.m
//  konggu
//
//  Created by zhaoliang on 15/3/8.
//  Copyright (c) 2015年 zhaoliang. All rights reserved.
//

#import "KGRequestTool.h"
#import "AFNetworking.h"

@implementation KGRequestTool

+ (void)GET:(NSString *)URLString
            parameters:(id)parameters
            response:(NSString *)response
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (![response isEqualToString:@"json"]) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

+ (void)POST:(NSString *)URLString
            parameters:(id)parameters
            response:(NSString *)response
            success:(void (^)(id responseObject))success
            failure:(void (^)(NSError *error))failure
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    if (![response isEqualToString:@"json"]) {
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    }
    [manager POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
