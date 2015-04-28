//
//  ZCChildNameTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZCChildNameTableViewCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)tableView;
@property(nonatomic,copy)NSString *nameStr;
@property(nonatomic,copy)NSString *childName;
@end
