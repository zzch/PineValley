//
//  ZCPlayer.h
//  iGolf
//
//  Created by hh on 15/5/11.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCPlayer : NSObject
/**
 *  记录是否是房主 1是房主 0 不是房主
 */
@property (nonatomic, copy) NSString *owned;

/**
 *  记分卡记录数
 */
@property (nonatomic, copy) NSString *recorded_scorecards_count;
/**
 *  得分类型
 */
@property (nonatomic, copy) NSString *scoring_type;
/**
 *  总成绩
 */
@property (nonatomic, copy) NSString *strokes;

+ (instancetype)playerModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
