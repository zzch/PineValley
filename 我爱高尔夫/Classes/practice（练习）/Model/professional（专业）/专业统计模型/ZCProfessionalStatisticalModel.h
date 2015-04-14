//
//  ZCProfessionalStatisticalModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/13.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCProfessionalScorecardModel,ZCTotalModel,ZCAverageModel,ZCPushRodModel,ZCBunkersModel;
@interface ZCProfessionalStatisticalModel : NSObject
/**
 *  18洞成绩
 */
@property(nonatomic,strong)ZCProfessionalScorecardModel *scorecards;
/**
 *  总成绩模型
 */
@property(nonatomic,strong)NSDictionary *item_01;
/**
 *  平均成绩模型
 */
@property(nonatomic,strong)NSDictionary *item_02;
/**
 *  推杆模型
 */
@property(nonatomic,strong)NSDictionary *item_03;
/**
 *  沙坑模型
 */
@property(nonatomic,strong)NSDictionary *item_04;
/**
 *  切杆模型
 */
@property(nonatomic,strong)NSDictionary *item_05;
/**
 *  攻果岭模型
 */
@property(nonatomic,strong)NSDictionary *item_06;
/**
 *  球道命中模型
 */
@property(nonatomic,strong)NSDictionary *item_07;
/**
 *  开球模型
 */
@property(nonatomic,strong)NSDictionary *item_08;
/**
 *  杆数模型
 */
@property(nonatomic,strong)NSDictionary *item_09;
/**
 *  球杆模型
 */
@property(nonatomic,strong)NSDictionary *item_10;


+ (instancetype)professionalStatisticalModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;



@end
