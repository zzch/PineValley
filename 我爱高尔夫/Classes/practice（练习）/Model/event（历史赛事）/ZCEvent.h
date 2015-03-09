//
//  ZCEvent.h
//  我爱高尔夫
//
//  Created by hh on 15/3/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCCourse.h"
@interface ZCEvent : NSObject
/**
 *  赛事的uuid
 */
@property (nonatomic, copy) NSString *uuid;
/**
 *  赛事的类型
 */
@property (nonatomic, copy) NSString *type;
/**
 *  赛事的总杆数
 */
@property (nonatomic, assign) int score;

/**
 *  赛事的记录的记分卡数量
 */
@property (nonatomic, assign) int recorded_scorecards_count;
/**
 *  赛事的开始的时间
 */
@property (nonatomic, assign) int started_at;
/**
 *  赛事的球场信息模型
 */
@property (nonatomic, strong) ZCCourse *course;



+ (instancetype)eventWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
