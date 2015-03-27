//
//  ZCStatistical.h
//  我爱高尔夫
//
//  Created by hh on 15/3/16.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCStatisticalScorecard;
@interface ZCStatistical : NSObject
/**
 *  净杆数
 */
@property (nonatomic, copy) NSString *net;
/**
 *  罚杆数
 */
@property (nonatomic, copy) NSString *penalties;
/**
 *  推杆数
 */
@property (nonatomic, copy) NSString *putts;
/**
 *  总杆数
 */
@property (nonatomic, copy) NSString *score;

/**
 *  优势转化率
 */
@property (nonatomic, copy) NSString *advantage_transformation;
/**
 * 平均开球距离
 */
@property (nonatomic, copy) NSString *average_drive_length;
/**
 *  小鸟球
 */
@property (nonatomic, copy) NSString *birdie;
/**
 *  柏忌球
 */
@property (nonatomic, copy) NSString *bogey;
/**
 *  反弹率
 */
@property (nonatomic, copy) NSString *bounce;

/**
 *  双柏忌球
 */
@property (nonatomic, copy) NSString *double_bogey;
/**
 *  信天翁球
 */
@property (nonatomic, copy) NSString *double_eagle;
/**
 *  开球成功率
 */
@property (nonatomic, copy) NSString *drive_fairways_hit;
/**
 *  老鹰球
 */
@property (nonatomic, copy) NSString *eagle;
/**
 *  标准杆上果岭率
 */
@property (nonatomic, copy) NSString *greens_in_regulation;
/**
 *  开球最远距离
 */
@property (nonatomic, copy) NSString *longest_drive_length;
/**
 *  标准杆上果岭平均推杆数
 */
@property (nonatomic, copy) NSString *putts_per_gir;
/**
 *  标准杆
 */
@property (nonatomic, copy) NSString *par;
/**
 *  PAR3平均得分
 */
@property (nonatomic, copy) NSString *score_par_3;
/**
 *  PAR4平均得分
 */
@property (nonatomic, copy) NSString *score_par_4;
/**
 *  PAR5平均得分
 */
@property (nonatomic, copy) NSString *score_par_5;
/**
 *  救球成功率
 */
@property (nonatomic, copy) NSString *scrambles;

@property (nonatomic, strong) ZCStatisticalScorecard *scorecards;


+ (instancetype)statisticalWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;
@end
