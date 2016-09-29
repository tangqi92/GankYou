//
//  AppDelegate.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "AppDelegate.h"
#import "RootTabBarController.h"
#import "UIImage+Appearance.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // 创建窗口
    self.window = [[UIWindow alloc] initWithFrame:kScreen_Bounds];
    self.window.backgroundColor =[UIColor whiteColor];
    
    RootTabBarController *rootTabbar = [[RootTabBarController alloc] init];
    self.window.rootViewController = rootTabbar;
    
    // 网络状态监测
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        DebugLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
    }];
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    // SDWebImage 加载数据类型
    [[[SDWebImageManager sharedManager] imageDownloader] setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    
    [self customNaviBar];
    
    // 显示窗口
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/**
 *  自定义导航栏
 */
- (void)customNaviBar {
    
    // 设置导航栏背景颜色
    UIImage * backgroundImage = [UIImage navigationBackgroundImage];
    UIImage * seperatorImage = [UIImage seperatorShadowImage];
    
    [[UINavigationBar appearance] setBackgroundImage:backgroundImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:seperatorImage];
    
    // 返回按钮颜色
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    // 标题颜色
    NSDictionary *navbarTitleTextAttributes = [NSDictionary
                                               dictionaryWithObjectsAndKeys:[UIColor whiteColor],
                                               NSForegroundColorAttributeName, nil];
    [[UINavigationBar appearance] setTitleTextAttributes:navbarTitleTextAttributes];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

@end
