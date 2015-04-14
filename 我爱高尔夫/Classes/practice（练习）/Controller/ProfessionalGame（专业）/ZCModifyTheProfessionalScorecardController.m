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



@end

@implementation ZCModifyTheProfessionalScorecardController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    UIBarButtonItem *newBar= [[UIBarButtonItem alloc] initWithTitle:@"统计" style:UIBarButtonItemStyleDone target:self action:@selector(clickOnTheProfessionalStatistical)];
//    //改变UIBarButtonItem字体颜色
//    [newBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], UITextAttributeTextColor,nil] forState:UIControlStateNormal];
//    self.navigationItem.rightBarButtonItem =newBar;
    
    
    
    
    [self online];
    
    //创建显示值的view
    [self initView];
    //创建tableview
    [self initTableView];
    
    
    
    
//    CGRect frame = self.view.bounds;
//    frame.size.height = frame.size.height - 40;


}


////点击统计
//-(void)clickOnTheProfessionalStatistical
//{
//    
//    
//
//}

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
   
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
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
        
        ZCLog(@"%lu",self.selectTheDisplayArray.count);
        self.index=self.selectTheDisplayArray.count;
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    

}



//创建显示成绩的view
-(void)initView
{
    UIView *resultsView=[[UIView alloc] init];
    resultsView.backgroundColor=[UIColor redColor];
    resultsView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 60);
    [self.view addSubview:resultsView];
    //标准杆
    UILabel *parLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, 50, resultsView.frame.size.height)];
    parLabel.text=[NSString stringWithFormat:@"%@",self.scorecard.par];
    [resultsView addSubview:parLabel];
    self.parLabel=parLabel;
    
    
    //码数
    UILabel *distanceLabel=[[UILabel alloc] initWithFrame:CGRectMake(50, 0, 50, resultsView.frame.size.height)];
    distanceLabel.text=[NSString stringWithFormat:@"%@",self.scorecard.distance_from_hole_to_tee_box];
    [resultsView addSubview:distanceLabel];
    self.distanceLabel=distanceLabel;
    
   //T台颜色
    UILabel *tee_box_colorLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 0, 50, resultsView.frame.size.height)];
    tee_box_colorLabel.text=[NSString stringWithFormat:@"%@",self.scorecard.tee_box_color];
    [resultsView addSubview:tee_box_colorLabel];
    self.tee_box_colorLabel=tee_box_colorLabel;

    //本洞成绩
    UILabel *chengjiLabel=[[UILabel alloc] initWithFrame:CGRectMake(resultsView.frame.size.width-200, 0, 100, resultsView.frame.size.height)];
    chengjiLabel.text=@"本洞成绩";
    [resultsView addSubview:chengjiLabel];
    
    //chengji
    UIView *chengjiView=[[UIView alloc] initWithFrame:CGRectMake(resultsView.frame.size.width-100, 0, 80, resultsView.frame.size.height)];
    [resultsView addSubview:chengjiView];
    
    //总干
    UILabel *scoreLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, chengjiView.frame.size.width, chengjiView.frame.size.height-20)];
     [chengjiView addSubview:scoreLabel];
     self.scoreLabel=scoreLabel;

    
    //推杆
    UILabel *puttsLabel=[[UILabel alloc] initWithFrame:CGRectMake(chengjiView.frame.size.width-20, chengjiView.frame.size.height-20, 20, 20)];
    [chengjiView addSubview:puttsLabel];
    self.puttsLabel=puttsLabel;
    
    
    //罚杆
    UILabel *penaltiesLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, chengjiView.frame.size.height-20, 20, 20)];
    [chengjiView addSubview:penaltiesLabel];
    self.penaltiesLabel=penaltiesLabel;

    
    
    
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
   // tableview.autoresizingMask &= ~UIViewAutoresizingFlexibleBottomMargin;
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


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return @"挥杆";
    }else
    {
    return @"推杆";
    }
   
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
//    coverView.backgroundColor=[UIColor blackColor];
//    coverView.alpha=0.3;
//    [self.view addSubview:coverView];
    
    
    ZCChooseView *chooseView=[[ZCChooseView alloc] init];
    chooseView.frame=CGRectMake(0, 200, SCREEN_WIDTH, 300);
    chooseView.backgroundColor=[UIColor redColor];
    chooseView.scorecard_uuid=self.scorecard.uuid;
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

    
    [self.tableView addSubview:chooseView];

}


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
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);deleteUuid
    params[@"token"]=account.token;
    params[@"uuid"]=self.deleteUuid;
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"strokes.json"];
    [mgr DELETE:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        
        
                               // 从数据源删除数据
      [self.selectTheDisplayArray removeObjectAtIndex:self.indexPath.row];
        
                              // 表格删除数据，会重新调用数据源方法，产生越界
      [self.tableView deleteRowsAtIndexPaths:@[self.indexPath] withRowAnimation:UITableViewRowAnimationFade];

        
       // [NSTimer scheduledTimerWithTimeInterval:0.5f target:self selector:@selector(reloadData) userInfo:nil repeats:NO];
        
        // 模拟(2秒后执行)
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            // 移除遮盖
           
            [self.tableView reloadData];
            
        });

        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];
    

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
