//
//  Pods.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "Pods.h"

@implementation Pods

- (instancetype)initWithName:(NSString *)podsName description:(NSString *)podsDes url:(NSString *)podsURL {
    if (self = [super init]) {
        self.podsName = podsName;
        self.podsDes = podsDes;
        self.podsURL = podsURL;
    }
    return self;
}

@end
