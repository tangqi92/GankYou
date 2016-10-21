//
//  GankNetAPIManager.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankNetAPIManager.h"

static GankNetAPIManager *manager = nil;

@implementation GankNetAPIManager

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    return manager;
}

- (void)request_GankData_WithType:(NSString *)type
                         pageSize:(NSInteger)pageSize
                        pageIndex:(NSInteger)pageIndex
                          success:(requestSuccessBlock)success
                          failure:(requestFailureBlock)failure {
    // 获取网络数据
    NSString *urlEnCode = [NSString stringWithFormat:@"http://gank.io/api/data/%@/%zd/%zd", type, pageSize, pageIndex];
    DebugLog(@"URL: %@", urlEnCode);
    [[GankNetAPIClient sharedManager] requestJsonDataWithPath:urlEnCode withParams:nil withMethodType:GET withSuccess:^(NSDictionary *dic) {
        DebugLog(@"Success: %@", dic);
        success(dic);
    }
        withFailure:^(NSError *error) {
            failure(error);
        }];
}

@end
