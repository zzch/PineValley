//
//  ZCHoleView.h
//  iGolf
//
//  Created by hh on 15/7/20.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCHoleViewDelegate <NSObject>
@optional
-(void)switchButtonIsOpen:(int)isOpen1 andSwitch2:(int)isOpen2 andSwitch3:(int)isOpen3 andSwitch4:(int)isOpen4 andSwitch5:(int)isOpen5 andWhoWin:(int)whoWin andUserDict:(NSMutableDictionary*)userDict andOtherDict:(NSMutableDictionary *)otherDict;
@end
@interface ZCHoleView : UIView
@property(nonatomic,weak)id<ZCHoleViewDelegate> delegate;
-(void)theDefaultValue;
@end
