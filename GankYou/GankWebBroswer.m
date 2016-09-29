//
//  GankWebBroswer.m
//  GankYou
//
//  Created by Tang Qi on 9/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankWebBroswer.h"
#import "KINWebBrowserViewController.h"
#import "UIViewController+TopViewController.h"

@implementation GankWebBroswer

+ (void)openWebWithURLString:(NSString *)url {
    KINWebBrowserViewController *webBrowser = [KINWebBrowserViewController webBrowser];
    webBrowser.tintColor = [UIColor whiteColor];
    webBrowser.hidesBottomBarWhenPushed = YES;
    webBrowser.extendedLayoutIncludesOpaqueBars = NO;
    webBrowser.edgesForExtendedLayout = UIRectEdgeBottom;
    [[UIViewController topViewController].navigationController pushViewController:webBrowser
                                                                         animated:YES];
    [webBrowser loadURLString:url];
}

@end
