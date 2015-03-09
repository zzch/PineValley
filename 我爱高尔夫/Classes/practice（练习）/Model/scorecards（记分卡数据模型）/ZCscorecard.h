//
//  ZCscorecard.h
//  我爱高尔夫
//
//  Created by hh on 15/3/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

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
 *  T台的颜色
 */
@property (nonatomic, copy) NSString *tee_box_color;
/**
 *  距离球洞的码数
 */
@property (nonatomic, copy) NSString *distance_from_hole_to_tee_box;
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



+ (instancetype)scorecardsWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
