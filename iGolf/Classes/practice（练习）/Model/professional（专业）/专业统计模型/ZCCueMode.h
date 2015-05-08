//
//  ZCCueMode.h
//  我爱高尔夫
//
//  Created by hh on 15/4/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCCueMode : NSObject
/**
 球杆名字
 */
@property(nonatomic,copy)NSString *name;
/**
 球杆次数
 */
@property(nonatomic,copy)NSString *uses;
/**
 平均距离
 */
@property(nonatomic,copy)NSString *average_length;
/**
 最小
 */
@property(nonatomic,copy)NSString *minimum_length;
/**
 最大
 */
@property(nonatomic,copy)NSString *maximum_length;
/**
 小于
 */
@property(nonatomic,copy)NSString *less_than_average_length;
/**
 大于
 */
@property(nonatomic,copy)NSString *greater_than_average_length;

+ (instancetype)cueModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
