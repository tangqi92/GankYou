//
//  GankViewController.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankViewController.h"
#import "GankTableViewController.h"
#import "MeizhiViewController.h"

static const NSInteger kNumberOfChildControllers = 5;

@interface GankViewController () {
    NSArray *vcClasses;
    NSArray *vcTitles;
}

@end

@implementation GankViewController

- (void)viewDidLoad {
    // 带下划线
    self.menuViewStyle = WMMenuViewStyleLine;
    // 设置标题默认颜色
    self.titleColorNormal = kColorTitleColorNormal;
    // 这里注意：需要写在最后面，要不然上面的效果不会出现
    [super viewDidLoad];
}

// 设置 ViewController 的个数
- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return kNumberOfChildControllers;
}

- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    if (index == 0) {
        GankTableViewController *androidController = [[GankTableViewController alloc] init];
        androidController.gankDataType = @"Android";
        return androidController;
    } else if (index == 1) {
        GankTableViewController *iOSController = [[GankTableViewController alloc] init];
        iOSController.gankDataType = @"iOS";
        return iOSController;
    } else if (index == 2) {
        GankTableViewController *feController = [[GankTableViewController alloc] init];
        feController.gankDataType = @"前端";
        return feController;
    } else if (index == 3) {
        GankTableViewController *expandController = [[GankTableViewController alloc] init];
        expandController.gankDataType = @"拓展资源";
        return expandController;
    } else if (index == 4) {
        GankTableViewController *videoController = [[GankTableViewController alloc] init];
        videoController.gankDataType = @"休息视频";
        return videoController;
    } else {
        return  nil;
    }
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
    if (index == 0) {
        return @"Android";
    } else if (index == 1) {
        return @"iOS";
    } else if (index == 2) {
        return @"前端";
    } else if (index == 3) {
        return @"拓展";
    } else if (index == 4) {
        return @"视频";
    } else {
        return @"";
    }
}

@end
