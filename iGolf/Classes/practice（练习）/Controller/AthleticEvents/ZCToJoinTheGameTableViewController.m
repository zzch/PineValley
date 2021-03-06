//
//  ZCToJoinTheGameTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/27.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCToJoinTheGameTableViewController.h"
#import "ZCChildStadium.h"
#import "ZCNameJoinTableViewCell.h"
#import "ZCModelTableViewCell.h"
#import "ZCNoteTableViewCell.h"
#import "ZCChildNameTableViewCell.h"
#import "ZCSettingHeadView.h"
#import "ZCCompetitiveScorecardTableViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCToTheGameModel.h"
#import "ZCCoursesModel.h"
#import "ZCScorecardTableViewController.h"
#import "UIBarButtonItem+DC.h"
#import "ZCQuickScoringTableViewController.h"
@interface ZCToJoinTheGameTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCSettingHeadViewDelegate>
@property(nonatomic,assign) int count;
// 标记一下是否展开，YES：展开，NO：收起
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property (nonatomic, assign, getter = isOpened2) BOOL opened2;
@property (nonatomic, assign, getter = isOpened3) BOOL opened3;
@property(nonatomic,weak)UIButton *startButton;

//保存用户选择前9洞的T台
@property(nonatomic,copy) NSString *firstTeeBox;
//保存用户选择后9洞的T台
@property(nonatomic,copy) NSString *lastTeeBox;
/**
 *  数据模型
 */
@property(nonatomic,strong)ZCToTheGameModel *toTheGameModel;

/**
 *  保存计分方式
 */
@property(nonatomic,copy)NSString *type;
@end

@implementation ZCToJoinTheGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    

    
    self.navigationItem.title=@"加入比赛";
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"fanhui" hightImageName:@"fanhui" action:@selector(toJoinTheGameliftBthTheClick:) target:self];
    //让分割线不显示
    // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //分割线颜色
    [self.tableView   setSeparatorColor:ZCColor(170, 170, 170)];
    //让下面没内容的分割线不显示
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    self.tableView.backgroundColor=ZCColor(237, 237, 237);
    
     self.tableView.rowHeight=45;

     self.tableView.sectionHeaderHeight = 52;
    //加载数据
    [self onlineData];
    //添加控件
    [self addControls];
}




-(void)toJoinTheGameliftBthTheClick:(UIButton *)btn
{
    for (id viewController in self.navigationController.viewControllers) {
        
        if ([viewController isKindOfClass:[ZCQuickScoringTableViewController class]]) {
            [self.navigationController popToViewController:viewController animated:YES];
            break;
        }
    }

}

//网络加载数据
-(void)onlineData
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuid;
    params[@"token"]=account.token;
    
    
    //发送请求/v1/courses/show.json
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/summary.json"];
    ZCLog(@"%@",url);
     ZCLog(@"%@",_uuid);
     ZCLog(@"%@",account.token);
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        self.toTheGameModel=[ZCToTheGameModel toTheGameModelWithDict:responseObject];
        
       
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"%@",error);
    }];


}








//添加控件
-(void)addControls
{
    UIButton *startButton=[[UIButton alloc] init];
    CGFloat startButtonX=0;
    
    CGFloat startButtonW=SCREEN_WIDTH;
    CGFloat startButtonH=50;
    CGFloat startButtonY=SCREEN_HEIGHT-startButtonH;
    
    startButton.frame=CGRectMake(startButtonX, startButtonY, startButtonW, startButtonH);
    
    // startButton.frame=CGRectMake(0, 300, 317, 40);
    [startButton setTitle:@"加入比赛" forState:UIControlStateNormal];
    startButton.backgroundColor=ZCColor(100, 175, 102);
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickDidStartButton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:startButton];
    // startButton.userInteractionEnabled=NO;
    startButton.enabled=NO;
    self.startButton=startButton;
    
    
    
}

