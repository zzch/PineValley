//
//  ZCChooseTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/1/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCstadium.h"
@interface ZCChooseTableViewCell : UITableViewCell
//+(instancetype)cellWithTable:(UITableView *)tableView;

@property (nonatomic, strong) ZCstadium *stadium;
@end
