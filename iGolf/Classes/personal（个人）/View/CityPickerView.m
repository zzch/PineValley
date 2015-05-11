//
//  CityPickerView.m
//  MoshActivity
//
//  Created by mosh on 13-5-7.
//  Copyright (c) 2013年 com.mosh. All rights reserved.
//

#import "CityPickerView.h"
//#import "GlobalConfig.h"

@implementation CityPickerView
@synthesize delegate;

static NSString *_cityName = @"CityName";//城市名称


- (id)initWithFrame:(CGRect)frame section:(NSInteger)section
{
    self = [super initWithFrame:frame];
    if (self) {
        if (section < 1 || section > 3) {
            _section = 2;
        }
        else {
            _section = section;
        }
        [self makeView];
        [self ShowPickerView:self];
    }
    return self;
}

- (void) makeView
{
    self.isSelectDetail = YES;
    _provinceArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    pickView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    
    CGRect screenRect=[[UIScreen mainScreen] bounds];
    CGSize pickSize=[pickView sizeThatFits:CGSizeZero];
    
    pickView.dataSource = self;
    pickView.delegate = self;
    pickView.showsSelectionIndicator = YES;
    pickView.frame = CGRectMake(0, 30, 320, pickSize.height);
    [self addSubview:pickView];
    
    UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 30)];
    UIBarButtonItem *space = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    UIBarButtonItem *done = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    toolBar.items = [NSArray arrayWithObjects:space,done, nil];
    
    [self addSubview:toolBar];
    
    self.frame = CGRectMake(0,screenRect.size.height, 320, pickSize.height + 30);
     [self getCityName];
}

#pragma mark - pickViewDataSouce -
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return _section;
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return [_provinceArray count];
    }
    else if (component == 1){
        return [_cityArray count];
    }
    else if (component == 2) {
        return [_countyArray count];
    }
    else {
        return 0;
    }
}

#pragma mark - pickViewDelegate -


- (void) pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
    if (component == 0) {
        NSDictionary *province = [_provinceArray objectAtIndex:row];
        [_cityArray removeAllObjects];
        _cityArray = [NSMutableArray arrayWithArray:province[@"city"]];
        [_cityArray insertObject:@{@"id":@10000,@"name":@"请选择",@"upCity":@[]} atIndex:0];
        if (_section > 1) {
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            [self pickerView:pickerView didSelectRow:0 inComponent:1];
        }
      
    }
    else if (component == 1) {
        NSDictionary *city = [_cityArray objectAtIndex:row];
        [_countyArray removeAllObjects];
        _countyArray = [NSMutableArray arrayWithArray:city[@"upCity"]];
        [_countyArray insertObject:@{@"id":@10000,@"name":@"请选择"} atIndex:0];
        if (_section > 2) {
            [pickerView reloadComponent:2];
            [pickerView selectRow:0 inComponent:2 animated:YES];
        }
    }
}

- (NSString *) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSArray *selectArray = [NSArray new];
    if (component == 0) {
        selectArray = _provinceArray;
    }
    else if (component == 1) {
        selectArray = _cityArray;
    }
    else if (component == 2) {
        selectArray = _countyArray;
    }
    
    NSDictionary *province  = selectArray[row];
    NSString *name = province[@"name"];
    return name;

}

- (void) getCityName
{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"city2" ofType:@"plist"];
    NSDictionary *file = [NSDictionary dictionaryWithContentsOfFile:path];
    
    
    if ([file isKindOfClass:[NSDictionary class]]) {
        NSDictionary *cityList = file[@"citylist"];
        _provinceArray = cityList[@"province"];
        
        }
    
    [pickView reloadAllComponents];
    [self pickerView:pickView didSelectRow:0 inComponent:0];
}

