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
        
        
         self.backgroundColor=[UIColor whiteColor];
        
        
        
        
        UIDatePicker *datePicker=[[UIDatePicker alloc] initWithFrame:CGRectZero];
        //模式
        datePicker.datePickerMode=UIDatePickerModeDate;
        datePicker.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
        
        [datePicker addTarget:self action:@selector(dateChange:) forControlEvents:UIControlEventValueChanged];
       //[datePicker setValue:ZCColor(85, 85, 85) forKeyPath:@"textColor"];
        // [ datePicker setDate:[datePicker date] animated:YES];
        [self addSubview:datePicker];
       
//        NSDate* minDate = [[NSDate alloc]initWithString:@"1900-01-01 00:00:00 -0500"];
//        NSDate* maxDate = [[NSDate alloc]initWithString:@"2099-01-01 00:00:00 -0500"];
//        
        
//        
//        SEL selector = NSSelectorFromString( @"setHighlightsToday:" );
//        NSInvocation *invocation = [NSInvocation invocationWithMethodSignature :
//                                    [UIDatePicker
//                                     instanceMethodSignatureForSelector:selector]];
//      //  BOOL no = YES;
//        [invocation setSelector:selector];
//       //[invocation setArgument:&no atIndex:6];
//        [invocation invokeWithTarget:datePicker];
        
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
