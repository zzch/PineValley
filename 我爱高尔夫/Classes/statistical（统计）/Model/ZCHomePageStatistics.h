//
//  ZCHomePageStatistics.h
//  我爱高尔夫
//
//  Created by hh on 15/4/17.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCHomePageStatistics : NSObject
/**
 平均杆数
 */
@property(nonatomic,copy)NSString *average_score;
/**
 最好成绩
 */
@property(nonatomic,copy)NSString *best_score;
/**
 小鸟球
 */
@property(nonatomic,copy)NSString *birdie;
/**
  柏忌球
 */
@property(nonatomic,copy)NSString *bogey;
/**
 信天翁球
 */
@property(nonatomic,copy)NSString *double_eagle;
/**
 老鹰球
 */
@property(nonatomic,copy)NSString *eagle;
/**
 完整计分
 */
@property(nonatomic,copy)NSString *finished_matches_count;
/**
 差点
 */
@property(nonatomic,copy)NSString *handicap;
/**
 标准杆
 */
@property(nonatomic,copy)NSString *par;
/**
 排名
 */
@property(nonatomic,copy)NSString *rank;
/**
 总场次
 */
@property(nonatomic,copy)NSString *total_matches_count;
/**
 *  双柏忌球
 */
@property(nonatomic,copy)NSString *double_bogey;

+ (instancetype)homePageStatisticsWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
