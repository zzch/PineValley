//
//  ZCSwingCell.h
//  我爱高尔夫
//
//  Created by hh on 15/4/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZCSelectTheDisplay.h"
@interface ZCSwingCell : UITableViewCell
@property(nonatomic,strong)ZCSelectTheDisplay *selectTheDisplay;
@property(nonatomic,assign) long sequence;
@end
