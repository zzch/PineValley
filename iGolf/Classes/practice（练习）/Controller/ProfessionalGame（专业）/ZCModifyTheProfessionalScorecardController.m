//
//  ZCModifyTheProfessionalScorecardController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/1.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCModifyTheProfessionalScorecardController.h"
#import "ZCSwingCell.h"
#import "ZCChooseView.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCSelectTheDisplay.h"
#import "ZCProfessionalStatisticalViewController.h"
#import "ZCprompt.h"
#import "UIBarButtonItem+DC.h"
#import "MBProgressHUD+NJ.h"
@interface ZCModifyTheProfessionalScorecardController ()<UITableViewDataSource,UITableViewDelegate,ZCChooseViewDelegate>

//表示行数
@property(nonatomic,assign) NSInteger index;
@property(nonatomic,assign) UITableView *tableView;
//选中值的数组
@property(nonatomic,strong)NSMutableArray *selectTheDisplayArray;

@property(nonatomic,strong)NSIndexPath *indexPath;
//删除的uuid

@property(nonatomic,copy)NSString *deleteUuid;


//标准杆
@property(nonatomic,weak)UILabel *parLabel;
//码数
@property(nonatomic,weak)UILabel *distanceLabel;
//T台颜色
@property(nonatomic,weak)UILabel *tee_box_colorLabel;
//本洞成绩
//@property(nonatomic,weak)UILabel *parLabel;
//总干
@property(nonatomic,weak)UILabel *scoreLabel;
//推杆
@property(nonatomic,weak)UILabel *puttsLabel;
//罚杆
@property(nonatomic,weak)UILabel *penaltiesLabel;



//透明图存
@property(nonatomic,weak)UIView *chooseView;


@end

@implementation ZCModifyTheProfessionalScorecardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    //背景颜色suoyou_bj
    self.view.backgroundColor=ZCColor(237, 237, 237);

    
    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnTheProfessionalSave)];
//    //改变UIBarButtonItem字体颜色
    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem =newBar;
    
    
    //self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc]initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    
    
    
    [self online];
    
    //创建显示值的view
    [self initView];
    //创建tableview
    [self initTableView];
    
    
    
    
//    CGRect frame = self.view.bounds;
//    frame.size.height = frame.size.height - 40;


}

//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
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

