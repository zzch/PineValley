//
//  ZCDatapickerView.h
//  我爱高尔夫
//
//  Created by hh on 15/4/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCDatapickerView;
@protocol ZCDatapickerViewDelegate<NSObject>
@optional
-(void)datapickerViewDelegate:(UIDatePicker *)datePicker;
@end
@interface ZCDatapickerView : UIView

@property(nonatomic,assign)id<ZCDatapickerViewDelegate >delegate;
@end
