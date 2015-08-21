//
//  ZCBirdBallView.h
//  iGolf
//
//  Created by hh on 15/8/13.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCOfflinePlayer.h"

@protocol ZCBirdBallViewDelegate<NSObject>
@optional
- (void)ZCBirdBallViewWhetherPopUpNext:(ZCOfflinePlayer *)player andIndexDoulePar:(int)doulePar ;

- (void)ZCBirdBallViewWhetherPopUpNextWithDouDiZhu:(NSString *)playerName andIndexDoulePar:(int)doulePar;
@end

@interface ZCBirdBallView : UIView
//1为 双倍标准杆  2为小鸟球  4为老鹰球
@property(nonatomic,assign)int index;
@property(nonatomic,strong)ZCOfflinePlayer *player;
@property(nonatomic,strong)ZCOfflinePlayer *otherPlayer;
@property(nonatomic,assign)int doulePar;
@property(nonatomic,weak)id<ZCBirdBallViewDelegate>delegate;
//斗地主页面调用
-(void)setName:(NSString *)str andIndex:(NSInteger)index1;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,assign)int douDoulePar;
@end
