//
//  MeizhiPhotoBrowser.h
//  GankYou
//
//  Created by Tang Qi on 26/02/2017.
//  Copyright © 2017 Tang Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeizhiPhotoBrowser : NSObject

+ (void)browserPhotoWithImage:(UIImage *)image;

+ (void)browserPhotoWithImage:(UIImage *)image fromView:(UIView *)fromView;

+ (void)browserPhotoWithURL:(NSURL *)url;

+ (void)browserPhotoWithURL:(NSURL *)url fromView:(UIView *)fromView;

@end
