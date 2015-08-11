//
//  ZCEntertainmentRankingCell.h
//  iGolf
//
//  Created by hh on 15/8/10.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCOfflinePlayer.h"
@interface ZCEntertainmentRankingCell : UITableViewCell
+(instancetype)cellWithTable:(UITableView *)tableView;
@property(nonatomic,strong)ZCOfflinePlayer *player;
@property(nonatomic,assign) int ranking;
@end
