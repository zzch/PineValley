//
//  ZCOfflinePlayer.h
//  iGolf
//
//  Created by hh on 15/7/29.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCOfflinePlayer : NSObject
/**
 头像
 */
@property(nonatomic,copy)NSString *portrait;
/**
 名字
 */
@property(nonatomic,copy)NSString *nickname;
/**
 每个洞打了多少杆
 */
@property(nonatomic,assign)NSInteger  stroke;
/**
 ID
 */
@property(nonatomic,assign)NSInteger player_id;
/**
 是否是自己
 */
@property(nonatomic,assign)NSInteger is_owner;

/**
  当前的洞累计分数
 */
@property(nonatomic,assign)NSInteger score;
/**
 本洞得多少分
 */
@property(nonatomic,assign)NSInteger winScore;

/**
 作为比较属性
 */
@property(nonatomic,assign)CGFloat strokeToCompare;


@property(nonatomic,assign)NSInteger isSaveStroke;

@end
