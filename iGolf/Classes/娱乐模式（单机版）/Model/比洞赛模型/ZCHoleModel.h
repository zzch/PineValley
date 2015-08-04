//
//  ZCHoleModel.h
//  iGolf
//
//  Created by hh on 15/7/27.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCHoleModel : NSObject
//标准杆
@property(nonatomic,assign)int par;
//本机左边的成绩
@property(nonatomic,assign) int userScore;
//本机右边添加的成绩
@property(nonatomic,assign) int otherScore;
//本洞所挣的分数
@property(nonatomic,assign) int earned;
//洞号
@property(nonatomic,assign) int holeNumber;

@end
