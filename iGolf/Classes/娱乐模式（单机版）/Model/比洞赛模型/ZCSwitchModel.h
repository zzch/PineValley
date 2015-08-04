//
//  ZCSwitchModel.h
//  iGolf
//
//  Created by hh on 15/7/28.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCSwitchModel : NSObject
//小鸟球一倍
@property(nonatomic,assign)int birdie_x2;
//老鹰球2倍
@property(nonatomic,assign)int eagle_x4;
//双倍标准杆1倍
@property(nonatomic,assign)int double_par_x2;
//打平进入下一洞
@property(nonatomic,assign)int drau_to_next;
//平局让杆
@property(nonatomic,assign)int drau_to_win;
@end
