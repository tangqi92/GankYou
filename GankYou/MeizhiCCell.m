//
//  MeizhiCCell.m
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "MeizhiCCell.h"

@implementation MeizhiCCell

#pragma mark - Constructors

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.imageView];
        self.layer.borderWidth = 1.0;
        self.layer.borderColor = kColorMeizhiCCell;
    }
    return self;
}

- (void)setGankModel:(GankModel *)gankModel withCompleted:(finishBlock)finishBlock {
    [_imageView sd_setImageWithURL:[NSURL URLWithString:gankModel.url] placeholderImage:[UIImage imageNamed:@"loading"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        if (image) {
            if (!CGSizeEqualToSize(gankModel.imageSize, image.size)) {
                gankModel.imageSize = image.size;
                if (finishBlock) {
                    finishBlock();
                }
            }
        }
    }];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
        _imageView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        //        // TODO: 圆角优化
        //        _imageView.layer.cornerRadius = 2;
        //        _imageView.layer.masksToBounds = YES;
    }
    return _imageView;
}

@end