//点击保存
-(void)clickOnTheProfessionalSave
{
    
    
    //加载圈圈
    [MBProgressHUD showMessage:@"数据保存中..."];
    //selectTheDisplayArray
    NSMutableArray *parameterArray=[NSMutableArray array];
    
    for (ZCSelectTheDisplay *selectTheDisplay in self.selectTheDisplayArray) {
        
        
        NSString *distance_from_hole;
        if ([selectTheDisplay.distance_from_hole isEqual:@"进洞"]) {
            distance_from_hole=@"0";
        }else{
        distance_from_hole=[NSString stringWithFormat:@"%@",selectTheDisplay.distance_from_hole];
        }
        
        
        
        NSString *point_of_fall;
        
        if ([selectTheDisplay.distance_from_hole isEqual:@"进洞"])
        {
            point_of_fall=@"hole";
        }else{
        if ([selectTheDisplay.point_of_fall isEqual:@"球道"]) {
            point_of_fall=@"fairway";

        }else if ([selectTheDisplay.point_of_fall isEqual:@"果岭"])
        {
         point_of_fall=@"green";
        }else if ([selectTheDisplay.point_of_fall isEqual:@"球道外左侧"])
        {
           point_of_fall=@"left_rough";
        }else if ([selectTheDisplay.point_of_fall isEqual:@"球道外右侧"])
        {
        point_of_fall=@"right_rough";
        }else if ([selectTheDisplay.point_of_fall isEqual:@"沙坑"])
        {
        point_of_fall=@"bunker";
        }else if ([selectTheDisplay.point_of_fall isEqual:@"不可打"])
        {
        point_of_fall=@"unplayable";
        }else
        {
            point_of_fall=[NSString stringWithFormat:@"%@",selectTheDisplay.distance_from_hole];
        }
        
        }
        NSString *penalties;
        if ([self _valueOrNil:selectTheDisplay.penalties]==nil ) {
            penalties=@"0";
        }else{
        penalties=[NSString stringWithFormat:@"%@",selectTheDisplay.penalties];
        }
        
        
        
        NSString *club;
        if ([selectTheDisplay.club isEqual:@"Driver"]) {
            club=@"1w";
        }else if ([selectTheDisplay.club isEqual:@"Putter"])
        {
            club=@"pt";
        }else if ([selectTheDisplay.club isEqual:@"3 Wood"])
        {
            club=@"3w";
        }else if ([selectTheDisplay.club isEqual:@"5 Wood"])
        {
            club=@"5w";
        }else if ([selectTheDisplay.club isEqual:@"7 Wood"])
        {
            club=@"7w";
        }else if ([selectTheDisplay.club isEqual:@"2 Hybrid"])
        {
            club=@"2h";
        }else if ([selectTheDisplay.club isEqual:@"3 Hybrid"])
        {
            club=@"3h";
        }else if ([selectTheDisplay.club isEqual:@"4 Hybrid"])
        {
            club=@"4h";
        }else if ([selectTheDisplay.club isEqual:@"5 Hybrid"])
        {
            club=@"5h";
        }else if ([selectTheDisplay.club isEqual:@"1 Iron"])
        {
            club=@"1i";
        }else if ([selectTheDisplay.club isEqual:@"2 Iron"])
        {
            club=@"2i";
        }else if ([selectTheDisplay.club isEqual:@"3 Iron"])
        {
            club=@"3i";
        }else if ([selectTheDisplay.club isEqual:@"4 Iron"])
        {
            club=@"4i";
        }else if ([selectTheDisplay.club isEqual:@"5 Iron"])
        {
            club=@"5i";
        }else if ([selectTheDisplay.club isEqual:@"6 Iron"])
        {
            club=@"6i";
        }else if ([selectTheDisplay.club isEqual:@"3 Iron"])
        {
            club=@"7i";
        }else if ([selectTheDisplay.club isEqual:@"7 Iron"])
        {
            club=@"7i";
        }else if ([selectTheDisplay.club isEqual:@"8 Iron"])
        {
            club=@"8i";
        }else if ([selectTheDisplay.club isEqual:@"9 Iron"])
        {
            club=@"9i";
        }else if ([selectTheDisplay.club isEqual:@"PW"])
        {
            club=@"pw";
        }else if ([selectTheDisplay.club isEqual:@"GW"])
        {
            club=@"gw";
        }else if ([selectTheDisplay.club isEqual:@"LW"])
        {
            club=@"lw";
        }else{
        
            club=[NSString stringWithFormat:@"%@",selectTheDisplay.club];
        }




















        
        
        
        NSString *str=[NSString stringWithFormat:@"distance_from_hole=%@, point_of_fall=%@, penalties=%@, club=%@",distance_from_hole,point_of_fall,penalties,club];
        [parameterArray addObject:str];
        
        
        ZCLog(@"%@",str);
    }
    
    [parameterArray removeLastObject];
    
    
   // ZCLog(@"%lu",parameterArray.count);
    ZCLog(@"%@",parameterArray);
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.scorecard.uuid;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    params[@"strokes"]=parameterArray;

    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"scorecards/professional.json"];
    ZCLog(@"%@",url);
    [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if (responseObject[@"error_code"] )
        {
            [ZCprompt prompt:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
        }else{
        //调用数据传递方法
            [self theDataTransfer:responseObject];
        }
        
        [MBProgressHUD hideHUD];
        
        ZCLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        
        [MBProgressHUD hideHUD];

    }];

}



