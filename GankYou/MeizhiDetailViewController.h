//
//  MeizhiDetailViewController.h
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <UIKit/UIKit.h>
@class GankModel;

@interface MeizhiDetailViewController : UIViewController

@property (strong, nonatomic, readonly) UIImageView *imageView;

- (instancetype)initWithMeizhi:(GankModel *)gankModel;

@end
