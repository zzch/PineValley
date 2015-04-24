//
//  ZCCreateAGameTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/4/23.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCCreateAGameTableViewController.h"
#import "ZCNameTableViewCell.h"
#import "ZCPasswordTableViewCell.h"
#import "ZCModelTableViewCell.h"
#import "ZCNoteTableViewCell.h"
#import "ZCTextViewController.h"
#import "ZCAccount.h"
#import "AFNetworking.h"
#import "ZCStadiumInformation.h"
#import "ZCSettingHeadView.h"
#import "ZCCompetitiveModel.h"
#import "ZCCompetitiveScorecardTableViewController.h"
@interface ZCCreateAGameTableViewController ()<UITableViewDataSource,UITableViewDelegate,ZCTextViewDelegate,ZCSettingHeadViewDelegate>

//cell的高度 备注cell的高度
@property(nonatomic,assign) CGFloat textViewHigit;
@property(nonatomic,copy)NSString *textStr;
//数据模型
@property(nonatomic,strong) ZCStadiumInformation *stadiumInformation;




@property(nonatomic,assign) int count;


//保存用户选择球场的uuid
@property(nonatomic,copy) NSString *uuid;
//保存用户选择球场的T台
@property(nonatomic,copy) NSString *tee_boxe;
//保存选中一个子场的数据
@property(nonatomic, strong) ZCChildStadium *childStadium;
//保存在选择9洞后 列出后9洞的子场
@property(nonatomic,strong) NSMutableArray *childStadiumMutableArray;
//保存用户选择后9洞的球场的uuid
@property(nonatomic,copy) NSString *lastUuid;
//保存选中后9洞子场的数据
@property(nonatomic, strong) ZCChildStadium *lastChildStadium;
//保存用户选择后9洞球场的T台
@property(nonatomic,copy) NSString *lastTee_boxe;
@property(nonatomic,assign) NSInteger index;
// 标记一下是否展开，YES：展开，NO：收起
@property (nonatomic, assign, getter = isOpened1) BOOL opened1;
@property (nonatomic, assign, getter = isOpened2) BOOL opened2;
@property (nonatomic, assign, getter = isOpened3) BOOL opened3;
@property (nonatomic, assign, getter = isOpened4) BOOL opened4;

@property(nonatomic, strong) ZCSettingHeadView *settingHeadView;
//保存选中的子场名字
@property(nonatomic,copy) NSString *firstChildName;
//保存选中的子场名字
@property(nonatomic,copy) NSString *lastChildName;


@property(nonatomic,weak)UIButton *startButton;
//名字
@property(nonatomic,weak)UITextField *nameText;
//密码
@property(nonatomic,weak)UITextField *passwordText;
@end

@implementation ZCCreateAGameTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    
    self.tableView.dataSource=self;
    self.tableView.delegate=self;
    
//    self.tableView.sectionHeaderHeight = 60;
    //网络加载
    [self onlineData];
    
    [self addControls];
    
    self.tableView.contentInset = UIEdgeInsetsMake(0, 0, 55, 0);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    
//    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
//    ZCNameTableViewCell* cell = (ZCNameTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
//    
//    self.nameText=cell.nameTextView;
//    NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:0 inSection:1];
//    ZCPasswordTableViewCell* cell2 = (ZCPasswordTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath2];
//    self.passwordText= cell2.passwordTextView;
    
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
    [startButton setTitle:@"开始回合" forState:UIControlStateNormal];
    startButton.backgroundColor=ZCColor(105, 178, 138);
    [startButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [startButton addTarget:self action:@selector(clickDidStartButton) forControlEvents:UIControlEventTouchUpInside];
    UIWindow *wd = [[UIApplication sharedApplication].delegate window];
    [wd addSubview:startButton];
    // startButton.userInteractionEnabled=NO;
    startButton.enabled=NO;
    self.startButton=startButton;
    


}



