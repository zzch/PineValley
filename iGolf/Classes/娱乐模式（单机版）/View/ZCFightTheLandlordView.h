//
//  ZCFightTheLandlordView.h
//  iGolf
//
//  Created by hh on 15/7/21.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCDouModel;
@protocol ZCFightTheLandlordViewDelegate <NSObject>
@optional
-(void)switchButtonIsOpen:(int)isOpen1 andSwitch2:(int)isOpen2 andSwitch3:(int)isOpen3  andUserDict:(ZCDouModel*)userDict andOtherDict:(ZCDouModel *)otherDict  andAnotherDict:(ZCDouModel *)anotherDict;

-(void)buttonIsClickerForFightTheLandlordView:(NSString *)nameStr;
@end

@interface ZCFightTheLandlordView : UIView
@property(nonatomic,weak)id<ZCFightTheLandlordViewDelegate> delegate;
//默认值
-(void)theDefaultValue;
//返回头像信息
-(NSMutableArray *)obtainCompetitorInformation;
//控制器传来的个人信息
-(void)acceptPersonalInformationForFightTheLandlordView:(UIImage *)image andName:(NSString *)name;
@end