//点击保存后数据传递给上个控制器
-(void)theDataTransfer:(NSDictionary *)responseObject
{
    // 1.关闭当前控制器
    [self.navigationController popViewControllerAnimated:YES];
    
    if ([self.delegate respondsToSelector:@selector(modifyTheProfessionalScorecardController:didSaveScorecardt:) ]) {
        
        
        self.scorecard.score=responseObject[@"score"];
        self.scorecard.putts=responseObject[@"putts"];
        self.scorecard.penalties=responseObject[@"penalties"];
        
    self.scorecard.driving_distance=responseObject[@"driving_distance"];
        
        
        self.scorecard.direction=responseObject[@"direction"];
        
        
        [self.delegate modifyTheProfessionalScorecardController:self didSaveScorecardt:self.scorecard];
    }
    
    
    

}





-(NSMutableArray *)selectTheDisplayArray
{
    if (_selectTheDisplayArray==nil) {
        _selectTheDisplayArray=[NSMutableArray array];
        
        ZCSelectTheDisplay *selectTheDisplay=[[ZCSelectTheDisplay alloc] init];
        
        [_selectTheDisplayArray addObject:selectTheDisplay];
        
    }
    return _selectTheDisplayArray;
}

//网络请求
-(void)online
{
   
    
    //加载圈圈
    [MBProgressHUD showMessage:@"加载中..."];
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    ZCLog(@"%@",self.scorecard.uuid);
    params[@"scorecard_uuid"]=self.scorecard.uuid;
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    ZCLog(@"%@",account.token);
    ZCLog(@"%@",self.scorecard.uuid);
    ///v1/matches/show.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"strokes.json"];

    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        NSMutableArray *tempArray=[NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            
            ZCSelectTheDisplay *selectTheDisplay=[ZCSelectTheDisplay selectTheDisplayWithDict:dict];
            [tempArray addObject:selectTheDisplay];

        }
        //将新数组插入到旧数组中
        NSRange range = NSMakeRange(0, tempArray.count);
        NSIndexSet *indexSet = [NSIndexSet indexSetWithIndexesInRange:range];
        [self.selectTheDisplayArray insertObjects:tempArray atIndexes:indexSet];
        
       // ZCLog(@"%lu",self.selectTheDisplayArray.count);
        self.index=self.selectTheDisplayArray.count;
        [self.tableView reloadData];
        
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
        [MBProgressHUD hideHUD];
    }];
    

}



//创建显示成绩的view
-(void)initView
{
    UIView *resultsView=[[UIView alloc] init];
    resultsView.backgroundColor=ZCColor(60, 57, 78);
    resultsView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 50);
    [self.view addSubview:resultsView];
    //标准杆
    UILabel *parLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, SCREEN_WIDTH*0.197, resultsView.frame.size.height)];
    parLabel.text=[NSString stringWithFormat:@"%@标准杆",self.scorecard.par];
    parLabel.textColor=[UIColor whiteColor];
    [resultsView addSubview:parLabel];
    self.parLabel=parLabel;
    
    
    //码数
    UILabel *distanceLabel=[[UILabel alloc] initWithFrame:CGRectMake(parLabel.frame.size.width+parLabel.frame.origin.x+SCREEN_WIDTH*0.04, 0, SCREEN_WIDTH*0.156, resultsView.frame.size.height)];
   // distanceLabel.text=[NSString stringWithFormat:@"%@码",self.scorecard.distance_from_hole_to_tee_box];
    distanceLabel.textColor=[UIColor whiteColor];
    [resultsView addSubview:distanceLabel];
    self.distanceLabel=distanceLabel;
    
   //T台颜色
    UILabel *tee_box_colorLabel=[[UILabel alloc] initWithFrame:CGRectMake(distanceLabel.frame.size.width+distanceLabel.frame.origin.x+SCREEN_WIDTH*0.02, 0, SCREEN_WIDTH*0.198, resultsView.frame.size.height)];
