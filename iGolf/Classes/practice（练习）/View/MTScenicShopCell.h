//
//  MTScenicShopCell.h
//  MyTravel
//
//  Created by ranki on 14-12-15.
//  Copyright (c) 2014年 mytravel. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "DLStarRatingControl.h"

@interface MTScenicShopCell : UITableViewCell

@property (nonatomic,strong)NSString *scenic_name;
@property (nonatomic,strong)UIImageView *iconView;
@property (nonatomic,strong)UIButton *phoneBtn;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)UILabel *addressLab;
@property (nonatomic,strong)UILabel *nameLab;
//@property (nonatomic,strong)MTLocationModel *locationModel;
@property (nonatomic,strong)UILabel *priceLab;
//@property (nonatomic,strong)DLStarRatingControl *starRatingControl;
@property (nonatomic,assign)CGFloat rating;
@property (nonatomic,strong)NSMutableArray *goods;
@property (nonatomic,assign)long long shopId;
@property (nonatomic,assign)long long scenicId;
@property (nonatomic,strong)UILabel *distanceLab;
@property (nonatomic,assign)int height;

@end
