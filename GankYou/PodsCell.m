//
//  PodsCell.m
//  GankYou
//
//  Created by Tang Qi on 7/12/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import "PodsCell.h"
#import "Pods.h"

@interface PodsCell()

@property (nonatomic, strong) UILabel *labelName;
@property (nonatomic, strong) UILabel *labelDescription;
@property (nonatomic, assign) BOOL didSetupConstraints;

@end

@implementation PodsCell

// 调用 UITableView 的 dequeueReusableCellWithIdentifier 方法时会通过这个方法初始化 cell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initView];
    }
    return self;
}

- (void)initView {
    // ???:
    self.tag = 2000;
    // 计算 UILabel 的 preferredMaxLayoutWidth 值，多行时必须设置这个值，否则系统无法决定 Label 的宽度
    CGFloat preferredMaxWidth = kScreen_Width - 30;
    // 从此以后基本可以抛弃 CGRectMake 了
    _labelName = [UILabel new];
    [_labelName setFont:[UIFont boldSystemFontOfSize:15]];
    // 使用 AutoLayout 之前，一定要先将 view 添加到 superview 上，否则会报错
    [self.contentView addSubview:_labelName];
    
    [_labelName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView).with.offset(15);
        make.left.equalTo(self.contentView).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-15);
    }];
    
    _labelDescription = [UILabel new];
    [_labelDescription setFont:[UIFont systemFontOfSize:12]];
    _labelDescription.preferredMaxLayoutWidth = preferredMaxWidth; // 多行时必须设置
    // 设为 0 表示显示多行
    [_labelDescription setNumberOfLines:0];
    [self.contentView addSubview:_labelDescription];
    
    [_labelDescription mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_labelName.mas_bottom).with.offset(5);
        make.left.equalTo(_labelName.mas_left);
        make.right.equalTo(self.contentView).offset(-5);
        make.bottom.equalTo(self.contentView).offset(-5);
    }];
    [_labelDescription setContentHuggingPriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisVertical];
    
}

- (void)setPods:(Pods *)pods {
    _labelName.text = pods.podsName;
    _labelDescription.text = pods.podsDes;
}

@end
