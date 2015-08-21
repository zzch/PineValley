//
//  ZCLasVegasView.h
//  iGolf
//
//  Created by hh on 15/7/21.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCLasVegasViewDelegate <NSObject>
@optional
-(void)buttonIsClickerForLasVegasView:(NSString *)nameStr;
@end
@interface ZCLasVegasView : UIView
@property(nonatomic,weak)id<ZCLasVegasViewDelegate>delegate;
-(NSMutableArray *)obtainCompetitorInformation;
-(NSMutableDictionary *)TheStateOfTheSwitch;
-(void)acceptPersonalInformationForFightTheLandlordView:(UIImage *)image andName:(NSString *)name;
@end
