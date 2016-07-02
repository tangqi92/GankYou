//
//  GankModel.h
//  GankYou
//
//  Created by Tang Qi on 7/2/16.
//  Copyright © 2016 Tang Qi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GankModel : NSObject

/**
 *  id
 */
@property (nonatomic, copy) NSString *_id;
/**
 *  来源
 */
@property (nonatomic, copy) NSString *source;
/**
 *  提交者 ID
 */
@property (nonatomic, copy) NSString *who;
/**
 *  发布时间
 */
@property (nonatomic, copy) NSString *publishedAt;
/**
 *  used
 */
@property (nonatomic, assign) BOOL used;
/**
 *  创建时间
 */
@property (nonatomic, copy) NSString *createdAt;
/**
 *  干货类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  干货描述
 */
@property (nonatomic, copy) NSString *desc;
/**
 *  干货地址
 */
@property (nonatomic, copy) NSString *url;
/**
 *  妹纸的 Size
 */
@property(nonatomic, assign) CGSize imageSize;

@end
