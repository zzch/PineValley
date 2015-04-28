//
//  ZCCompetitiveTableViewCell.h
//  我爱高尔夫
//
//  Created by hh on 15/4/24.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPlayerModel.h"
@class ZCCompetitiveTableViewCell;
@protocol  ZCCompetitiveTableViewCellDelagate<NSObject>
@optional
- (void)ZCCompetitiveTableViewCell:(ZCCompetitiveTableViewCell *)competitiveTableViewCell didClickrankingButton:(UIButton *)button;
@end


@interface ZCCompetitiveTableViewCell : UITableViewCell
@property(nonatomic,strong)ZCPlayerModel *playerModel;

@property (nonatomic, weak) id<ZCCompetitiveTableViewCellDelagate> delegate;
+(instancetype)cellWithTable:(UITableView *)tableView;

@end
