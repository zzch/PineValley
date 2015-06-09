//
//  ZCscorecard.h
//  我爱高尔夫
//
//  Created by hh on 15/3/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCTee_boxes.h"
@interface ZCscorecard : NSObject
/**
 *  创建球洞的UUID
 */
@property (nonatomic, copy) NSString *uuid;
/**
 *  创建球洞的编号
 */
@property (nonatomic, copy) NSString *number;
/**
 *  标准杆
 */
@property (nonatomic, copy) NSString *par;

/**
 *  总杆数
 */
@property (nonatomic, copy) NSString *score;
/**
 *  推杆数
 */
@property (nonatomic, copy) NSString *putts;
/**
 *  罚杆数
 */
@property (nonatomic, copy) NSString *penalties;
/**
 *  距离球洞还有多少距离
 */
@property (nonatomic, copy) NSString *driving_distance;
/**
 *  方向
 */
@property (nonatomic, copy) NSString *direction;

/**
 *  距离球洞距离（跳转修改记分卡简单页面用到）
 */
@property (nonatomic, copy) NSString *distance_from_hole;

/**
 *  球洞属性
 */
@property (nonatomic, strong) NSMutableArray *tee_boxes;




+ (instancetype)scorecardsWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