//点击加入比赛
-(void)clickDidStartButton
{
    
    [MBProgressHUD showMessage:@"请稍后..."];
    ZCScorecardTableViewController *ScorecardTableViewController=[[ZCScorecardTableViewController alloc] init];
   
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    params[@"uuid"]=self.uuid;
    //ZCLog(@"%@",self.athleticEventsModel.uuid);
    params[@"token"]=account.token;
  
    if (self.lastTeeBox==nil) {
        params[@"tee_boxes"]=self.firstTeeBox;
    }else
    {
       params[@"tee_boxes"]=[NSString stringWithFormat:@"%@,%@",self.firstTeeBox,self.lastTeeBox];
    }
    
    if ([self.type isEqual:@"简单"]) {
        params[@"scoring_type"]=@"simple";
    }else
    {
        params[@"scoring_type"]=@"professional";
    }

    
    //发送请求/v1/matches/tournament/participate.json
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/participate.json"];

    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            [MBProgressHUD hideHUD];
        }else
        {
        
        
        //传值
        ScorecardTableViewController.uuid=self.uuid;
        
        [self.navigationController pushViewController:ScorecardTableViewController animated:YES];
        
            [MBProgressHUD hideHUD];
            [MBProgressHUD showSuccess:@"加入比赛成功"];
        }
       
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
         [MBProgressHUD hideHUD];
         [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        
    }];
    
    
    
    
    
    

}



-(void)viewWillDisappear:(BOOL)animated
{
    self.startButton.hidden=YES;
    //[self.startButton removeFromSuperview];
}
-(void)viewWillAppear:(BOOL)animated
{
    self.startButton.hidden=NO;
}



//是否可以点击开始按钮
-(void)canStart
{
    
    
    
    self.startButton.enabled=NO;
    self.startButton.backgroundColor=ZCColor(100, 175, 102);
    //ZCLog(@"进入该方法了");
    
    ZCCoursesModel *CoursesModel=self.toTheGameModel.venue.courses[0];
    
    if (CoursesModel.holes_count==18) {
        if (self.firstTeeBox) {
            
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=ZCColor(9, 133, 12);
            
        }
        

    }else if(CoursesModel.holes_count==9)
    {
        if (self.firstTeeBox &&self.lastTeeBox) {
            
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=ZCColor(9, 133, 12);
            
        }

    }
   
        
        
        
 }




#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.count) {
        return self.count;
    }else
    {
        return 3;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section==0) {
        return (self.opened1? 0:2) ;
    }else if (section==1)
    {
        return 0;
    }else if (section==2)
  
    {
         ZCLog(@"%@",self.toTheGameModel.venue.courses);
        ZCCoursesModel *coursesModel=self.toTheGameModel.venue.courses[0];
       ;
      return (self.opened2? 0:coursesModel.tee_boxes.count) ;
    }else if (section==3)
    {
        return 0;
    }else
    {
        ZCCoursesModel *coursesModel=self.toTheGameModel.venue.courses[1];
        return (self.opened3? 0:coursesModel.tee_boxes.count) ;

       
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    
    NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], (long)[indexPath row]];
    UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
    }

    
    
    
    
    if (indexPath.section==0) {
        if (indexPath.row==0) {
            cell.textLabel.text=@"简单";
        }else
        {
            cell.textLabel.text=@"专业";
            
        }

    }else if (indexPath.section==2)
    {
        ZCCoursesModel *teeModel=self.toTheGameModel.venue.courses[0];
        NSString *tee=teeModel.tee_boxes[indexPath.row];
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }
        
    }else if (indexPath.section==4)
    {
        ZCCoursesModel *teeModel=self.toTheGameModel.venue.courses[1];
        NSString *tee=teeModel.tee_boxes[indexPath.row];
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }

        
    }

    
        
        return cell;
    
    }




//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.section==2) {
//        CGSize size = [self.athleticEventsModel.remark sizeWithFont:[UIFont systemFontOfSize:24] constrainedToSize:CGSizeMake(220, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
//        
//
//        if (size.height>50) {
//            return size.height;
//        }else
//        {
//            return 50;
//        }
//        
//    }else
//    {
//        return 60;
//    }
//}









