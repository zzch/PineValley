//
//  ZCChooseView.m
//  我爱高尔夫
//
//  Created by hh on 15/4/2.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCChooseView.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "ZCSelectTheDisplay.h"
@interface ZCChooseView()<UIPickerViewDataSource,UIPickerViewDelegate>
/**
 取消按钮的view
 */
@property(nonatomic,weak)UIView *cancelView;
/**
 取消按钮
 */
@property(nonatomic,weak)UIButton *cancelButton;
/**
 确定按钮
 */
@property(nonatomic,weak)UIButton *determineButton;
/**
 nameView view
 */
@property(nonatomic,weak)UIView *nameView;
/**
 pick view
 */
@property(nonatomic,weak)UIView *pickView;

/**
 nameView 中得label
 */
@property(nonatomic,weak)UILabel *nameLabel1;
/**
 nameView 中得label
 */
@property(nonatomic,weak)UILabel *nameLabel2;
/**
 nameView 中得label
 */
@property(nonatomic,weak)UILabel *nameLabel3;
/**
 nameView 中得label
 */
@property(nonatomic,weak)UILabel *nameLabel4;

@property(nonatomic,weak)UIPickerView *pickerView;

@property (strong,nonatomic) NSArray *pickerArray;



/**
 码数
 */
@property(nonatomic,copy)NSString *distance_from_hole;
/**
 状态
 */
@property(nonatomic,copy)NSString *point_of_fall;
/**
 罚杆
 */
@property(nonatomic,copy)NSString *penalties;
/**
 球杆
 */
@property(nonatomic,copy)NSString *club;






@property(nonatomic,assign) int index;


@end
@implementation ZCChooseView


-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        
        
        
        //创建取消 确定按钮的View
        [self initCancelView];
        
        //创建名称View
        [self initNameView];
        
        //创建pickerview
        [self initPickerView];
       
        
        
    }
    return self;

}




-(NSArray *)pickerArray
{
    if (_pickerArray==nil) {
        
        _pickerArray=[NSArray array];
        NSMutableArray *pickArray1=[NSMutableArray array];
        for (int i = 0; i < 81; i ++) {
            [pickArray1 addObject:[NSString stringWithFormat:@"%d",i*5]];
        }
        
        
        NSArray *pickArray2=[NSArray array];
        pickArray2=@[@"果岭",@"球道外左侧",@"球道",@"球道外右侧",@"沙坑",@"不可打"];
        
        NSArray *pickArray3=[NSArray array];
        pickArray3=@[@"1",@"2",@"3"];
        
        
        NSArray *pickArray4=[NSArray array];
        pickArray4=@[@"1w",@"3w"];
        
        _pickerArray=@[pickArray1,pickArray2,pickArray3,pickArray4];
        
        
        
    }

    return _pickerArray;
}

//创建pickerview
-(void)initPickerView
{
    //创建pickview
    
//    UIPickerView *pickerView=[[UIPickerView alloc] initWithFrame:CGRectZero];
//    pickerView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
//    pickerView.delegate=self;
//    pickerView.dataSource = self;
//    //pickView.tintColor=[UIColor whiteColor];
//    CGFloat pickViewW=SCREEN_WIDTH;
//    CGFloat pickViewH=100;
//    CGFloat pickViewX=0;
//    CGFloat pickViewY=100;
//    pickerView.frame = CGRectMake(pickViewX, pickViewY, pickViewW, pickViewH);
//    pickerView.showsSelectionIndicator = YES;
//    self.pickerView=pickerView;
//    [self addSubview:pickerView];
    
    UIView *pickView=[[UIView alloc] init];
    pickView.backgroundColor=[UIColor brownColor];
    self.pickView=pickView;
    [self addSubview:pickView];
    
    UIPickerView *pickerView=[[UIPickerView alloc] init];
    pickerView.delegate=self;
    pickerView.dataSource=self;
    [pickView addSubview:pickerView];
    
    
    
    
//    [self pickerView:nil didSelectRow:distance inComponent:0];
//    [self.pickView selectRow:distance inComponent:0 animated:YES];
}



//创建名称View
-(void)initNameView
{
    //nameView
    UIView *nameView=[[UIView alloc] init];
    nameView.backgroundColor=[UIColor yellowColor];
    [self addSubview:nameView];
    self.nameView=nameView;
    
    //显示UILabel
    UILabel *nameLabel1=[[UILabel alloc] init];
    
    nameLabel1.text=@"距离球洞/码";
    self.nameLabel1=nameLabel1;
    [nameView addSubview:nameLabel1];
    
    UILabel *nameLabel2=[[UILabel alloc] init];
    
    nameLabel2.text=@"球的状态";
    self.nameLabel2=nameLabel2;
    [nameView addSubview:nameLabel2];
    
    
    UILabel *nameLabel3=[[UILabel alloc] init];
    
    nameLabel3.text=@"罚杆";
    self.nameLabel3=nameLabel3;
    [nameView addSubview:nameLabel3];

    
    UILabel *nameLabel4=[[UILabel alloc] init];
   
    nameLabel4.text=@"球杆";
    self.nameLabel4=nameLabel4;
    [nameView addSubview:nameLabel4];


    
    
    
}


