//
//  ZCTotalScorecards.h
//  我爱高尔夫
//
//  Created by hh on 15/3/5.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ZCPlayerModel.h"
@interface ZCTotalScorecards : NSObject
/**
 *  用户信息
 */
@property (nonatomic, strong) ZCPlayerModel *player;

///**
// *  创建球场的type
// */
//@property (nonatomic, copy) NSString *type;
/**
 *  创建球场数组模型
 */
@property (nonatomic, strong) NSMutableArray *scorecards;

///**
// *  是否点击了保存,默认是NO
// */
//@property (nonatomic, assign, getter = isSave) BOOL save;


+ (instancetype)totalScorecardsWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
