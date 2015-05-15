//
//  ZCScorecarHeadView.h
//  iGolf
//
//  Created by hh on 15/5/13.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCPlayerModel.h"
@class ZCScorecarHeadView;
@protocol ZCScorecarHeadViewDelagate<NSObject>
@optional
-(void)ZCScorecarHeadView:(ZCScorecarHeadView *)scorecarHeadView andClickButton:(UIButton *)button;
@end

@interface ZCScorecarHeadView : UIView
@property(nonatomic,strong)ZCPlayerModel *playerModel;
@property(nonatomic,strong)id<ZCScorecarHeadViewDelagate >delegate;
@end
