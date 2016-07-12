//
//  JLSettingItem.h
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/11.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import <Foundation/Foundation.h>

// 定义一个 block 用于保存代码
typedef void (^optionBlock)();

@interface JLSettingItem : NSObject

/** 图标 */
@property (nonatomic, copy) NSString *icon;
/** 标题 */
@property (nonatomic, copy) NSString *title;

/** 定义 block 保存将来要执行的代码 */
@property (nonatomic, copy) optionBlock option;

- (instancetype)initWithIcon:(NSString *)icon title:(NSString *)title;

@end
