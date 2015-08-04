//
//  ZCDoudizhuGameView.h
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCFightTheLandlordModel.h"
@class ZCFightTheLandlordModel;
@protocol ZCDoudizhuGameViewDelegate<NSObject>
@optional
-(void)doudizhuGameViewDelegateForScore:(ZCFightTheLandlordModel *)fightTheLandlordModel andForHoleNumber:(int) number;
@end
@interface ZCDoudizhuGameView : UIView
@property(nonatomic,copy)NSString *number;
@property(nonatomic,weak)id<ZCDoudizhuGameViewDelegate> delegate;
@property(nonatomic,strong)ZCFightTheLandlordModel *fightTheLandlordModel;

//修改提示语
@property(nonatomic,copy)NSString *clues;
@property(nonatomic,assign)int isNext;
@end
