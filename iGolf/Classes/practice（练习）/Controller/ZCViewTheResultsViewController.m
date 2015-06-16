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
    
    
    self.view.backgroundColor=ZCColor(237, 237, 237);
    [self initonlineData];
    
    
    
}





//网络加载
-(void)initonlineData
{
    
    [MBProgressHUD showMessage:@"请稍后"];
    
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
        ZCLog(@"%@",responseObject);
        
        if (responseObject[@"error_code"] ) {
            
            [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%@",responseObject[@"error_code"]]];
            
        }else
        {
        
        
        ZCViewTheResultsModel *viewTheResultsModel=[ZCViewTheResultsModel viewTheResultsModelWithDict:responseObject];
        self.viewTheResultsModel=viewTheResultsModel;
        
        
        
        [self  addControls];
            
        }
        
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
       
        [MBProgressHUD hideHUD];
        
        [ZCprompt initWithController:self andErrorCode:[NSString stringWithFormat:@"%ld",(long)[operation.response statusCode]]];
        

        
    }];

}



//添加控件
-(void)addControls
{

    
    UIView *topView=[[UIView alloc] init];
    topView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 94);
    topView.backgroundColor=ZCColor(60, 57, 78);
    [self.view addSubview:topView];
    [self addTopViewControls:topView];
    
    
    
   // ZCResultsView *resultsView=[[ZCResultsView alloc] initWithFrame:CGRectMake(0, 80, SCREEN_WIDTH, 80)];
    
    ZCResultsView *resultsView=[ZCResultsView initWithResultsViewWithFrame:CGRectMake(0, 105, SCREEN_WIDTH, 400) andModel:self.viewTheResultsModel.scorecards andTime:1];
    
    [self.view addSubview:resultsView];
    
    
    
    
    

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
   
    CGFloat  personImageViewW=70;
    CGFloat  personImageViewH=70;
     CGFloat  personImageViewY=10;
    personImageView.frame=CGRectMake(personImageViewX, personImageViewY, personImageViewW, personImageViewH);
    //personImageView.backgroundColor=[UIColor redColor];
     [personImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",self.viewTheResultsModel.user.portrait]] placeholderImage:[UIImage imageNamed:@"touxiang"]];
    [view addSubview:personImageView];
   
    
    //名字
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.textColor=[UIColor whiteColor];
    nameLabel.font=[UIFont systemFontOfSize:15];
    /**
     *  名字位置
     */
    CGFloat  nameLabelX=personImageViewX+personImageViewW+7;
    CGFloat  nameLabelY=personImageViewY;
    CGFloat  nameLabelW=SCREEN_WIDTH-nameLabelX;
    CGFloat  nameLabelH=20;
    nameLabel.frame=CGRectMake(nameLabelX, nameLabelY, nameLabelW, nameLabelH);
    nameLabel.font=[UIFont systemFontOfSize:13];

    nameLabel.text=[NSString stringWithFormat:@"%@",self.viewTheResultsModel.user.nickname];
    [view addSubview:nameLabel];
    
    
    //排名
    UILabel *rankingLabel=[[UILabel alloc] init];
    rankingLabel.textColor=[UIColor whiteColor];
    CGFloat  rankingLabelX=nameLabelX;
    CGFloat  rankingLabelY=nameLabelY+nameLabelH+7;
    CGFloat  rankingLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  rankingLabelH=20;
     rankingLabel.font=[UIFont systemFontOfSize:13];
    rankingLabel.frame=CGRectMake(rankingLabelX, rankingLabelY, rankingLabelW, rankingLabelH);
    
    if ([self _valueOrNil:self.viewTheResultsModel.position]==nil) {
        rankingLabel.text=[NSString stringWithFormat:@"排名: -"];
    }else
    {
        rankingLabel.text=[NSString stringWithFormat:@"排名: %@",self.viewTheResultsModel.position];
    }

    
    [view addSubview:rankingLabel];
    
    
    //成绩
    UILabel *resultsLabel=[[UILabel alloc] init];
    resultsLabel.textColor=[UIColor whiteColor];
    CGFloat  resultsLabelX=nameLabelX;
    CGFloat  resultsLabelY=rankingLabelY+rankingLabelH+7;
    CGFloat  resultsLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  resultsLabelH=20;
    
    resultsLabel.frame=CGRectMake(resultsLabelX, resultsLabelY, resultsLabelW, resultsLabelH);
     resultsLabel.font=[UIFont systemFontOfSize:13];
    
    if ([self _valueOrNil:self.viewTheResultsModel.strokes]==nil) {
        resultsLabel.text=[NSString stringWithFormat:@"成绩: -"];
    }else{
        resultsLabel.text=[NSString stringWithFormat:@"成绩: %@杆",self.viewTheResultsModel.strokes];
    }

    
    [view addSubview:resultsLabel];
    
    
    //进度
    UILabel *progressLabel=[[UILabel alloc] init];
    progressLabel.textColor=[UIColor whiteColor];
    CGFloat  progressLabelX=rankingLabelX+rankingLabelW;
    CGFloat  progressLabelY=rankingLabelY;
    CGFloat  progressLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  progressLabelH=20;
    progressLabel.frame=CGRectMake(progressLabelX, progressLabelY, progressLabelW, progressLabelH);
    if ([self _valueOrNil:self.viewTheResultsModel.recorded_scorecards_count]==nil) {
        progressLabel.text=[NSString stringWithFormat:@"进度: -/18"];
    }else{
        progressLabel.text=[NSString stringWithFormat:@"进度: %@/18",self.viewTheResultsModel.recorded_scorecards_count];
    }

    progressLabel.font=[UIFont systemFontOfSize:13];
    [view addSubview:progressLabel];
   
    
    
    //距标准杆
    UILabel *parLabel=[[UILabel alloc] init];
    parLabel.textColor=[UIColor whiteColor];
    CGFloat  parLabelX=progressLabelX;
    CGFloat  parLabelY=resultsLabelY;
    CGFloat  parLabelW=(SCREEN_WIDTH-nameLabelX)/2;
    CGFloat  parLabelH=20;
    parLabel.frame=CGRectMake(parLabelX, parLabelY, parLabelW, parLabelH);
    if ([self _valueOrNil:self.viewTheResultsModel.total]==nil) {
        parLabel.text=[NSString stringWithFormat:@"距标准杆: -"];
    }else{
        parLabel.text=[NSString stringWithFormat:@"距标准杆: %@",self.viewTheResultsModel.total];
    }
 parLabel.font=[UIFont systemFontOfSize:13];
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
