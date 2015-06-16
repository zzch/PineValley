//
//  ZCWedgeViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/15.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCWedgeViewController.h"
#import "ZCWedgeFirstCell.h"
#import "ZCWedgeSecondCell.h"
#import "ZCWedgeThirdCell.h"
#import "ZCWedgeModel.h"
@interface ZCWedgeViewController ()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *upAndDownsArray;
@end

@implementation ZCWedgeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.bounces=NO;
    self.tableView.backgroundColor=ZCColor(237, 237, 237);
    self.navigationItem.title=@"一切一推";
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
    
    //让下面没内容的分割线不显示
    self.tableView.tableFooterView = [[UIView alloc] init];
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(liftBthClick:) target:self];

    
    [self initData];
}



//返回
-(void)liftBthClick:(UIButton *)btn
{
    
    [self.navigationController popViewControllerAnimated:YES];
}


//添加数据
-(void)initData
{
    if ([self _valueOrNil:self.wedgeModel[@"up_and_downs"]]==nil) {
        
    }else{
        
        NSMutableArray *upAndDownsArray=[NSMutableArray array];
        self.upAndDownsArray=upAndDownsArray;
        NSArray *tempArray=self.wedgeModel[@"up_and_downs"];
        
        ZCLog(@"%@",self.wedgeModel[@"up_and_downs"]);
        for (NSDictionary *dict in tempArray) {
            
            ZCWedgeModel *wedgeModel=[ZCWedgeModel wedgeModelWithDict:dict];
            [self.upAndDownsArray addObject:wedgeModel];
            
        }

    
    }

    
    

}



- (id) _valueOrNil:(id)obj {
    if (!obj) {
        return nil;
    }
    if (obj == [NSNull null]) {
        return nil;
    }
    return obj;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.upAndDownsArray.count+2;
}

    


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        NSString *myCell1 = @"cell_01";
        ZCWedgeFirstCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell1];
        
        if (cell == nil) {
            cell = [[ZCWedgeFirstCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell1];
        }
        
        cell.wedgeModel=self.wedgeModel;
        
        return cell;

        
    }else if (indexPath.row>0 &&indexPath.row<self.upAndDownsArray.count+1)
    {
        NSString *myCell2 = @"cell_02";
        ZCWedgeSecondCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell2];
        
        if (cell == nil) {
            cell = [[ZCWedgeSecondCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell2];
        }
        
        cell.wedgeModel=self.upAndDownsArray[indexPath.row-1];
        cell.indexPath=indexPath;
        return cell;

    }else{
        NSString *myCell3 = @"cell_03";
        ZCWedgeThirdCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell3];
        
        if (cell == nil) {
            cell = [[ZCWedgeThirdCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell3];
        }
        cell.wedgeModel=self.wedgeModel;
        return cell;

    
    }
  }



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0) {
        return 100;
    }else if (indexPath.row==self.upAndDownsArray.count+1)
    {
        return 150;
    }else
    {
        return 60;
    }
}




@end
