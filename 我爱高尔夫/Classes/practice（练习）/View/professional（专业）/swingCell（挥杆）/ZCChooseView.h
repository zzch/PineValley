//
//  ZCChooseView.h
//  我爱高尔夫
//
//  Created by hh on 15/4/2.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCChooseView,ZCSelectTheDisplay;
@protocol ZCChooseViewDelegate<NSObject>
@optional

/**
 新建记录
 */
-(void)ZCChooseView:(ZCChooseView *)ZCChooseView clickdetermineButtonAndSelectTheDisplay:(ZCSelectTheDisplay *)selectTheDisplay andScore:(NSString *)score andPenalties:(NSString *)penalties andPutts:(NSString *)putts;
/**
 修改记录
 */
-(void)ZCChooseView:(ZCChooseView *)ZCChooseView clickdetermineButtonAndModifyDataWithSelectTheDisplay:(ZCSelectTheDisplay *)selectTheDisplay andScore:(NSString *)score andPenalties:(NSString *)penalties andPutts:(NSString *)putts;
@end

@interface ZCChooseView : UIView
@property(nonatomic,copy) NSString *scorecard_uuid;
//修改一条的UUID
@property(nonatomic,copy) NSString *uuid;
@property(nonatomic,copy) NSString *isYes;

@property(nonatomic,weak) id<ZCChooseViewDelegate >delegate;
@end
