//
//  ZCViewTheResultsModel.h
//  iGolf
//
//  Created by hh on 15/5/19.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCUserModel.h"
#import "ZCStatisticalScorecard.h"

@interface ZCViewTheResultsModel : NSObject
/**
 *  uuid
 */
@property(nonatomic,copy)NSString *uuid;
/**
 *  排名
 */
@property(nonatomic,copy)NSString *position;
/**
 *  完成进度
 */
@property(nonatomic,copy)NSString *recorded_scorecards_count;
/**
 *  距标准杆距离
 */
@property(nonatomic,copy)NSString *strokes;
/**
 *  总成绩
 */
@property(nonatomic,copy)NSString *total;


/**
 * 个人信息
 */
@property(nonatomic,strong)ZCUserModel *user;
//记分卡
@property (nonatomic, strong) ZCStatisticalScorecard *scorecards;


+ (instancetype)viewTheResultsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;



@end