-(void)clickDidStartButton
{
    ZCLog(@"--------可以点击Button");
    
   // ZCScorecardTableViewController *scorecardTableView=[[ZCScorecardTableViewController alloc] init];
    
    ZCCompetitiveScorecardTableViewController *competitiveScorecardTableViewController=[[ZCCompetitiveScorecardTableViewController alloc] init];
    
    
    
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (self.lastUuid==nil&&self.lastTee_boxe==nil) {
        params[@"course_uuids"]=self.uuid;
       
        params[@"tee_boxes"]=self.tee_boxe;
    }else{
        params[@"course_uuids"]= [NSString stringWithFormat:@"%@,%@" , self.uuid,self.lastUuid ];
        params[@"tee_boxes"]=[NSString stringWithFormat:@"%@,%@" , self.tee_boxe,self.lastTee_boxe ];
    }
    
    params[@"name"]=self.nameText.text;
    params[@"password"]=self.passwordText.text;
    params[@"rule"]=@"stroke_play";
    params[@"remark"]=[NSString stringWithFormat:@"%@",self.textStr];
       params[@"token"]=account.token;
    ////v1/matches/tournament.json
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"matches/tournament.json"];
    [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
         ZCCompetitiveModel *competitiveModel= [ZCCompetitiveModel competitiveModelWithDict:responseObject];
        // ZCLog(@"-------%@",totalScorecards.type);
        // scorecardTableView.totalScorecards=totalScorecards;
        //单利模式  为统计页面保存uuid
        competitiveScorecardTableViewController.competitiveModel=competitiveModel;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        //ZCLog(@"%@",error);
    }];
    
    
    
    [self.navigationController pushViewController:competitiveScorecardTableViewController animated:YES];
    
}

//-(UITextField *)nameText
//{
//    if (_nameText==nil) {
//        _nameText=[[UITextField alloc] init];
//    }
//
//    return _nameText;
//}
//
//-(UITextField *)passwordText
//{
//    if (_passwordText==nil) {
//        _passwordText=[[UITextField alloc] init];
//    }
//    return _passwordText;
//}

////注册观察者
//-(void)registeredObservers
//{
//    [self.nameText addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
//    [self.passwordText addObserver: self   forKeyPath: @"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context: nil];
//    
//    
//}
////
//
//
////观察者调用方法
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
//{
//    // ZCLog(@"%@",change[@"new"]);
//    [self canStart];
////    if (self.nameText.text.length>0 && self.passwordText.text.length==4) {
////        canStart
////        
////    }
//    
//}
//
//
//-(void)dealloc
//{
//    // 移除观察者
//    [self.nameText removeObserver:self forKeyPath:@"text"];
//    [self.passwordText removeObserver:self forKeyPath:@"text"];
//    
//}
//



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
    
   
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:0];
    ZCNameTableViewCell* cell = (ZCNameTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath];
    
    self.nameText=cell.nameTextView;
    NSIndexPath *indexPath2=[NSIndexPath indexPathForRow:0 inSection:1];
    ZCPasswordTableViewCell* cell2 = (ZCPasswordTableViewCell*)[self.tableView cellForRowAtIndexPath:indexPath2];
    self.passwordText= cell2.passwordTextView;
    
    

    self.startButton.enabled=NO;
    self.startButton.backgroundColor=ZCColor(105, 178, 138);
    //ZCLog(@"进入该方法了");
    
    ZCLog(@"%@",cell.nameTextView.text);
        
    if (self.nameText.text.length>0 && self.passwordText.text.length==4){
    
    
    
    if (self.childStadium.holes_count==18) {
        if (self.tee_boxe) {
            self.startButton.enabled=YES;
            self.startButton.backgroundColor=ZCColor(37, 176, 101);
            
            
        }
    }else if (self.childStadium.holes_count==9)
    {
        if (self.tee_boxe) {
            if (self.lastChildName) {
                if (self.lastTee_boxe) {
                    
                    self.startButton.enabled=YES;
                    self.startButton.backgroundColor=ZCColor(37, 176, 101);
                    
                }
            }
        }
        
    }
        
    
    }
}


