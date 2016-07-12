//
//  SettingsCell.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "SettingsCell.h"
#import "JLSettingItem.h"
#import "JLSettingArrowItem.h"
#import "JLSettingSwitchItem.h"

@interface SettingsCell()

/** 箭头类型 */
@property (nonatomic, strong) UIImageView *arrowIv;
/** 开关类型 */
@property (nonatomic, strong) UISwitch *switchBtn;

@end

@implementation SettingsCell

#pragma mark - 懒加载

// 为了性能优化，所以用懒加载的方式创建
- (UIImageView *)arrowIv {
    if (_arrowIv == nil) {
        _arrowIv = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_arrow_right~iphone"]];
    }
    return _arrowIv;
}

- (UISwitch *)switchBtn {
    if (_switchBtn == nil) {
        _switchBtn = [[UISwitch alloc] init];
        // switch状态发生改变时存储状态
        [_switchBtn addTarget:self action:@selector(switchBtnChanged) forControlEvents:UIControlEventValueChanged];
    }
    return _switchBtn;
}

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    SettingsCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier_SettingsCell];
    if (cell == nil) {
        cell = [[SettingsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier_SettingsCell];
    }
    return cell;
}

- (void)setItem:(JLSettingItem *)item {
    _item = item;
    // 设置数据
    self.textLabel.text = _item.title;
    self.imageView.image = [UIImage imageNamed:_item.icon];
    
    // 设置辅助视图
    if ([_item isKindOfClass:[JLSettingArrowItem class]]) {
        self.accessoryView = self.arrowIv;
    } else if ([_item isKindOfClass:[JLSettingSwitchItem class]]) {
        self.accessoryView = self.switchBtn;
        
        // 恢复存储的状态
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        self.switchBtn.on = [defaults boolForKey:self.item.title];
        
        // 设置没有选中的样式
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    } else {
        // 防止循环引用
        self.accessoryView = nil;
    }
}

#pragma mark - 存储数据

- (void)switchBtnChanged {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:self.switchBtn.isOn forKey:self.item.title];
    // 立即存储
    [defaults synchronize];
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    [self.imageView setFrame:CGRectMake(20, 10, 25, 25)];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
}

@end
