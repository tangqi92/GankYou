//
//  BaseViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = kColorMainBG;
}

- (void)hideTabBar:(UITabBarController *)tabbarController {
    [UIView beginAnimations:nil context:NULL];
    for (UIView *view in tabbarController.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, kScreen_Height, view.frame.size.width, view.frame.size.height)];
        } else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, kScreen_Height)];
        }
    }
    [UIView commitAnimations];
}

- (void)showTabBar:(UITabBarController *)tabbarController {
    [UIView beginAnimations:nil context:NULL];
    for (UIView *view in tabbarController.view.subviews) {
        if ([view isKindOfClass:[UITabBar class]]) {
            [view setFrame:CGRectMake(view.frame.origin.x, kScreen_Height - view.frame.size.height, view.frame.size.width, view.frame.size.height)];
        } else {
            [view setFrame:CGRectMake(view.frame.origin.x, view.frame.origin.y, view.frame.size.width, kScreen_Height - view.frame.size.height)];
        }
    }
    [UIView commitAnimations];
}

- (void)showHUDWithText:(NSString *)text {
}

- (void)showHUDWithText:(NSString *)text delay:(NSTimeInterval)delay {
}

@end
