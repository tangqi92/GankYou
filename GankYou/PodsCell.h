//
//  PodsCell.h
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#define kCellIdentifier_PodsCell @"PodsCell"

#import <UIKit/UIKit.h>
@class Pods;

@interface PodsCell : UITableViewCell

@property (nonatomic, strong) Pods *pods;

@end
