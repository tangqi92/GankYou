//
//  GankNetAPIClient.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankNetAPIClient.h"

static GankNetAPIClient *manager = nil;

@implementation GankNetAPIClient

+ (instancetype)sharedManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:@"http://gank.io/api/data/"]];
    });
    return manager;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        // 请求超时设定
        self.requestSerializer.timeoutInterval = 5;
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        [self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Accept"];
        [self.requestSerializer setValue:url.absoluteString forHTTPHeaderField:@"Referer"];

        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/plain", @"text/javascript", @"text/json", @"text/html", nil];

        self.securityPolicy.allowInvalidCertificates = YES;
    }
    return self;
}

- (void)requestJsonDataWithPath:(NSString *)aPath
                     withParams:(NSDictionary *)params
                 withMethodType:(HTTPMethod)method
                    withSuccess:(requestSuccessBlock)success
                    withFailure:(requestFailureBlock)failure {
    if (!aPath || aPath.length <= 0) {
        return;
    }
    // 解决乱码问题
    aPath = [aPath stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    switch (method) {
        case HTTPMethodGET: {
            // TODO: 所有 Get 请求，增加缓存机制
            [self GET:aPath parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
                DebugLog(@"JSON: %@", responseObject);
                success(responseObject);
            }
                failure:^(NSURLSessionTask *operation, NSError *error) {
                    DebugLog(@"Error: %@", error);
                    failure(error);
                }];
            break;
        }
        case HTTPMethodPOST: {
            [self POST:aPath parameters:params progress:nil success:^(NSURLSessionTask *task, NSDictionary *responseObject) {
                DebugLog(@"JSON: %@", responseObject);
                success(responseObject);
            }
                failure:^(NSURLSessionTask *operation, NSError *error) {
                    DebugLog(@"Error: %@", error);
                    failure(error);
                }];
            break;
        }
        default:
            break;
    }
}

@end
