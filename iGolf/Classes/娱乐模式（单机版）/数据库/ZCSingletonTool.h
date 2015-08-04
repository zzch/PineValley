//
//  ZCSingletonTool.h
//  iGolf
//
//  Created by hh on 15/7/27.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSingletonTool : NSObject
+ (instancetype)sharedEventUuidTool;

//哪场比赛
@property (nonatomic, assign) NSInteger uuid;
//机主的成绩
@property (nonatomic, assign) NSInteger userID;
//哪一个人的成绩
@property (nonatomic, assign) NSInteger otherID;

@end
