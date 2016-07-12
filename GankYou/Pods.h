//
//  Pods.h
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Pods : NSObject

@property (nonatomic, copy) NSString *podsName;
@property (nonatomic, copy) NSString *podsDes;
@property (nonatomic, copy) NSString *podsURL;

- (instancetype)initWithName:(NSString *)podsName description:(NSString *)podsDes url:(NSString *)podsURL;

@end
