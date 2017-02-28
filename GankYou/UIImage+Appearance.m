//
//  UIImage+Appearance.m
//  GankYou
//
//  Created by Tang Qi on 9/29/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "UIImage+Appearance.h"

@implementation UIImage (Appearance)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size {
    CGRect rect = CGRectMake(0.0f, 0.0f, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

+ (UIImage *)navigationBackgroundImage {
    return [UIImage imageWithColor:kColorMain size:CGSizeMake(1, 1)];
}

+ (UIImage *)tabBarBackgroundImage {
    return [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(1, 1)];
}

+ (UIImage *)navigationSeperatorShadowImage {
    return [UIImage imageWithColor:[UIColor colorWithWhite:.0 alpha:0.12] size:CGSizeMake(kScreen_Width, 1)];
}

+ (UIImage *)tabBarSeperatorShadowImage {
    return [UIImage imageWithColor:[UIColor whiteColor] size:CGSizeMake(kScreen_Width, 1)];
}

@end