-(void)ShowPickerView:(UIView *)view
{
    if(view.superview==nil)
    {
        CGRect screenRect=[[UIScreen mainScreen] bounds];
        CGRect pickRect=CGRectMake(0.0,screenRect.size.height - view.frame.size.height,320,view.frame.size.height);
        
        [UIView beginAnimations:nil context:NULL];
        [UIView setAnimationDuration:0.3];
        [UIView setAnimationDelegate:self];
        view.frame=pickRect;
        [UIView commitAnimations];
    }
    
}
//PickerView Disappear
-(void)PickerViewDisappear:(UIView *)view
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    CGRect endFrame = CGRectMake(0, screenRect.size.height, 320, view.frame.size.height);
    endFrame.origin.y=screenRect.origin.y+screenRect.size.height;
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    view.frame=endFrame;
    [UIView commitAnimations];
    
    [self removeFromSuperview];
    
}

- (void) done
{
    
    if ([self.delegate respondsToSelector:@selector(selectedAddress:cityPicker:)]) {
        AddressModel *model = [AddressModel new];
        
        if (_provinceArray && _provinceArray.count > 0) {
             NSInteger row1 = [pickView selectedRowInComponent:0];
            if (row1 < [_provinceArray count]) {
              NSDictionary *province = [_provinceArray objectAtIndex:row1];
                model.province = province[@"name"];
                model.proid = [province[@"id"] stringValue];
            }
        }
        
        if (_section > 1) {
            NSInteger row2 = [pickView selectedRowInComponent:1];
            if (row2 < [_cityArray count]) {
                NSDictionary *city = [_cityArray objectAtIndex:row2];
                model.city = city[@"name"];
                model.cityid = [city[@"id"] stringValue];
            }
        }
        
        if (_section > 2) {
            NSInteger row3 = [pickView selectedRowInComponent:2];
            if (row3 < [_countyArray count]) {
                NSDictionary *county = [_countyArray objectAtIndex:row3];
                model.county = county[@"name"];
                model.countyid = [county[@"id"] stringValue];
            }
        }
        
//        if (self.isSelectDetail) {
//            if ([model.cityid isEqualToString:@"10000"]) {
//                //[GlobalConfig alert:@"请选择详细地址"];
//                return;
//            }
//            if ([model.countyid isEqualToString:@"10000"]) {
//              //  [GlobalConfig alert:@"请选择详细地址"];
//                return;
//            }
//        }
        [self.delegate selectedAddress:model cityPicker:self];
    }
    [self PickerViewDisappear:self];
}

- (void) removePickerView
{
    if (self.superview) {
        [self removeFromSuperview];
    }
}

//+ (AddressModel *) cityNameOfAddressModel:(AddressModel *)model
//{
//    NSString *path = [[NSBundle mainBundle] pathForResource:@"city2" ofType:@"plist"];
//    NSDictionary *file = [NSDictionary dictionaryWithContentsOfFile:path];
//    
//    if ([file isKindOfClass:[NSDictionary class]]) {
//        NSDictionary *cityList = file[@"citylist"];
//        NSArray *proArray = cityList[@"province"];
//        //省
//        for (NSDictionary *dic in proArray) {
//            if (model.proid && [model.proid isEqualToString:dic[@"id"]]) {
//                model.province = dic[@"name"];
//            
//                //市
//                NSArray *cityArr = [GlobalConfig convertToArray:dic[@"city"]];
//                for (NSDictionary *cityDic in cityArr) {
//                    if (model.cityid && [model.cityid isEqualToString:cityDic[@"id"]]) {
//                        model.city = cityDic[@"name"];
//                        
//                        //县
//                        NSArray *countryArr = [GlobalConfig convertToArray:dic[@"upCity"]];
//                        for (NSDictionary *countryDic in countryArr) {
//                            if (model.countyid && [model.county isEqualToString:countryDic[@"id"]]) {
//                                model.county = countryDic[@"name"];
//                            }
//                        }
//                    }
//                
//                }
//            }
//        }
//    }
//    return model;
//
//}
//
@end

@implementation AddressModel

- (id) init
{
    if (self = [super init]) {
    }
    return self;
}

@end


