//
//  ZCHoleScoringView.h
//  iGolf
//
//  Created by hh on 15/7/22.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCFightTheLandlordModel.h"
@class ZCHoleModel;
@protocol ZCHoleScoringViewDelegate<NSObject>
@optional
-(void)holeScoringViewForScore:(ZCHoleModel *)holeModel;
@end
@interface ZCHoleScoringView : UIView
@property(nonatomic,copy)NSString *number;
@property(nonatomic,weak)id<ZCHoleScoringViewDelegate>delegate;
////本机赢的分数
//@property(nonatomic,assign)int userWinPoints;
////添加用户赢得赢的分数
//@property(nonatomic,assign)int otherWinPoints;
//修改提示语
@property(nonatomic,copy)NSString *clues;
@property(nonatomic,assign)int isNext;


@property(nonatomic,strong)ZCFightTheLandlordModel *fightTheLandlordModel;
@end
