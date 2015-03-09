//
//  ZCSettingHeadView.h
//  我爱高尔夫
//
//  Created by hh on 15/3/2.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCSettingHeadView;
@protocol  ZCSettingHeadViewDelegate<NSObject>

@optional
- (void)headerViewDidClicked:(ZCSettingHeadView *)headerView didClickButton:(UIButton *)button;

@end




@interface ZCSettingHeadView : UITableViewHeaderFooterView
//选中的名字
@property(nonatomic,copy) NSString *cleicedName;
//左边的提示语
@property(nonatomic,copy) NSString *liftName;
@property (nonatomic, weak) UIButton *nameButton;
@property(nonatomic,copy) NSString *imageName;


@property (nonatomic, weak) id<ZCSettingHeadViewDelegate> delegate;

+ (instancetype)headerViewWithTableView:(UITableView *)tableView;
@end
