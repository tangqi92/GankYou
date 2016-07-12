//
//  JLSettingArrowItem.h
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/12.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import "JLSettingItem.h"

@interface JLSettingArrowItem : JLSettingItem

/** 目标控制器 */
@property (nonatomic, assign) Class destVcClass;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title destVcClass:(Class)destVcClass;

@end
