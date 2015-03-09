//
//  ZCChooseTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/1/30.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCChooseTableViewCell : UITableViewCell
//+(instancetype)cellWithTable:(UITableView *)tableView;
///球场名称
@property (nonatomic, strong) UILabel *name;
//球场地址
@property (nonatomic, strong) UILabel *address;
//距离
@property (nonatomic, strong) UILabel *distance;
@end
