//
//  WWTool.h
//  WeWish
//
//  Created by hh on 15/6/22.
//  Copyright (c) 2015年 WeWish. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZCTool : NSObject

/**

  根据字符串计算出宽高
 
 */
+(CGRect)getFrame:(CGSize)frame content:(NSString *)content fontSize:(UIFont *)fontSize;

/**
 *  图片拉升  imageStr 为图片的名字
 *
 */
+(UIImage *)imagePullLitre:(NSString *)imageStr;

//手机号验证
+ (BOOL)validateMobile:(NSString *)mobileNum;
@end
