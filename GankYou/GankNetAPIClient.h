//
//  GankNetAPIClient.h
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 请求方法
typedef NS_ENUM(NSInteger, HTTPMethod) {
    HTTPMethodGET = 0,
    HTTPMethodPOST,
    HTTPMethodPUT,
    HTTPMethodDELETE,
    HTTPMethodHEAD
};

// 请求成功回调 block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

// 请求失败回调 block
typedef void (^requestFailureBlock)(NSError *error);

@interface GankNetAPIClient : AFHTTPSessionManager

+ (instancetype)sharedManager;

- (void)requestJsonDataWithPath:(NSString *)aPath withParams:(NSDictionary *)params
                 withMethodType:(HTTPMethod)method
                    withSuccess:(requestSuccessBlock)success
                    withFailure:(requestFailureBlock)failure;

@end
