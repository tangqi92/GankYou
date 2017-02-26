//
//  GankNetAPIManager.h
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankNetAPIClient.h"
#import <Foundation/Foundation.h>
// 请求成功回调 block
typedef void (^requestSuccessBlock)(NSDictionary *dic);

// 请求失败回调 block
typedef void (^requestFailureBlock)(NSError *error);

@interface GankNetAPIManager : NSObject

+ (instancetype)sharedManager;

#pragma mark - GetGankData

- (void)requestGankDataWithType:(NSString *)type
                         pageSize:(NSInteger)pageSize
                        pageIndex:(NSInteger)pageIndex
                          success:(requestSuccessBlock)success
                          failure:(requestFailureBlock)failure;

@end
