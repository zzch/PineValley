//
//  ZCLasVegasPhotoView.h
//  iGolf
//
//  Created by hh on 15/8/12.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCOfflinePlayer.h"
@interface ZCLasVegasPhotoView : UIView


@property(nonatomic,assign)int score;
@property(nonatomic,strong)ZCOfflinePlayer *offlinePlayer;
//1为红色 2 为黄色
@property(nonatomic,assign)int indexColor;
@end