//    if ([self.scorecard.tee_box_color isEqual:@"white"]) {
//        tee_box_colorLabel.text=@"白T";
//    }else if ([self.scorecard.tee_box_color isEqual:@"red"])
//    {
//    tee_box_colorLabel.text=@"红T";
//    }else if ([self.scorecard.tee_box_color isEqual:@"blue"])
//    {
//     tee_box_colorLabel.text=@"蓝T";
//    }else if ([self.scorecard.tee_box_color isEqual:@"black"])
//    {
//    tee_box_colorLabel.text=@"黑T";
//    }else if ([self.scorecard.tee_box_color isEqual:@"gold"])
//    {
//    tee_box_colorLabel.text=@"金T";
//    }
    
    tee_box_colorLabel.textColor=[UIColor whiteColor];
    [resultsView addSubview:tee_box_colorLabel];
    self.tee_box_colorLabel=tee_box_colorLabel;
    
    
    
    
//    //本洞成绩
//    UILabel *chengjiLabel=[[UILabel alloc] initWithFrame:CGRectMake(resultsView.frame.size.width-resultsView.frame.size.width*0.343, 0, SCREEN_WIDTH*0.171, resultsView.frame.size.height)];
//    chengjiLabel.text=@"本洞成绩";
//    chengjiLabel.textColor=ZCColor(240, 208, 122);
//    [resultsView addSubview:chengjiLabel];
//    
//    //chengji
//    UIView *chengjiView=[[UIView alloc] initWithFrame:CGRectMake(chengjiLabel.frame.size.width+chengjiLabel.frame.origin.x+SCREEN_WIDTH*0.04, 0, SCREEN_WIDTH-(chengjiLabel.frame.size.width+chengjiLabel.frame.origin.x+SCREEN_WIDTH*0.04), resultsView.frame.size.height)];
//    [resultsView addSubview:chengjiView];
//    
//    //总干
//    UILabel *scoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, chengjiView.frame.size.width, chengjiView.frame.size.height-20)];
//     [chengjiView addSubview:scoreLabel];
//     self.scoreLabel=scoreLabel;
//
//    
//    //推杆
//    UILabel *puttsLabel=[[UILabel alloc] initWithFrame:CGRectMake(chengjiView.frame.size.width-20, chengjiView.frame.size.height-20, 20, 20)];
//    [chengjiView addSubview:puttsLabel];
//    self.puttsLabel=puttsLabel;
//    
//    
//    //罚杆
//    UILabel *penaltiesLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, chengjiView.frame.size.height-20, 20, 20)];
//    [chengjiView addSubview:penaltiesLabel];
//    self.penaltiesLabel=penaltiesLabel;
//
    
    
    
}
//创建tableView
-(void)initTableView
{

    //创建tableview
    UITableView *tableview=[[UITableView alloc] init];
    tableview.frame=CGRectMake(0, 60, SCREEN_WIDTH, SCREEN_HEIGHT-60);
    [self.view addSubview:tableview];
    self.tableView=tableview;
    tableview.delegate=self;
    tableview.dataSource=self;
    tableview.rowHeight=50;
    
    tableview.backgroundColor=ZCColor(237, 237, 237);
    
    [tableview   setSeparatorColor:ZCColor(170, 170, 170)];
    //让下面没内容的分割线不显示
    tableview.tableFooterView = [[UIView alloc] init];
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, tableview.rowHeight, 0);
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    if (self.index) {
//       
//        return self.index;
//    }else{
//        self.index=1;
//        return self.index;
//    }
    
    return self.selectTheDisplayArray.count;
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 35;
}


