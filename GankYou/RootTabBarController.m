//
//  RootTabBarController.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "RootTabBarController.h"
#import "MeizhiViewController.h"
#import "GankViewController.h"
#import "MineViewController.h"

@interface RootTabBarController ()

@end

@implementation RootTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setupViewControllers];
}

/**
 *  TabBar 上面的按钮图片尺寸不能超过 44
 */
- (void)setupViewControllers {
    MeizhiViewController *meiZhiVC = [[MeizhiViewController alloc] init];
    GankViewController *gankVC = [[GankViewController alloc] init];
    MineViewController *mineVC = [[MineViewController alloc] init];

    meiZhiVC.title = @"妹纸";
    meiZhiVC.tabBarItem.title = @"妹纸";
    // 图片的显示模式
    meiZhiVC.tabBarItem.image = [[UIImage imageNamed:@"ic_tabbar_single~iphone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    meiZhiVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_single_on~iphone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    gankVC.title = @"干货";
    gankVC.tabBarItem.title = @"干货";
    gankVC.tabBarItem.image = [[UIImage imageNamed:@"ic_tabbar_xs~iphone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    gankVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_xs_on~iphone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    mineVC.title = @"";
    mineVC.tabBarItem.title = @"我";
    mineVC.tabBarItem.image = [[UIImage imageNamed:@"ic_tabbar_mine~iphone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    mineVC.tabBarItem.selectedImage = [[UIImage imageNamed:@"ic_tabbar_mine_on~iphone"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    UINavigationController *navVCMeizhi = [[UINavigationController alloc] initWithRootViewController:meiZhiVC];
    UINavigationController *navVcGank = [[UINavigationController alloc] initWithRootViewController:gankVC];
    UINavigationController *navVcMine = [[UINavigationController alloc] initWithRootViewController:mineVC];

    self.viewControllers = @[ navVCMeizhi, navVcGank, navVcMine ];
}

/**
 *  只会调用一次
 */
+ (void)initialize {
    // 文字的属性
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSForegroundColorAttributeName] = kColorTabbarItemTitle;

    NSMutableDictionary *selectedAttrs = [NSMutableDictionary dictionary];
    selectedAttrs[NSForegroundColorAttributeName] = kColorMain;

    // 通过 appearance 设置字体
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttrs forState:UIControlStateSelected];
}

@end