//网络加载
-(void)onlineData
{

    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    params[@"uuid"]=self.uuidStr;
    params[@"token"]=account.token;
    
    //发送请求/v1/courses/show.json
    
    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/show.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        ZCLog(@"%@",responseObject);
        
        
        ZCStadiumInformation  *stadiumInformation=[ZCStadiumInformation stadiumInformationWithDict:responseObject];
        
        self.stadiumInformation=stadiumInformation;
//        //隐藏圈圈
//        [MBProgressHUD hideHUD];
        // 刷新表格
        [self.tableView reloadData];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"请求失败%@",error);
        //隐藏圈圈
//        [MBProgressHUD hideHUD];
    }];
    
    

    
    
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.count) {
        return self.count;
    }else if(self.stadiumInformation.courses.count==1)
    {
        //默认调用点击方法
        
       NSIndexPath *indexPath=[NSIndexPath indexPathForRow:0 inSection:4];
       [self tableView:tableView didSelectRowAtIndexPath:indexPath];
        
        return 6;
    }else
    {
        return 5;
    }

    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    
    if (section==0) {
        return 1;
    }else if (section==1)
    {
        return 1;
    }else if (section==2)
    {
        return 1;
    }else if (section==3)
    {
        return 1;
    }

    
    
    
   else if (section==4) {
        
        return (self.opened1? 0:self.stadiumInformation.courses.count) ;
    }else if(section==5){
        
       // NSLog(@"%zd",self.childStadium.tee_boxes.count);
        return (self.opened2? 0: self.childStadium.tee_boxes.count );
    }else if (section==6)
    {
        return  (self.opened3? 0: self.childStadiumMutableArray.count);
    }else //if(section==3)
    {
        return( self.opened4? 0:self.lastChildStadium.tee_boxes.count );
    }

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    if (indexPath.section==0) {
        ZCNameTableViewCell *cell=[ZCNameTableViewCell cellWithTable:tableView];
        return cell;
    }else if (indexPath.section==1)
    {
        ZCPasswordTableViewCell *cell=[ZCPasswordTableViewCell cellWithTable:tableView];
        return cell;
    }else if (indexPath.section==2)
    {
        ZCModelTableViewCell *cell=[ZCModelTableViewCell cellWithTable:tableView];
        return cell;
    }else if (indexPath.section==3)
    {
        ZCNoteTableViewCell *cell=[ZCNoteTableViewCell cellWithTable:tableView];
        cell.textStr=self.textStr;
        return cell;
    
    }else if (indexPath.section==4)
    {
    
        NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        }
        //
        ZCChildStadium *childStadium=self.stadiumInformation.courses[indexPath.row];
        cell.textLabel.text=childStadium.name;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d洞",childStadium.holes_count];
        
            return cell;
        
    }else if (indexPath.section==5)
    {
        NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        }
        
        NSString *tee=self.childStadium.tee_boxes[indexPath.row];
        
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色T台";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色T台";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色T台";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色T台";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色T台";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }

        

        return cell;
    }else if (indexPath.section==6)
    {
        NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        }
        ///
        
        ZCChildStadium *childStadium=self.childStadiumMutableArray[indexPath.row];
        cell.textLabel.text=childStadium.name;
        cell.detailTextLabel.text=[NSString stringWithFormat:@"%d洞",childStadium.holes_count];

        return cell;
    }
    
    
    
    else
    {
    
        NSString *myCell = [NSString stringWithFormat:@"Cell%ld%ld", [indexPath section], [indexPath row]];
        UITableViewCell  *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:myCell];
        }
        ///
        
        
        NSString *tee=self.lastChildStadium.tee_boxes[indexPath.row];
        
        if ([tee isEqual:@"white"]) {
            cell.textLabel.text=@"白色T台";
            cell.imageView.image=[UIImage imageNamed:@"bai"];
        }else if ([tee isEqual:@"red"])
        {
            cell.textLabel.text=@"红色T台";
            cell.imageView.image=[UIImage imageNamed:@"hong"];
        }else if ([tee isEqual:@"blue"])
        {
            cell.textLabel.text=@"蓝色T台";
            cell.imageView.image=[UIImage imageNamed:@"lan"];
            
        }else if ([tee isEqual:@"black"])
        {
            cell.textLabel.text=@"黑色T台";
            cell.imageView.image=[UIImage imageNamed:@"hei"];
        }else if ([tee isEqual:@"gold"])
        {
            cell.textLabel.text=@"金色T台";
            cell.imageView.image=[UIImage imageNamed:@"huang"];
            
        }
        

        
        
        return cell;
    
    
    }
    
    
    
}


