//
//  UIViewController+TopViewController.h
//  GankYou
//
//  Created by Tang Qi on 9/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (TopViewController)

+ (UIViewController *)topViewController;
+ (UIViewController *)topViewControllerWithRootViewController:(UIViewController *)rootViewController;

@end
