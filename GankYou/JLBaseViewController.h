//
//  JLTableViewController.h
//  设置页面的封装
//
//  Created by 袁俊亮 on 16/4/11.
//  Copyright © 2016年 豹修. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JLSettingItem.h"
#import "JLSettingArrowItem.h"
#import "JLSettingSwitchItem.h"
#import "SettingsCell.h"
#import "JLSettingGroup.h"

@interface JLBaseViewController : UITableViewController

@property (nonatomic, strong) NSMutableArray *dataSource;

@end
