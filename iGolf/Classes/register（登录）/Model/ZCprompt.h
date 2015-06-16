//
//  ZCprompt.h
//  我爱高尔夫
//
//  Created by hh on 15/5/4.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCprompt : UIView
//+ ( void)prompt:(id )viewController andErrorCode:(NSString * )errorCode;

//-(void)showAlertView:(id *)viewController andErrorCode:(NSString *)errorCode;

+(void)initWithController:(id)viewController  andErrorCode:(NSString *)errorCode;
-(instancetype)initWithFrame:(CGRect)frame andErrorCode:(NSString *)errorCode;
@end
