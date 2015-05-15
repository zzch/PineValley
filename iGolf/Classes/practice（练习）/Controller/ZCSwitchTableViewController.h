//
//  ZCSwitchTableViewController.h
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZCSwitchTableViewController;
@protocol ZCSwitchTableViewControllerDelegate<NSObject>
@optional
-(void)ZCSwitchTableViewController:(ZCSwitchTableViewController *)SwitchTableViewController  andUuid:(NSString *)uuid;

@end
@interface ZCSwitchTableViewController : UITableViewController


@property(nonatomic,strong)id<ZCSwitchTableViewControllerDelegate>delegaterr;
@end
