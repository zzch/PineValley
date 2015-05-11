//
//  ZCAthleticEventTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/4/22.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCAthleticEventsModel.h"
@interface ZCAthleticEventTableViewCell : UITableViewCell
@property(nonatomic,strong)ZCAthleticEventsModel *athleticEventsModel;
+(instancetype)cellWithTable:(UITableView *)tableView;
@end
