//
//  ZCStatistical.h
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCStatisticalScorecard;
@interface ZCStatistical : NSObject
/**
 *  净杆数
 */
@property (nonatomic, copy) NSString *net;
/**
 *  罚杆数
 */
@property (nonatomic, copy) NSString *penalties;
/**
 *  推杆数
 */
@property (nonatomic, copy) NSString *putts;
/**
 *  总杆数
 */
@property (nonatomic, copy) NSString *score;

@property (nonatomic, strong) ZCStatisticalScorecard *scorecards;


+ (instancetype)statisticalWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
