//
//  ZCHistoricalRecordCell.h
//  iGolf
//
//  Created by hh on 15/8/7.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHistoricalRecordModel.h"
@interface ZCHistoricalRecordCell : UITableViewCell
@property(nonatomic,strong)ZCHistoricalRecordModel *historicalRecordModel;
+(instancetype)cellWithTable:(UITableView *)tableView;
@end
