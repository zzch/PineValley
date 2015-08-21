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
//返回时候是否可以点击
@property(nonatomic,assign)BOOL isClick;

//点击取消后传回修改前的值
@property(nonatomic,strong)ZCFightTheLandlordModel *beforeTheChangeModel;



@end
