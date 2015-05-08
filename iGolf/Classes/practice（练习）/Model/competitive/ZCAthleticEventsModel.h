//
//  ZCAthleticEventsModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCUserModel.h"
#import "ZCChildStadium.h"
@interface ZCAthleticEventsModel : NSObject
/**
 *  球赛 的uuid
 */
@property(nonatomic,copy)NSString *uuid;
/**
 *  创建球场的名字
 */
@property(nonatomic,copy)NSString *name;
/**
 *  创建该比赛的密码
 */
@property(nonatomic,copy)NSString *password;
/**
 *  玩家人数
 */
@property(nonatomic,copy)NSString *players_count;
/**
 *  比赛类型
 */
@property(nonatomic,copy)NSString *rule;
/**
 *  比赛开始时间
 */
@property(nonatomic,copy)NSString *started_at;
/**
 *  备注
 */
@property(nonatomic,copy)NSString *remark;

/**
 *  其他玩家个人信息
 */
@property(nonatomic,strong)ZCUserModel *user;
/**
 *  子场信息
 */
@property (nonatomic, strong) NSMutableArray *courses;

+ (instancetype)athleticEventsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
