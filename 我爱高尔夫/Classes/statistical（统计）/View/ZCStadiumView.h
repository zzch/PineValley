//
//  ZCStadiumView.h
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCStadiumView;
@protocol ZCStadiumDelegate<NSObject>
@optional
- (void)StadiumViewDidClickedcell:(ZCStadiumView *)headerView uuidStr:(NSString *)uuid  andName:(NSString *)name;
@end

@interface ZCStadiumView : UITableView
@property (nonatomic, weak) id<ZCStadiumDelegate> delegater;

@end
