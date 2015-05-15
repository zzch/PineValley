//
//  ZCHistoricalEventsModel.h
//  iGolf
//
//  Created by hh on 15/5/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPlayer.h"
#import "ZCVenueModel.h"
@interface ZCHistoricalEventsModel : NSObject
/**
 *  赛事的uuid
 */
@property (nonatomic, copy) NSString *uuid;

/**
 *  参赛人数
 */
@property (nonatomic, copy) NSString *players_count;
/**
 *  赛事的开始的时间
 */
@property (nonatomic, assign) long started_at;

/**
 *  球员的信息
 */
@property (nonatomic, strong) ZCPlayer *player;
/**
 *  球场的信息
 */
@property (nonatomic, strong) ZCVenueModel *venue;

+ (instancetype)historicalEventsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
