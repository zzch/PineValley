//
//  ZCListTableViewCell.h
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCListModel.h"
@interface ZCListTableViewCell : UITableViewCell
@property(nonatomic,strong)ZCListModel *listModel;
+(instancetype)cellWithTable:(UITableView *)tableView;

@end
