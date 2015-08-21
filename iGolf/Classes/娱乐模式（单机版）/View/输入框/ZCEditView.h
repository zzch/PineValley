//
//  ZCEditView.h
//  iGolf
//
//  Created by hh on 15/8/6.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZCEditViewDelegate<NSObject>
@optional
- (void)editViewButtonIsClicked:(UIButton *)btn;

- (void)editViewPersonalInformation:(UIImage *)image andName:(NSString *) nameStr;

@end

@interface ZCEditView : UIView
@property(nonatomic,weak)id<ZCEditViewDelegate> delegate;
@property(nonatomic,strong)UIImage *image;
@property(nonatomic,copy)NSString *nameStr;
@end
