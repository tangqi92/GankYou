//
//  MeizhiHUD.m
//  GankYou
//
//  Created by Tang Qi on 10/21/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "MeizhiHUD.h"
#import <SVProgressHUD.h>

@implementation MeizhiHUD

+ (void)popupErrorMessage:(NSString *)errorMessage {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showErrorWithStatus:errorMessage];
}

+ (void)popupSuccessMessage:(NSString *)successMessage {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showSuccessWithStatus:successMessage];
}

+ (void)popupLoadingMessage:(NSString *)message enableUserInteraction:(BOOL)enableUserInteraction
{
    SVProgressHUDMaskType maskType = SVProgressHUDMaskTypeNone;
    if (!enableUserInteraction) {
        maskType = SVProgressHUDMaskTypeClear;
    }
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
    [SVProgressHUD showWithStatus:message];
    [SVProgressHUD setDefaultMaskType:maskType];
}

@end
