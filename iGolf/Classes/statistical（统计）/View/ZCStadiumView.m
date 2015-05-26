//
//  ZCStadiumView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/20.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCStadiumView.h"
#import "ZCStadiumTableViewCell.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCHistoryCoursesModel.h"
@interface ZCStadiumView()<UITableViewDataSource,UITableViewDelegate>
@property(nonatomic,strong)NSMutableArray *stadiumArray;
@end
@implementation ZCStadiumView



-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self=[super initWithFrame:frame style:style]) {
        
        [self addData];
        
        self.dataSource=self;
        self.delegate=self;
        self.rowHeight=80;
        self.backgroundColor=ZCColor(237, 237, 237);
        
        //分割线颜色
        [self   setSeparatorColor:ZCColor(170, 170, 170)];
        //让下面没内容的分割线不显示
        self.tableFooterView = [[UIView alloc] init];
        
        
    }
    return self;
}




-(void)viewDidLayoutSubviews {
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self respondsToSelector:@selector(setLayoutMargins:)])  {
        [self setLayoutMargins:UIEdgeInsetsZero];
    }
    
}

//分割线显示全
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPat{
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]){
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
}




-(NSMutableArray *)stadiumArray
{
    if (_stadiumArray==nil) {
        _stadiumArray=[NSMutableArray array];
    }
    return _stadiumArray;
}

//网络加载  /v1/venues/visited.json
-(void)addData
{
    
    //2.发送网络请求
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    mgr.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"text/html",@"text/plain",@"application/xhtml+xml",@"application/xml",@"application/json", nil];
    
    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //ZCLog(@"%@-------",account.token);
    // 说明服务器返回的JSON数据
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
   
    params[@"token"]=account.token;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/visited.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        for (NSDictionary *dict in responseObject) {
            ZCHistoryCoursesModel *historyCoursesModel=[ZCHistoryCoursesModel historyCoursesWithDict:dict];
            [self.stadiumArray addObject:historyCoursesModel];
        }
       
        
        [self reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];


    

}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.stadiumArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *myCell = @"cell_statum";
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    ZCStadiumTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[ZCStadiumTableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
        
    }
    
    cell.historyCoursesModel=self.stadiumArray[indexPath.row];
    
    
    
    return cell;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if ([self.delegater respondsToSelector:@selector(StadiumViewDidClickedcell:uuidStr:andName:)]) {
        [self.delegater StadiumViewDidClickedcell:self uuidStr:[self.stadiumArray[indexPath.row] uuid] andName:[self.stadiumArray[indexPath.row] name]];
    }

}

@end
