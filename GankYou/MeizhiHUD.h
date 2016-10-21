//
//  MeizhiHUD.h
//  GankYou
//
//  Created by Tang Qi on 10/21/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MeizhiHUD : NSObject

+ (void)popupErrorMessage:(NSString *)errorMessage;

+ (void)popupSuccessMessage:(NSString *)successMessage;

+ (void)popupLoadingMessage:(NSString *)message enableUserInteraction:(BOOL)enableUserInteraction;

@end
