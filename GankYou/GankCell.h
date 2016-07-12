//
//  GankCell.h
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#define kCellIdentifier_GankCell @"GankCell"

#import <UIKit/UIKit.h>
@class GankModel;

@interface GankCell : UITableViewCell

@property (nonatomic, strong) GankModel *gankModel;

@end
