//
//  ZCDatabaseTool.h
//  iGolf
//
//  Created by hh on 15/7/24.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZCHoleModel,ZCSwitchModel,ZCFightTheLandlordModel;
@interface ZCDatabaseTool : NSObject
//创建一场比洞比赛
+(BOOL)ToCreateAGame:(NSDictionary *)dict;
//创建一场斗地主比赛
+(BOOL)ToCreateDoudizhuGame:(NSDictionary *)dict;
+(BOOL)createALasVegasGame:(NSMutableArray*)array andSwitch:(NSMutableDictionary *)dict;
+(BOOL)saveEveryHole:(ZCFightTheLandlordModel *)fightTheLandlordModel andHoleNumber:(int) holeNumber;
+(ZCSwitchModel *)querySwitchProperties;

//创建比赛读取18洞的成绩
+(NSMutableArray *)doudizhuGameData;
+(BOOL)saveTheFightTheLandlord:(ZCFightTheLandlordModel *)fightTheLandlordModel  andHoleNumber:(int) holeNumber;
//拉斯维加斯 数据保存
+(BOOL)saveTheLasVegas:(ZCFightTheLandlordModel *)lasVegasModel  andHoleNumber:(int) holeNumber;
+(NSMutableArray *)theHistoricalRecord;
+(BOOL)deleteTheData:(NSInteger )uuid;
//删除表
+(BOOL)deleteTheAll;
@end
