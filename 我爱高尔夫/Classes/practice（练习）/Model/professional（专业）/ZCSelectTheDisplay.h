//
//  ZCSelectTheDisplay.h
//  我爱高尔夫
//
//  Created by hh on 15/4/2.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSelectTheDisplay : NSObject
/**
 码数
 */
@property(nonatomic,copy)NSString *distance_from_hole;
/**
 状态
 */
@property(nonatomic,copy)NSString *point_of_fall;
/**
 罚杆
 */
@property(nonatomic,copy)NSString *penalties;
/**
 球杆
 */
@property(nonatomic,copy)NSString *club;

/**
  序列
 */
@property(nonatomic,copy)NSString *sequence;

/**
 球洞的UUID
 */
@property(nonatomic,copy)NSString *uuid;

+ (instancetype)selectTheDisplayWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
