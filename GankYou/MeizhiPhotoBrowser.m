//
//  MeizhiPhotoBrowser.m
//  GankYou
//
//  Created by Tang Qi on 26/02/2017.
//  Copyright © 2017 Tang Qi. All rights reserved.
//

#import "MeizhiPhotoBrowser.h"
#import "UIViewController+TopViewController.h"
#import <IDMPhotoBrowser.h>
#import <IDMPhoto.h>

@implementation MeizhiPhotoBrowser

+ (void)browserPhotoWithImage:(UIImage *)image {
    [self browserPhotoWithImage:image fromView:nil];
}

+ (void)browserPhotoWithImage:(UIImage *)image fromView:(UIView *)fromView {
    IDMPhoto *photo = [[IDMPhoto alloc] initWithImage:image];
    [self browserPhotoWithPhoto:photo fromView:fromView];
}

+ (void)browserPhotoWithURL:(NSURL *)url {
    [self browserPhotoWithURL:url fromView:nil];
}

+ (void)browserPhotoWithURL:(NSURL *)url fromView:(UIView *)fromView {
    IDMPhoto *photo = [[IDMPhoto alloc] initWithURL:url];
    [self browserPhotoWithPhoto:photo fromView:fromView];
}

+ (void)browserPhotoWithPhoto:(IDMPhoto *)photo fromView:(UIView *)fromView {
    NSMutableArray *photos = @[].mutableCopy;
    [photos addObject:photo];
    IDMPhotoBrowser *browser = [[IDMPhotoBrowser alloc] initWithPhotos:photos
                                                      animatedFromView:fromView];
    browser.displayToolbar = NO;
    browser.displayDoneButton = NO;
    //    browser.dismissOnTouch = YES;
    browser.forceHideStatusBar = YES;
    browser.usePopAnimation = YES;
    [[UIViewController topViewController].navigationController presentViewController:browser
                                                                            animated:YES
                                                                          completion:nil];
}

@end
