//
//  ZCLasVegasGameView.h
//  iGolf
//
//  Created by hh on 15/7/23.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCFightTheLandlordModel;
@interface ZCLasVegasGameView : UIView
@property(nonatomic,copy)NSString *number;
@property(nonatomic,strong)ZCFightTheLandlordModel *lasVegasModel;
//返回时候是否可以点击
@property(nonatomic,assign)BOOL isClick;

//点击取消后传回修改前的值
@property(nonatomic,strong)ZCFightTheLandlordModel *beforeTheChangeModel;
@end
