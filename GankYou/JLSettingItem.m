//
//  JLSettingItem.m
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/11.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import "JLSettingItem.h"

@implementation JLSettingItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title {
    if (self = [super init]) {
        self.icon = icon;
        self.title = title;
    }
    return self;
}

@end