// 设置每一组的头View

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
 
    UIView *view=[[UIView alloc] init];
    view.frame=CGRectMake(0, 0, SCREEN_WIDTH, 35);
    //view.backgroundColor=[UIColor blackColor];

    UILabel *label1=[[UILabel alloc] init];
    label1.frame=CGRectMake(0, 0, SCREEN_WIDTH*0.153,view.frame.size.height );
    label1.text=@"杆";
    label1.textAlignment=NSTextAlignmentCenter;
    label1.textColor=ZCColor(85, 85, 85);
    [view addSubview:label1];
    
    
    
    UILabel *label2=[[UILabel alloc] init];
    label2.frame=CGRectMake(label1.frame.size.width+label1.frame.origin.x, 0, SCREEN_WIDTH*0.297,view.frame.size.height );
    label2.text=@"距离球洞/码";
    label2.textAlignment=NSTextAlignmentCenter;
    label2.textColor=ZCColor(85, 85, 85);
    [view addSubview:label2];

    
    
    UILabel *label3=[[UILabel alloc] init];
    label3.frame=CGRectMake(label2.frame.size.width+label2.frame.origin.x, 0, SCREEN_WIDTH*0.227,view.frame.size.height );
    label3.text=@"球的状态";
    label3.textAlignment=NSTextAlignmentCenter;
    label3.textColor=ZCColor(85, 85, 85);
    [view addSubview:label3];
    
    
    UILabel *label4=[[UILabel alloc] init];
    label4.frame=CGRectMake(label3.frame.size.width+label3.frame.origin.x, 0, SCREEN_WIDTH*0.172,view.frame.size.height );
    label4.text=@"罚杆";
    label4.textAlignment=NSTextAlignmentCenter;
    label4.textColor=ZCColor(85, 85, 85);
    [view addSubview:label4];
    
    
    
    UILabel *label5=[[UILabel alloc] init];
    label5.frame=CGRectMake(label4.frame.size.width+label4.frame.origin.x, 0, SCREEN_WIDTH-(label4.frame.size.width+label4.frame.origin.x),view.frame.size.height );
    label5.text=@"球杆";
    label5.textAlignment=NSTextAlignmentCenter;
    label5.textColor=ZCColor(85, 85, 85);
    [view addSubview:label5];

    
    UIView *bjView=[[UIView alloc] init];
    bjView.frame=CGRectMake(0, view.frame.size.height-1, SCREEN_WIDTH, 1);
    bjView.backgroundColor=ZCColor(170, 170, 170);
    [view addSubview:bjView];
    
    
    return view;
    
}





- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *distanceCell = @"distanceCellID";
    ZCSwingCell  *cell = [tableView dequeueReusableCellWithIdentifier:distanceCell];
    if (cell==nil) {
        cell=[[ZCSwingCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:distanceCell];
    }

   // ZCSelectTheDisplay
    cell.selectTheDisplay=self.selectTheDisplayArray[indexPath.row];
    //传递序号
    cell.sequence=indexPath.row+1;
    
    return cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    UIView *coverView=[[UIView alloc] init];
//    coverView.frame=[UIScreen mainScreen].bounds;
//    coverView.backgroundColor=[[UIColor blackColor] colorWithAlphaComponent:0.4];
//    //coverView.alpha=0.3;
//    [self.view addSubview:coverView];
//    
    
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    
    
    ZCChooseView *chooseView=[[ZCChooseView alloc] init];
    chooseView.frame=[UIScreen mainScreen].bounds;
    
    
    
    //chooseView.scorecard_uuid=self.scorecard.uuid;
    chooseView.delegate=self;
    
    //有值
    ZCSelectTheDisplay *selectTheDisplay= self.selectTheDisplayArray[indexPath.row];
    if (selectTheDisplay.point_of_fall) {
        chooseView.isYes=@"yes";
        chooseView.uuid=selectTheDisplay.uuid;
        self.indexPath=indexPath;
  
    }else
    {
        chooseView.isYes=@"no";

    }

    [wd addSubview:chooseView];
    self.chooseView=chooseView;
    //[self.tableView addSubview:chooseView];

}