// 设置每一组的头View

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //创建一个View
    ZCSettingHeadView *headerView=[ZCSettingHeadView headerViewWithTableView:tableView];
    headerView.delegate=self;
    // 把数据扔给自定义View
    if (section==4) {
        headerView.cleicedName=self.firstChildName;
        
        headerView.nameButton.tag=100;
        headerView.tag=1001;
        
        if (self.opened1) {
            headerView.imageName=@"icon_arrowxia";
        }else
        {
            headerView.imageName=@"icon_arrowshang";
        }
        
        if (self.firstChildName==nil) {
            headerView.liftName=@"请选择球场";
        }else
        {
            if (self.childStadium.holes_count==18) {
                headerView.liftName=@"18洞";
            }else{
                headerView.liftName=@"前九洞";
            }
            
        }
        
        
        
    }else if(section==5)
    {
        headerView.nameButton.tag=101;
        headerView.tag=1002;
        
        if (self.opened2) {
            headerView.imageName=@"icon_arrowxia";
        }else
        {
            headerView.imageName=@"icon_arrowshang";
        }
        
        
        
        if (self.tee_boxe==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }
        
        
        headerView.cleicedName=self.tee_boxe;
        
    }else if (section==6)
        
    {
        
        headerView.nameButton.tag=102;
        headerView.tag=1003;
        
        if (self.opened3) {
            headerView.imageName=@"icon_arrowxia";
        }else
        {
            headerView.imageName=@"icon_arrowshang";
        }
        
        
        
        if (self.lastChildName==nil) {
            headerView.liftName=@"请选择球场";
        }else
        {
            headerView.liftName=@"后九洞";
        }
        
        
        
        headerView.cleicedName=self.lastChildName;
        
    }else{
        if (self.opened4) {
            headerView.imageName=@"icon_arrowxia";
        }else
        {
            headerView.imageName=@"icon_arrowshang";
        }
        
        
        headerView.nameButton.tag=103;
        headerView.tag=1004;
        headerView.cleicedName=self.lastTee_boxe;
        if (self.lastTee_boxe==nil) {
            headerView.liftName=@"请选择T台";
        }else
        {
            headerView.liftName=@"开球T台";
        }
        
    }
    
    
    
    return headerView;
}



#pragma mark - ZCSettingHeaderView的代理方法
-(void)headerViewDidClicked:(ZCSettingHeadView *)headerView didClickButton:(UIButton *)button
{
    
    if (button.tag==100) {
        self.opened1=!self.opened1;
        
        
    }else if (button.tag==101)
    {
        
        self.opened2=!self.opened2;
        
    }else if (button.tag==102)
    {
        self.opened3=!self.opened3;
        
        
    }else
    {
        self.opened4=!self.opened4;
        
    }
    
    
    [self.tableView reloadData];
    
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section==4) {
        return 60;
    }else if (section==5)
    {
        return 60;
    }else if (section==6)
    {
        return 60;
    }else if (section==7)
    {
        return 60;
    }else
    {
        return 0;
    }
}
//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//   
//}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==3) {
        if (self.textViewHigit>50) {
            return self.textViewHigit;
        }else
        {
            return 50;
        }
        
    }else
    {
        return 60;
    }
}



