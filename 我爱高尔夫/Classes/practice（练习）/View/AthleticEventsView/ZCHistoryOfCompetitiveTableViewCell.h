//
//  ZCHistoryOfCompetitiveTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/4/29.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCHistoryOfCompetitiveModel.h"
@interface ZCHistoryOfCompetitiveTableViewCell : UITableViewCell
@property(nonatomic,strong)ZCHistoryOfCompetitiveModel *historyOfCompetitiveModel;

+(instancetype)cellWithTable:(UITableView *)tableView;
@end
