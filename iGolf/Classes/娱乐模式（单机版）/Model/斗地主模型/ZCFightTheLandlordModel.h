//
//  ZCFightTheLandlordModel.h
//  iGolf
//
//  Created by hh on 15/7/29.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCFightTheLandlordModel : NSObject
/*
 杆数
 **/
@property(nonatomic,assign)int par;
/**
 参赛者
 */
@property(nonatomic,strong)NSMutableArray *plays;

@end
