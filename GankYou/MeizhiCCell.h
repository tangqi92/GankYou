//
//  MeizhiCCell.h
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#define kCCellIdentifier_MeizhiCCell @"MeizhiCCell"

#import "GankModel.h"
#import <UIKit/UIKit.h>

typedef void (^finishBlock)();

@interface MeizhiCCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) GankModel *gankModel;


- (void)setGankModel:(GankModel *)gankModel withCompleted:(finishBlock)finishBlock;

@end
