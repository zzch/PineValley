//
//  ZCEventTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/3/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCEvent.h"

@interface ZCEventTableViewCell : UITableViewCell
@property(nonatomic,strong)ZCEvent *event;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
