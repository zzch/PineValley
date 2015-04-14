//
//  CityPickerView.h
//  MoshActivity
//
//  Created by mosh on 13-5-7.
//  Copyright (c) 2013年 com.mosh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AddressModel;

@protocol CityPickerViewDelegate;
@interface CityPickerView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    NSMutableArray *_provinceArray;
    NSMutableArray *_cityArray;
    NSMutableArray *_countyArray;
    NSInteger _section;
    //    NSMutableDictionary *totalCityDic;
    UIPickerView *pickView;
}
@property (assign, nonatomic) id <CityPickerViewDelegate> delegate;
@property (assign, nonatomic) BOOL isSelectDetail;//是否需要选择详细地址
/**
 *  列数 两列为省-市 三列为省-市-县；
 *  默认为两列
 *  @param section
 */
- (id)initWithFrame:(CGRect)frame section:(NSInteger)section;

- (void) removePickerView;

//根据id获取name
+ (AddressModel *) cityNameOfAddressModel:(AddressModel *)model;

@end

@protocol CityPickerViewDelegate <NSObject>


- (void) selectedAddress:(AddressModel *)model cityPicker:(CityPickerView *)picker;

@end

@interface AddressModel : NSObject

@property (nonatomic, strong) NSString *province;//省
@property (nonatomic,strong) NSString *city;//市
@property (nonatomic, strong) NSString *county;//县
@property (nonatomic, strong) NSString *proid;
@property (nonatomic, strong) NSString *cityid;
@property (nonatomic, strong) NSString *countyid;
@end
