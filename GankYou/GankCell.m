//
//  GankCell.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "GankCell.h"
#import "GankModel.h"

@interface GankCell()

@property (nonatomic, strong) UILabel *labelTitile;
@property (nonatomic, strong) UILabel *labelWho;
@property (nonatomic, strong) UILabel *labelTime;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation GankCell

// 调用 UITableView 的 dequeueReusableCellWithIdentifier 方法时会通过这个方法初始化 cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
        // 在 initView 后使用 Masonry 设置约束
        [self updateConstraints];
    }
    return self;
}

- (void)initView {
    // ???:
    self.tag = 1000;
    // 计算 UILabel 的 preferredMaxLayoutWidth 值，多行时必须设置这个值，否则系统无法决定 Label 的宽度
    CGFloat preferredMaxWidth = [UIScreen mainScreen].bounds.size.width - 75;
    // 从此以后基本可以抛弃 CGRectMake 了
    _labelTitile = [UILabel new];
    [_labelTitile setFont:[UIFont boldSystemFontOfSize:17]];
    // 设为 0 表示显示多行
    [_labelTitile setNumberOfLines:0];
    _labelTitile.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
    // 使用 AutoLayout 之前，一定要先将 view 添加到 superview 上，否则会报错
    [self.contentView addSubview:_labelTitile];
    
    _labelWho = [UILabel new];
    [_labelWho setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_labelWho];
    
    _labelTime = [UILabel new];
    [_labelTime setFont:[UIFont systemFontOfSize:12]];
    [self.contentView addSubview:_labelTime];
}

- (void)updateConstraints {
    if (!self.didSetupConstraints) {
        [_labelTitile mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).with.offset(15);
            make.left.equalTo(self.contentView).with.offset(15);
            make.right.equalTo(self.contentView).with.offset(-15);
            make.bottom.equalTo(self.contentView).with.offset(-25);
        }];
        [_labelTitile setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
        
        [_labelTime mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.bottom.mas_equalTo(-5);
            make.left.equalTo(_labelTitile);
        }];
        
        [_labelWho mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.equalTo(@15);
            make.bottom.mas_equalTo(-5);
            make.right.equalTo(self.contentView).offset(-15);
        }];
        
        // 避免重复设置相同的约束
        self.didSetupConstraints = YES;
    }
    [super updateConstraints];
}


-(void)setGankModel:(GankModel *)gankModel {
    _labelTitile.text = gankModel.desc;
    _labelTime.text = [gankModel.publishedAt componentsSeparatedByString:@"T"][0];
    _labelWho.text = gankModel.who;
}

@end
