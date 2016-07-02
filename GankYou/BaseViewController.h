//
//  BaseViewController.h
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

/**
 *  隐藏显示 TabBar
 */
- (void)hideTabBar:(UITabBarController *)tabbarController;
- (void)showTabBar:(UITabBarController *)tabbarController;

/**
 *  提示相关方法
 */
- (void)showHUDWithText:(NSString *)text;
- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay;

@end
