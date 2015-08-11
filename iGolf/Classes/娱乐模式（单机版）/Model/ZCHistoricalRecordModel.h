//
//  ZCHistoricalRecordModel.h
//  iGolf
//
//  Created by hh on 15/8/7.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//SELECT *  FROM t_match WHERE id > 2 ORDER BY id DESE;

#import <Foundation/Foundation.h>

@interface ZCHistoricalRecordModel : NSObject
@property(nonatomic,assign)NSInteger uuid;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,strong)NSDate *played_at;
@property(nonatomic,assign)NSInteger earned;
@property(nonatomic,assign)NSInteger count;
@end
