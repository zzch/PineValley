//
//  ZCResultsModel.h
//  我爱高尔夫
//
//  Created by hh on 15/4/21.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCResultsModel : NSObject
/**
 小鸟球换算率
*/
@property(nonatomic,copy)NSString *advantage_transformation;
/**
 开球距离
 */
@property(nonatomic,copy)NSString *average_drive_length;
/**
 小鸟球
 */
@property(nonatomic,copy)NSString *birdie;
/**
 柏忌球
 */
@property(nonatomic,copy)NSString *bogey;
/**
 反弹率
 */
@property(nonatomic,copy)NSString *bounce;
/**
 双柏忌球
 */
@property(nonatomic,copy)NSString *double_bogey;
/**
 信天翁球
 */
@property(nonatomic,copy)NSString *double_eagle;
/**
 开球成功率
 */
@property(nonatomic,copy)NSString *drive_fairways_hit;
/**
 老鹰球
 */
@property(nonatomic,copy)NSString *eagle;
/**
 完整场次
 */
@property(nonatomic,copy)NSString *finished_count;
/**
 标准杆上果岭
 */
@property(nonatomic,copy)NSString *gir;
/**
 差点
 */
@property(nonatomic,copy)NSString *handicap;
/**
 标准杆
 */
@property(nonatomic,copy)NSString *par;
/**
 推杆数
 */
@property(nonatomic,copy)NSString *putts;
/**
 标准杆上果岭的平均推数
 */
@property(nonatomic,copy)NSString *putts_per_gir;
/**
 平均得分
 */
@property(nonatomic,copy)NSString *score;
/**
 3杆洞平均得分
 */
@property(nonatomic,copy)NSString *score_par_3;
/**
 4杆洞平均得分
 */
@property(nonatomic,copy)NSString *score_par_4;
/**
 5杆洞平均得分
 */
@property(nonatomic,copy)NSString *score_par_5;


+ (instancetype)resultsModelWithDict:(NSDictionary *)dict;
- (instancetype)initWithDict:(NSDictionary *)dict;

@end