//代理
-(void)textViewDidClickedleftButton:(ZCTextViewController *)textViewController textViewTextStr:(NSString *)textStr
{
    //CGSize size = [textStr sizeWithFont:[UIFont systemFontOfSize:38]];
    CGSize size = [textStr sizeWithFont:[UIFont systemFontOfSize:24] constrainedToSize:CGSizeMake(220, MAXFLOAT) lineBreakMode:NSLineBreakByWordWrapping];
    self.textViewHigit=size.height;
    self.textStr=textStr;
    [self.tableView reloadData];

}




-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
   
    if (indexPath.section==3) {
        
        ZCTextViewController *textViewController=[[ZCTextViewController alloc] init];
        textViewController.ZCdelegate=self;
        [self.navigationController pushViewController:textViewController animated:YES];
    }

    
    
    
    
    else if (indexPath.section==4) {
        //点击第0组拿到的子场
        self.opened1=YES;
        self.opened2=NO;
        self.opened3=NO;
        self.opened4=NO;
        self.tee_boxe=nil;
        self.lastChildName=nil;
        self.lastTee_boxe=nil;
        
        self.count=6;
        ZCChildStadium *childStadium=self.stadiumInformation.courses[indexPath.row];
        self.childStadium = childStadium;
        NSString *uuidStr=childStadium.uuid;
        self.uuid=uuidStr;
        
       
        
        self.firstChildName=childStadium.name;
        ZCLog(@"%@",self.firstChildName);
        
        
        
    }else if (indexPath.section==5)
    {//点击第1组拿到的子场的T台，并判断是否是18洞 是开始回合，不是增加一组在重新选择子场
        
        
        self.opened2=YES;
        self.opened3=NO;
        self.opened4=NO;
        ;
        
        
        self.lastTee_boxe=nil;
        self.lastChildName=nil;
        
        NSString *tee_boxe= self.childStadium.tee_boxes[indexPath.row];
        ZCLog(@"%@",tee_boxe);
        self.tee_boxe=tee_boxe;
        
        
        if (self.childStadium.holes_count==18) {
            ZCLog(@"----开始回合-----");
        }else
        {
            self.count=7;
            
            
            
            NSMutableArray *childStadiums=self.stadiumInformation.courses;
            for (ZCChildStadium *childStadium in childStadiums) {
                if (childStadium.holes_count==18) {
                    
                    [childStadiums removeObject:childStadium];
                }
                ZCLog(@"%lu",childStadiums.count);
                self.childStadiumMutableArray=childStadiums;
                
            }
            
        }
        
    }else if (indexPath.section==6)
    {
        self.opened3=YES;
        self.opened4=NO;
        //        ZCSettingHeadView *headView4= (ZCSettingHeadView *)[self.tableView viewWithTag:1004]   ;
        //        headView4.cleicedName=nil;
        self.lastTee_boxe=nil;
        
        //点击第3组时候保存子场uuid，并且增加一组选择T台
        self.count=8;
        
        //拿到选择后场的子场uuid
        ZCChildStadium *lastChildStadium=self.childStadiumMutableArray[indexPath.row];
        self.lastChildStadium=lastChildStadium;
        self.lastUuid=lastChildStadium.uuid;
        self.lastChildName=lastChildStadium.name;
        
        
    }else if(indexPath.section==7)
    {
        self.opened4=YES;        //保存后9洞的T台
        NSString *houTee_box=self.lastChildStadium.tee_boxes[indexPath.row];
        self.lastTee_boxe=houTee_box;
        ZCLog(@"%@",houTee_box);
        
        ZCLog(@"开始回合------");
        
        
    }
    
    [self canStart];
    
    [self.tableView reloadData];
   
    
    
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