////点击透明的图存
//-(void)chooseViewClick
//{
//
//}



- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        [self alert];
        self.indexPath=indexPath;
        ZCSelectTheDisplay *selectTheDisplay= self.selectTheDisplayArray[indexPath.row];
       self.deleteUuid =selectTheDisplay.uuid;
        // 从数据源删除数据
//              [self.selectTheDisplayArray removeObjectAtIndex:indexPath.row];
//        
//               // 表格删除数据，会重新调用数据源方法，产生越界
//               [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }

}



-(void)alert
{
    // 弹框
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"是否要删除该比赛记录" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    // 设置对话框的类型
    alert.alertViewStyle = UIKeyboardTypeNumberPad;
    
    [alert show];
    
}

#pragma mark - alertView的代理方法
/**
 *  点击了alertView上面的按钮就会调用这个方法
 *
 *  @param buttonIndex 按钮的索引,从0开始
 */

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        
        return;
    }else
    {
        ///v1/matches.json
       [self deleteData];
        
//                       // 从数据源删除数据
//              [self.selectTheDisplayArray removeObjectAtIndex:self.indexPath.row];
//        
//                      // 表格删除数据，会重新调用数据源方法，产生越界
//              [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }
    
    
    
}


//删除数据/v1/strokes.json
-(void)deleteData
{
//    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
//    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
//    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
//    
//    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);deleteUuid
//    params[@"token"]=account.token;
//    params[@"uuid"]=self.deleteUuid;
//    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"strokes.json"];
//    [mgr DELETE:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
//        ZCLog(@"%@",responseObject);
    
        
        
                               // 从数据源删除数据
      [self.selectTheDisplayArray removeObjectAtIndex:self.indexPath.row];
        
                              // 表格删除数据，会重新调用数据源方法，产生越界
      [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];

        [self.tableView reloadData];
       // [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
        
        // 模拟(2秒后执行)
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//            // 移除遮盖
//           
//            [self.tableView reloadData];
//            
//        });
//
    
//    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//        ZCLog(@"%@",error);
//    }];
    

}


////刷新控件
//-(void)reloadData
//{
//  [self.tableView reloadData];
//}

//ZCChooseView的代理方法
-(void)ZCChooseView:(ZCChooseView *)ZCChooseView clickdetermineButtonAndSelectTheDisplay:(ZCSelectTheDisplay *)selectTheDisplay andScore:(NSString *)score andPenalties:(NSString *)penalties andPutts:(NSString *)putts
{
    if ([selectTheDisplay.distance_from_hole isEqual:@"0"]) {
       
    }else
    {
        //self.index=self.index+1;
      
       
    }
        [self.selectTheDisplayArray insertObject:selectTheDisplay atIndex:self.selectTheDisplayArray.count-1];
    
    
    
    self.scoreLabel.text=[NSString stringWithFormat:@"%@",score];
    self.penaltiesLabel.text=[NSString stringWithFormat:@"%@",penalties];
    self.puttsLabel.text=[NSString stringWithFormat:@"%@",putts];
    [self.tableView reloadData];

}

-(void)ZCChooseView:(ZCChooseView *)ZCChooseView clickdetermineButtonAndModifyDataWithSelectTheDisplay:(ZCSelectTheDisplay *)selectTheDisplay andScore:(NSString *)score andPenalties:(NSString *)penalties andPutts:(NSString *)putts{
     // 1.替换模型数据
    
    [self.selectTheDisplayArray replaceObjectAtIndex:_indexPath.row withObject:selectTheDisplay];
    
    
    self.scoreLabel.text=[NSString stringWithFormat:@"%@",score];
    self.penaltiesLabel.text=[NSString stringWithFormat:@"%@",penalties];
    self.puttsLabel.text=[NSString stringWithFormat:@"%@",putts];
    [self.tableView reloadData];

}



//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
