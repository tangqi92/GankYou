//
//  JLSettingGroup.h
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/12.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JLSettingGroup : NSObject

/** 头部标题 */
@property (nonatomic, copy) NSString *headerTitle;

/** 底部标题 */
@property (nonatomic, copy) NSString *footerTitle;

/** 当前分组中所有行的数据（保存的是 JLSettingItem 模型） */
@property (nonatomic, strong) NSArray *items;

@end
