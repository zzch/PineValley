//
//  ZCDouModel.h
//  iGolf
//
//  Created by hh on 15/7/30.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//斗地主保存存储数据模型

#import <Foundation/Foundation.h>

@interface ZCDouModel : NSObject
//是否是机主
@property(nonatomic,assign)int isUser;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,weak)UIImage *personImage;
//@property(nonatomic,assign)int *isOpen1;
//@property(nonatomic,assign)int *isOpen2;
//@property(nonatomic,assign)int *isOpen3;
////是什么类型的比赛 1 为比洞 2斗地主   3拉斯维加斯
//@property(nonatomic,assign)int *type;
@end
