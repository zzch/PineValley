//
//  ZCEventUuidTool.h
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCEventUuidTool : NSObject
+ (instancetype)sharedEventUuidTool;

//是专业还是简单
@property (nonatomic, copy) NSString *scoring;

//按什么类型查看分析结果  1为按次数  2为按时间 3 为按球场
@property(nonatomic,copy) NSString *type;
//塞事类型practice: 练习赛  tournament: 竞技赛

@property(nonatomic,copy) NSString *eventType;

/**
 *  是否是加入比赛
 */
@property(nonatomic,assign,getter=isJoin) BOOL isJoin;



@end
