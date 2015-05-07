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
        
        
         self.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
        
        
        
        
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





//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
//    label.backgroundColor = [UIColor grayColor];
//    label.textColor = [UIColor whiteColor];
//    label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:18];
//    label.text = [NSString stringWithFormat:@" %d", row+1];
//    return label; 
//}


@end