#pragma mark - ZCSettingHeaderView的代理方法
-(void)headerViewDidClicked:(ZCSettingHeadView *)headerView didClickButton:(UIButton *)button
{
    
    if (button.tag==3333) {
        self.opened1=!self.opened1;
        
        
     }else if(button.tag==4444)
    {
        self.opened2=!self.opened2;
        
    }else if (button.tag==5555)
    {
    self.opened3=!self.opened3;
    }
    
    
    [self.tableView reloadData];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 60;
//    if (section==4) {
//        return 60;
//    }else if (section==6)
//    {
//        return 60;
//    }else
//    {
//        return 0;
//    }
}

//分割线显示全
-(void)viewDidLayoutSubviews {
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)])  {
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
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



// 设置每一组的头View

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个View
    ZCSettingHeadView *headerView=[ZCSettingHeadView headerViewWithTableView:tableView];
    headerView.delegate=self;

    
    // 把数据扔给自定义View
    if (section==0) {
        headerView.nameButton.tag=3333;
        if (self.opened1) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }
        
        headerView.cleicedName=self.type;
        
        if (self.type==nil) {
            headerView.liftName=@"选择记分方式";
        }else
        {
            headerView.liftName=@"记分方式";
        }

    }else if (section==1)
    {
         ZCCoursesModel *teeModel=self.toTheGameModel.venue.courses[0];
        NSString *holeStr=[NSString stringWithFormat:@"%d",teeModel.holes_count];        headerView.liftName=holeStr;
        
        headerView.cleicedName=teeModel.name;

    
    }else if (section==2) {
        
        
        
        if (self.opened2) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }
        
        
        headerView.nameButton.tag=4444;
       // headerView.tag=1004;
        headerView.cleicedName=self.firstTeeBox;
        if (self.firstTeeBox==nil) {
            headerView.liftName=@"请选择发球台";
        }else
        {
            headerView.liftName=@"发球台";
        }
        
        
        headerView.cleicedName=self.firstTeeBox;
       // return  headerView;
    }else if (section==3)
    {
    
        ZCCoursesModel *teeModel=self.toTheGameModel.venue.courses[1];
        NSString *holeStr=[NSString stringWithFormat:@"%d",teeModel.holes_count];
        headerView.liftName=holeStr;
        
        headerView.cleicedName=teeModel.name;
        
        
        
    }else if (section==4)
    {
        
        headerView.nameButton.tag=5555;
       // headerView.tag=1003;
        
        if (self.opened3) {
            headerView.imageName=@"icon_shang";
        }else
        {
            headerView.imageName=@"icon_xia";
        }
        
        
        
        if (self.lastTeeBox==nil) {
            headerView.liftName=@"请选择发球台";
        }else
        {
            headerView.liftName=@"发球台";
        }
        
        
        headerView.cleicedName=self.lastTeeBox;

        
       // return  headerView;
    
    }
    return  headerView;
    
}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0) {
        self.opened1=YES;
        if (indexPath.row==0) {
            self.type=@"简单";
        }else
        {
            self.type=@"专业";
        }
    }
    if (indexPath.section==2)
    {
        //self.opened1=YES;
        self.opened2=YES;
        self.opened3=NO;
        self.lastTeeBox=nil;
        ZCCoursesModel *Courses=self.toTheGameModel.venue.courses[0];
        NSString *tee_boxe=Courses.tee_boxes[indexPath.row];

//       ZCChildStadium *ChildStadium= self.athleticEventsModel.courses[0];
//        NSString *tee_boxe= ChildStadium.tee_boxes[indexPath.row];
        self.firstTeeBox= tee_boxe;
        
        if (Courses.holes_count==18) {
            ZCLog(@"开始回合");
        }else
        {
        self.count=5;
        
        }
    }else if (indexPath.section==4)
    {
        ZCCoursesModel *Courses=self.toTheGameModel.venue.courses[1];
        NSString *tee_boxe=Courses.tee_boxes[indexPath.row];

//        ZCChildStadium *ChildStadium= self.athleticEventsModel.courses[1];
//        NSString *tee_boxe= ChildStadium.tee_boxes[indexPath.row];
        self.lastTeeBox= tee_boxe;

        self.opened3=YES;
        
    }
    
    
     [self.tableView reloadData];
    [self canStart];
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

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
