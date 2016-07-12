//
//  JLSettingArrowItem.m
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/12.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import "JLSettingArrowItem.h"

@implementation JLSettingArrowItem

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass {
    if (self = [super initWithIcon:icon title:title]) {
        self.destVcClass = destVcClass;
    }
    return self;
}

@end
