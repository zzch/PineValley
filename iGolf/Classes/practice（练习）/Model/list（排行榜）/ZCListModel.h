//
//  ZCListModel.h
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCUserModel.h"
@interface ZCListModel : NSObject
/**
 *  排名
 */
@property(nonatomic,copy)NSString *position;
/**
 *  完成进度
 */
@property(nonatomic,copy)NSString *recorded_scorecards_count;
/**
 *  判断是否是房主
 */
@property(nonatomic,copy)NSString *isself;
/**
 *  总成绩
 */
@property(nonatomic,copy)NSString *total;
/**
 *  uuid
 */
@property(nonatomic,copy)NSString *uuid;
/**
 * 个人信息
 */
@property(nonatomic,strong)ZCUserModel *user;


+ (instancetype)listModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;


@end
