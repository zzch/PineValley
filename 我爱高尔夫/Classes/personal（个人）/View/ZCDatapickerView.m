//
//  ZCDatapickerView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/9.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCDatapickerView.h"

@implementation ZCDatapickerView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self =[super initWithFrame:frame]) {
        
        UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:CGRectZero];
        //模式
        datePicker.datePickerMode=UIDatePickerModeDate;
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
       
        // [ datePicker setDate:[datePicker date] animated:YES];
        [self addSubview:datePicker];
       
        
      // ZCLog(@"%@",[datePicker date]);
        
    }
    return self;
}

-(void)dateChange:(UIDatePicker *)datePicker
{
 // ZCLog(@"%@",[ datePicker date]);
    
    if ([self.delegate respondsToSelector:@selector(datapickerViewDelegate:)]) {
        [self.delegate datapickerViewDelegate:datePicker];
        
    }
    
    
}


@end
