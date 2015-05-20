//
//  ZCViewTheResultsViewController.m
//  iGolf
//
//  Created by hh on 15/5/18.
//  Copyright (c) 2015年 Beijing iSports Co., Ltd. All rights reserved.
//

#import "ZCViewTheResultsViewController.h"
#import "ZCResultsView.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCViewTheResultsModel.h"
#import "UIImageView+WebCache.h"
@interface ZCViewTheResultsViewController ()
@property(nonatomic,strong)ZCViewTheResultsModel *viewTheResultsModel;
@end

@implementation ZCViewTheResultsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initonlineData];
    
    
    [self  addControls];
}





//网络加载
-(void)initonlineData
{
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    
    
    //封装请求参数
    NSString *doc=[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory , NSUserDomainMask, YES) lastObject];
    NSString *file=[doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"uuid"]=self.uuid;

    params[@"token"]=account.token;


    NSString *url=[NSString stringWithFormat:@"%@%@",API,@"players/show.json"];
    
    ZCLog(@"%@?token=%@&uuid=%@",url,account.token,self.uuid);
    
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
       // ZCLog(@"%@",responseObject);
        
        ZCViewTheResultsModel *viewTheResultsModel=[ZCViewTheResultsModel viewTheResultsModelWithDict:responseObject];
        self.viewTheResultsModel=viewTheResultsModel;
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];

}



//添加控件
-(void)addControls
{

    
    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 80);
    [self.view addSubview:topView];
    [self addTopViewControls:topView];
    
    
    
   // ZCResultsView *resultsView=[[ZCResultsView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 80)];
    
    ZCResultsView *resultsView=[ZCResultsView initWithResultsViewWithFrame:CGRectMake(0, 90, SCREEN_WIDTH, 400) andModel:self.viewTheResultsModel.scorecards];
    resultsView.backgroundColor=[UIColor redColor];
    [self.view addSubview:resultsView];
    
    
    
    
    

}
//添加顶部View
-(void)addTopViewControls:(UIView *)view
{

    UIImageView *personImageView=[[UIImageView alloc] init];
    personImageView.layer.masksToBounds = YES;
    personImageView.layer.cornerRadius = 35;
    
    /**
     *  头像位置
     */
    CGFloat  personImageViewX=10;
    CGFloat  personImageViewY=10;
    CGFloat  personImageViewW=70;
    CGFloat  personImageViewH=70;
    personImageView.frame=CGRectMake(personImageViewX, personImageViewY, personImageViewW, personImageViewH);
    personImageView.backgroundColor=[UIColor redColor];
     [personImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.viewTheResultsModel.user.portrait]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    [view addSubview:personImageView];
   
    
    //名字
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.textColor=ZCColor(240, 208, 122);
    /**
     *  名字位置
     */
    CGFloat  nameLabelX=personImageViewX+personImageViewW+10;
    CGFloat  nameLabelY=personImageViewY;
    CGFloat  nameLabelW=SCREEN_WIDTH-nameLabelX;
    CGFloat  nameLabelH=25;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    [view addSubview:nameLabel];
    
    
    //排名
    UILabel *rankingLabel=[[UILabel alloc] init];
    rankingLabel.textColor=ZCColor(240, 208, 122);
    CGFloat  rankingLabelX=nameLabelX;
    CGFloat  rankingLabelY=nameLabelY+nameLabelH+10;
    CGFloat  rankingLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  rankingLabelH=20;
    rankingLabel.frame=CGRectMake(rankingLabelX, rankingLabelY, rankingLabelW, rankingLabelH);
    [view addSubview:rankingLabel];
    
    
    //成绩
    UILabel *resultsLabel=[[UILabel alloc] init];
    resultsLabel.textColor=ZCColor(240, 208, 122);
    CGFloat  resultsLabelX=nameLabelX;
    CGFloat  resultsLabelY=rankingLabelY+rankingLabelH+10;
    CGFloat  resultsLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  resultsLabelH=20;
    resultsLabel.frame=CGRectMake(resultsLabelX, resultsLabelY, resultsLabelW, resultsLabelH);
    [view addSubview:resultsLabel];
    
    
    //进度
    UILabel *progressLabel=[[UILabel alloc] init];
    progressLabel.textColor=ZCColor(240, 208, 122);
    CGFloat  progressLabelX=rankingLabelX+rankingLabelW;
    CGFloat  progressLabelY=rankingLabelY;
    CGFloat  progressLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  progressLabelH=20;
    progressLabel.frame=CGRectMake(progressLabelX, progressLabelY, progressLabelW, progressLabelH);
    [view addSubview:progressLabel];
   
    
    
    //距标准杆
    UILabel *parLabel=[[UILabel alloc] init];
    parLabel.textColor=ZCColor(240, 208, 122);
    CGFloat  parLabelX=progressLabelX;
    CGFloat  parLabelY=resultsLabelY;
    CGFloat  parLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  parLabelH=20;
    parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
    [view addSubview:parLabel];
    
    
    

    
    

}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
