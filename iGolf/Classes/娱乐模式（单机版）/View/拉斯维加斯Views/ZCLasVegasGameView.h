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
@end