//创建取消 确定按钮的View
-(void)initCancelView
{   //VIew
    UIView *cancelView=[[UIView alloc] init];
    cancelView.backgroundColor=[UIColor blueColor];
    self.cancelView=cancelView;
    [self addSubview:cancelView];
    
    //取消按钮
    UIButton *cancelButton=[[UIButton alloc] init];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.cancelButton=cancelButton;
    [self.cancelView addSubview:cancelButton];
    
    // 确定按钮
    
    UIButton *determineButton=[[UIButton alloc] init];
    [determineButton setTitle:@"确定" forState:UIControlStateNormal];
    [determineButton addTarget:self action:@selector(clickdetermineButton) forControlEvents:UIControlEventTouchUpInside];
    self.determineButton=determineButton;
    [self.cancelView addSubview:determineButton];
    
}


//点击确定
-(void)clickdetermineButton
{
    ZCLog(@"%@",self.isYes);
    
    //数据模型
    ZCSelectTheDisplay *selectTheDisplay=[[ZCSelectTheDisplay alloc] init];
    selectTheDisplay.distance_from_hole=self.distance_from_hole;
    selectTheDisplay.point_of_fall=self.point_of_fall;
    selectTheDisplay.penalties=self.penalties;
    selectTheDisplay.club=self.club;
    
    
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
   
    // ZCLog(@"%@",[self.eventArray[indexPath.row] uuid]);
    params[@"token"]=account.token;
    params[@"distance_from_hole"]=self.distance_from_hole;
    params[@"penalties"]=self.penalties;
    
    //params[@"point_of_fall"]=self.state;
    params[@"point_of_fall"]=@"green";
    params[@"club"]=self.club;

    
    if ([self.isYes isEqual:@"no"]) {
       params[@"scorecard_uuid"]=self.scorecard_uuid;
        NSString *url=[NSString stringWithFormat:@"%@%@",API,@"strokes.json"];
        
        [mgr POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            ZCLog(@"%@",responseObject);
           
            
            
            //保存创建这条记录的uuid
            NSDictionary *tempArray=responseObject[@"stroke"];
            NSString *uuid=tempArray[@"uuid"];
            selectTheDisplay.uuid=uuid;
            
            //成绩的值
            NSDictionary *scoreDict=responseObject[@"scorecard"];
            NSString *score=scoreDict[@"score"];
            NSString *penalties=scoreDict[@"penalties"];
            NSString *putts=scoreDict[@"putts"];

            
            
            //通知代理
            if ([self.delegate respondsToSelector:@selector( ZCChooseView:clickdetermineButtonAndSelectTheDisplay:andScore:andPenalties:andPutts:)])
            {
                
                
                
                [self.delegate ZCChooseView:self clickdetermineButtonAndSelectTheDisplay:selectTheDisplay andScore:score andPenalties:penalties andPutts:putts];

                [self removeFromSuperview];
            }

            
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         }];
        

        
    }else if ([self.isYes isEqual:@"yes"])
    {
        
         params[@"uuid"]=self.uuid;
        selectTheDisplay.uuid=self.uuid;
        NSString *url=[NSString stringWithFormat:@"%@%@",API,@"strokes.json"];
        
       [mgr PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
           
           ZCLog(@"%@",responseObject);
           NSString *score=responseObject[@"score"];
           NSString *penalties=responseObject[@"penalties"];
           NSString *putts=responseObject[@"putts"];

           
           
           //通知代理
           if ([self.delegate respondsToSelector:@selector(ZCChooseView:clickdetermineButtonAndModifyDataWithSelectTheDisplay:andScore:andPenalties:andPutts:)])
           {
               [self.delegate ZCChooseView:self clickdetermineButtonAndModifyDataWithSelectTheDisplay:selectTheDisplay andScore:score andPenalties:penalties andPutts:putts];
               
               [self removeFromSuperview];
           }

           
           
           
       } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
           ZCLog(@"%@",error);
       }];
    
        
        
    }
    
    
    
    
    
    
    
    
        
    
}


#pragma mark - 数据源方法


/**
 *  一共有多少列
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{ZCLog(@"%lu",self.pickerArray.count);
    return self.pickerArray.count;
    
    
}

/**
 *  第component列显示多少行
 */
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    NSArray *subfoods = self.pickerArray[component];
    
    return subfoods.count;
}


/**
 *  第component列的第row行显示什么文字
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerArray[component][row];
}


/**
 *  选中了第component列的第row行
 */
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (component == 0) { //
        self.distance_from_hole = self.pickerArray[component][row];
    } else if (component == 1) { //
        self.point_of_fall = self.pickerArray[component][row];
    }else if (component==2)
    {
        self.penalties=self.pickerArray[component][row];
    }else if (component==3)
    {
        self.club=self.pickerArray[component][row];
    }
    
   
}


- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component
{
//    if(component == 1)
//        return 60;
    return 70;
}




-(void)layoutSubviews
{
    [super layoutSubviews];
    self.cancelView.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    self.cancelButton.frame=CGRectMake(10, 0, 60, 40);
    self.determineButton.frame=CGRectMake(SCREEN_WIDTH-80, 0, 60, 40);
    self.nameView.frame=CGRectMake(0, 40, SCREEN_WIDTH, 40);

    self.nameLabel1.frame=CGRectMake(0, 0, 80, 40);
    self.nameLabel2.frame=CGRectMake(80, 0, 80, 40);
    self.nameLabel3.frame=CGRectMake(160, 0, 80, 40);
    self.nameLabel4.frame=CGRectMake(240, 0, 80, 40);
    
    
    
    self.pickView.frame=CGRectMake(0, 80, SCREEN_WIDTH, self.frame.size.height-80);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
