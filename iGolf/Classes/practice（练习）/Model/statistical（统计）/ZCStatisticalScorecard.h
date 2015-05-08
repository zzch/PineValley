//
//  ZCStatisticalScorecard.h
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCStatisticalScorecard : NSObject
@property (nonatomic, strong) NSMutableArray *par;
//分数
@property (nonatomic, copy) NSMutableArray *score;
//状态
@property (nonatomic, copy) NSMutableArray *status;
+ (instancetype)statisticalScorecardWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
