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
/*
这一动成绩是否保存了
 **/
@property(nonatomic,assign)BOOL isSave;
/*
  保存数据库后，修改par时所用保存的值
 **/
@property(nonatomic,assign)NSInteger isSavePar;
/*
 当前洞的倍数
 **/
@property(nonatomic,assign)int isNext;


@end
