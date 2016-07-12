//
//  SettingsCell.h
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#define kCellIdentifier_SettingsCell @"SettingsCell"

#import <UIKit/UIKit.h>
@class JLSettingItem;

@interface SettingsCell : UITableViewCell

/** 每一个设置项 */
@property (nonatomic, strong) JLSettingItem *item;

+ (instancetype)cellWithTableView:(UITableView *)tableView;

@end
