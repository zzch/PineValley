//
//  ZCToTheGameModel.h
//  iGolf
//
//  Created by hh on 15/5/15.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCCwnerModel.h"
#import "ZCVenue.h"
@interface ZCToTheGameModel : NSObject
/**
 *  创建者
 */
@property(nonatomic,strong)ZCCwnerModel *owner;
/**
 *  子场信息
 */
@property(nonatomic,strong)ZCVenue *venue;
/**
 *  时间
 */
@property(nonatomic,assign)long  started_at;

+ (instancetype)toTheGameModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
