//
//  MineViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 加载数据
    [self addSectionOne];
    [self addSectionTwo];
}

/**
 *  添加第 0 组的模型数据
 */
- (void)addSectionOne {
    // 1.1 收藏
    JLSettingArrowItem *interest = [[JLSettingArrowItem alloc] initWithIcon:@"ic_mine_interest~iphone" title:@"收藏"];
    // 1.2 心动
    JLSettingArrowItem *heartbeat = [[JLSettingArrowItem alloc] initWithIcon:@"ic_mine_heartbeat~iphone" title:@"心动"];
    
    JLSettingGroup *group = [[JLSettingGroup alloc] init];
    group.items = @[ interest, heartbeat ];
    [self.dataSource addObject:group];
}

/**
 *  添加第 2 组的模型数据
 */
- (void)addSectionTwo {
    // 2.1 设置
    JLSettingArrowItem *settings = [[JLSettingArrowItem alloc] initWithIcon:@"ic_mine_setting~iphone" title:@"设置"];
    
    JLSettingGroup *group = [[JLSettingGroup alloc] init];
    group.items = @[ settings ];
    [self.dataSource addObject:group];
}

@end
