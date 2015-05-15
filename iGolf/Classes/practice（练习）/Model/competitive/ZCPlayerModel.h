//
//  ZCPlayerModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/28.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCUserModel.h"
@interface ZCPlayerModel : NSObject
/**
 *  用户信息
 */
@property (nonatomic, strong) ZCUserModel *user;
/**
 *  排名
 */
@property (nonatomic, copy) NSString *position;

/**
 *  记分卡个数
 */
@property (nonatomic, copy) NSString *recorded_scorecards_count;
/**
 *  记分卡类型
 */
@property (nonatomic, copy) NSString *scoring_type;

/**
 * 杆数
 */
@property (nonatomic, copy) NSString *strokes;
/**
 *  分数+1-1
 */
@property (nonatomic, copy) NSString *total;

+ (instancetype)playerModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
