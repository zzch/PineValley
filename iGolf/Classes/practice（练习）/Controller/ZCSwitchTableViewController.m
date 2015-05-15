//
//  ZCSwitchTableViewController.m
//  我爱高尔夫
//
//  Created by hh on 15/2/26.
//  Copyright (c) 2015年 zhongchuang. All rights reserved.
//

#import "ZCSwitchTableViewController.h"
#import "AFNetworking.h"
#import "ZCAccount.h"
#import "MJExtension.h"
#import "ZCCity.h"
#import "ZCCityStadium.h"
#import "UIBarButtonItem+DC.h"
#import "ZCSettingTVController.h"
#import "ZCEventUuidTool.h"

#import "MBProgressHUD+NJ.h"
@interface ZCSwitchTableViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate,UISearchDisplayDelegate>

//@property (nonatomic, strong) NSArray *citys;
//搜索栏
@property (nonatomic , strong)UISearchDisplayController *mySearchDisplayController;
@property(strong,nonatomic) UISearchBar *mySearchBar;
@property(weak,nonatomic) UITableView *tableView;
//数据源
@property(strong,nonatomic) NSMutableArray *dataArray;
//搜索结果数据
@property(strong,nonatomic) NSMutableArray *resultsData;


@end

@implementation ZCSwitchTableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *customLab = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    customLab.textAlignment=NSTextAlignmentCenter;
    [customLab setTextColor:ZCColor(240, 208, 122)];
    [customLab setText:@"搜索球场"];
    customLab.font = [UIFont boldSystemFontOfSize:20];
    self.navigationItem.titleView = customLab;
    
    //返回
    self.navigationItem.leftBarButtonItem=[UIBarButtonItem barBtnItemWithNormalImageName:@"suoyou_fanhui" hightImageName:@"ffanhui_anxia" action:@selector(liftBthClick:) target:self];
    
    
    self.tableView.delegate=self;
    self.tableView.dataSource=self;
   
    _resultsData = [NSMutableArray array];
    
    self.tableView.backgroundColor=ZCColor(23, 25, 28);
    //让分割线不显示
   // self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //让下面没内容的分割线不显示
    self.tableView.tableFooterView = [[UIView alloc] init];
    //分割线颜色
    [self.tableView   setSeparatorColor:ZCColor(240, 208, 122)];
    [self onlineData];
    //搜索
    [self initMysearchBarAndMysearchDisPlay];
    
    
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

//返回到上个界面
-(void)liftBthClick:(UIButton *)bth
{
    [self.navigationController popViewControllerAnimated:YES];
}



//获取网络请求数据，城市列表 AFHTTPRequestOperationManager  /v1/courses/sectionalized_by_province.json
-(void)onlineData
{
    [MBProgressHUD showMessage:@"加载中..."];
    
    // 1.创建请求管理对象
    AFHTTPRequestOperationManager *mgr=[AFHTTPRequestOperationManager manager];
    // 2.封装请求参数
    NSString *doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString *file = [doc stringByAppendingPathComponent:@"account.data"];
    ZCAccount *account=[NSKeyedUnarchiver unarchiveObjectWithFile:file];
    //ZCLog(@"%@-------",account.token);
    // 说明服务器返回的JSON数据
    // mgr.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    
    params[@"token"]=account.token;
    
     NSString *url=[NSString stringWithFormat:@"%@%@",API,@"venues/sectionalized_by_province.json"];
    [mgr GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        ZCLog(@"%@",responseObject);
        
        // 将字典数组转为模型数组(
        //self.citys = [ZCCity objectArrayWithKeyValuesArray:responseObject];
        // 将字典数据转为模型数据
        self.dataArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject) {
            //创建模型
            ZCCity *city=[ZCCity citysWithDict:dict];
//                        NSLog(@"---city.name---%@",city.name);
//                        NSLog(@"---city.courses.count---%zd",city.courses.count);
            //添加模型
            [self.dataArray addObject:city];
        }
        // ZCLog(@"---self.dataArray---%zd",self.dataArray.count);
        // 刷新表格
        [self.tableView reloadData];
        //移除
        [MBProgressHUD hideHUD];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        ZCLog(@"数据请求失败%@",error);
        //移除
        [MBProgressHUD hideHUD];
    }];
}






#pragma mark - Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    
    
    if(tableView == _mySearchDisplayController.searchResultsTableView)

    {
        return 1;
    }else
    {
    return self.dataArray.count;
    }
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

  
    //searchDisplayController自身有一个searchResultsTableView，所以在执行操作的时候首先要判断是否是搜索结果的tableView，如果是显示的就是搜索结果的数据，如果不是，则显示原始数据。
    if(tableView == _mySearchDisplayController.searchResultsTableView)
    {
        tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20);
        //解决上面空出的20个像素
        self.edgesForExtendedLayout = UIRectEdgeNone;
        
        if (is_IOS_7)
            //分割线的位置不带偏移
            tableView.separatorInset = UIEdgeInsetsZero;
        
        return _resultsData.count;

    }else{

    ZCCity *city= self.dataArray[section];
    return city.venues.count;

    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
    NSString *myCell = @"cell_identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:myCell];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:myCell];
    }
    
    while ([cell.contentView.subviews lastObject] != nil) {
        [(UIView *)[cell.contentView.subviews lastObject] removeFromSuperview];
    }

    
    
    if (tableView == _mySearchDisplayController.searchResultsTableView)
    {
        //ZCCity *city= self.resultsData[indexPath.section];
        ZCCityStadium *stadium = self.resultsData[indexPath.row];
        cell.textLabel.text = stadium.name;
        
        if (![stadium.address isKindOfClass:[NSNull class]]) {
            cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",stadium.address];
        }
        
        
    }
    else
    {
        ZCCity *city= self.dataArray[indexPath.section];
        ZCCityStadium *stadium = city.venues[indexPath.row];
        cell.textLabel.text = stadium.name;
        
        if (![stadium.address isKindOfClass:[NSNull class]]) {
            cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",stadium.address];
        }

        //cell.detailTextLabel.text= [NSString stringWithFormat:@"%@",stadium.address];

    }
    cell.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    //设置背景图片
  //  cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    cell.textLabel.textColor=ZCColor(240, 208, 122);
    cell.detailTextLabel.textColor=ZCColor(240, 208, 110);
    cell.textLabel.font=[UIFont systemFontOfSize:20];
    cell.detailTextLabel.font=[UIFont systemFontOfSize:15];
    //cell.selectedBackgroundView=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"sousuo_bj_anxia"]];
    
    cell.selectedBackgroundView=[[UIView alloc] initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor=ZCColor(15, 14, 14);

    
    return cell;

    
    
    
    

    
  
}

#pragma mark - Table view delegate source
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(tableView == _mySearchDisplayController.searchResultsTableView)
    {
        return 0;
    }else{
        return 50;
    }
    
  
}
//-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForHeaderInSection:(NSInteger)section
//{
//
//    return 60;
//}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *labelView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
    labelView.backgroundColor=ZCColor(19, 21, 23);
    UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 150, 30)];
    ZCCity *city=self.dataArray[section];
    nameLabel.text=city.name;
    nameLabel.textColor=ZCColor(240, 208, 122);
    [labelView addSubview:nameLabel];
    return labelView;

    
//        if(tableView == _mySearchDisplayController.searchResultsTableView)
//        {
//            return nil;
//        }else{
//            UIView *labelView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 50)];
//            UILabel *nameLabel=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 30)];
//            ZCCity *city=self.dataArray[section];
//            nameLabel.text=city.name;
//            nameLabel.textColor=ZCColor(208, 210, 212);
//            return labelView;
//            
//        }
    
}




-(void)initMysearchBarAndMysearchDisPlay
{
    _mySearchBar = [[UISearchBar alloc] init];
    //_mySearchBar.frame=CGRectMake(0, 0, SCREEN_WIDTH, 40);
    _mySearchBar.delegate = self;
    //    //设置选项
        //[_mySearchBar setScopeButtonTitles:[NSArray arrayWithObjects:@"First",@"Last",nil]];
   [_mySearchBar setAutocapitalizationType:UITextAutocapitalizationTypeNone];
    [_mySearchBar sizeToFit];
    _mySearchBar.backgroundColor = ZCColor(23, 25, 28);//[UIColor colorWithPatternImage:[UIImage imageNamed:@"ss_sousuokuang"]];
     _mySearchBar.backgroundImage = [self imageWithColor:[UIColor clearColor] size:_mySearchBar.bounds.size];
   
    //可以改变取消按钮的颜色
    _mySearchBar.tintColor=ZCColor(240, 208, 122);
    // _mySearchBar.barTintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ss_sousuokuang"]];
//
    _mySearchBar.placeholder=@"请输入球场名称";
    //改变输入字体的颜色
    UITextField *searchField=[_mySearchBar valueForKey:@"_searchField"];
    searchField.textColor=ZCColor(240, 208, 122);
    //提示语的字体颜色
    [searchField setValue:ZCColor(240, 208, 122) forKeyPath:@"_placeholderLabel.textColor"];
    [_mySearchBar setSearchFieldBackgroundImage:[UIImage imageNamed:@"sousuokuang"] forState:UIControlStateNormal];
    //修改提示语左边的图片
    [_mySearchBar setImage:[UIImage imageNamed:@"sousuo_icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    
    //移除灰色模板背景
    for (UIView *subview in [[_mySearchBar.subviews firstObject] subviews]) {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [subview removeFromSuperview];
            break;
        }
    }
    
   
    self.tableView.tableHeaderView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];

    
    //加入列表的header里面
    self.tableView.tableHeaderView = _mySearchBar;
    
    _mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
    //_mySearchDisplayController = [[UISearchDisplayController alloc] init];
    _mySearchDisplayController.delegate = self;
    // searchResultsDataSource 就是 UITableViewDataSource
    _mySearchDisplayController.searchResultsDataSource = self;
    // searchResultsDelegate 就是 UITableViewDelegate
    _mySearchDisplayController.searchResultsDelegate = self;
   // [self.searchDisplayController setActive:NO animated:NO];
    
    _mySearchDisplayController.searchResultsTableView.backgroundColor=[UIColor colorWithPatternImage:[UIImage imageNamed:@"suoyou_bj_02"]];
    //让分割线不显示
   // _mySearchDisplayController.searchResultsTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    //让下面没内容的分割线不显示
    _mySearchDisplayController.searchResultsTableView.tableFooterView = [[UIView alloc] init];
    //分割线颜色
    [_mySearchDisplayController.searchResultsTableView   setSeparatorColor:ZCColor(240, 208, 122)];
    
    
    
    
   // _mySearchDisplayController.searchBar
    
//    //移除灰色模板背景
//    for (UIView *subview in [[_mySearchDisplayController.searchBar.subviews firstObject] subviews]) {
//        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//            [subview removeFromSuperview];
//            break;
//        }
//    }

    
}

#pragma mark UISearchBar and UISearchDisplayController Delegate Methods




//searchBar开始编辑时改变取消按钮的文字
- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
//    _mySearchBar.showsCancelButton = YES;
    [_mySearchBar setShowsCancelButton:YES animated:YES];
    NSArray *subViews;
    
    if (is_IOS_7) {
        subViews = [(_mySearchBar.subviews[0]) subviews];
    }
    else {
        subViews = _mySearchBar.subviews;
    }
    
    for (id view in subViews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton* cancelbutton = (UIButton* )view;
            [cancelbutton setTitle:@"取消" forState:UIControlStateNormal];
            
            break;
        }
    }
    
    
    
    }

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    
   
    //準備搜尋前，把上面調整的TableView調整回全屏幕的狀態
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT-20);
    }];
    
    
    //影藏状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationSlide];
    
//    
//        //移除灰色模板背景
//        for (UIView *subview in [[_mySearchDisplayController.searchBar.subviews firstObject] subviews]) {
//            if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
//                [subview removeFromSuperview];
//                break;
//            }
//        }

    
    
//    if (_mySearchBar.isHidden) {
//        _mySearchDisplayController=[[UISearchDisplayController alloc] init];
//    }else
//    {
//    _mySearchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:_mySearchBar contentsController:self];
//    }
    
    return YES;
}

-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar
{
    //搜尋結束後，恢復原狀
    [UIView animateWithDuration:1.0 animations:^{
        self.tableView.frame = CGRectMake(0, is_IOS_7?64:44, SCREEN_WIDTH, SCREEN_HEIGHT-64);
    }];
    
    
    //显示状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationSlide];
    
    return YES;
}

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchString:(NSString *)searchString

{
//    if(self.tableView == _mySearchDisplayController.searchResultsTableView)
//    {
//        self.tableView.sectionHeaderHeight = 0;
//    }else{
//        self.tableView.sectionHeaderHeight = 40;
//    }

    //一旦SearchBar輸入內容有變化，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    // Return YES to cause the search result table view to be reloaded.
    
    [self filterContentForSearchText:searchString
                               scope:[_mySearchBar scopeButtonTitles][_mySearchBar.selectedScopeButtonIndex]];
    
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller

shouldReloadTableForSearchScope:(NSInteger)searchOption

{
    //如果设置了选项，当Scope Button选项有變化的时候，則執行這個方法，詢問要不要重裝searchResultTableView的數據
    
    // Return YES to cause the search result table view to be reloaded.
    
    [self filterContentForSearchText:_mySearchBar.text
                               scope:_mySearchBar.scopeButtonTitles[searchOption]];
    
    return YES;
}

//源字符串内容是否包含或等于要搜索的字符串内容
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < _dataArray.count; i++) {
       
        NSMutableArray *coursesArrays=[_dataArray[i] venues];
        for (int j=0; j<coursesArrays.count; j++) {
            ZCCityStadium *cityStadium=coursesArrays[j];
            NSString *storeString =cityStadium.name;
            
            NSRange storeRange = NSMakeRange(0, storeString.length);
            NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
            if (foundRange.length) {
                [tempResults addObject:cityStadium];
            }

        }
            }
    
    [_resultsData removeAllObjects];
    [_resultsData addObjectsFromArray:tempResults];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    //取消选中
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == _mySearchDisplayController.searchResultsTableView)
    {
        //[self myAlertViewAccording:[_resultsData[indexPath.row] name]];
       // [self myAlertViewAccording:@"haha"];
    }
    else
    {
        //NSMutableArray *cityStadium=_dataArray[indexPath.section];
       // [self myAlertViewAccording:[cityStadium[indexPath.row] name]];
        
        //[self myAlertViewAccording:@"hehe"];
        
//        ZCCity *city= self.dataArray[indexPath.section];
//        ZCCityStadium *stadium = city.venues[indexPath.row];
//        
//        NSString *uuidStr=stadium.uuid;
//        ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
//        if ([tool.eventType isEqual:@"practice"]) {
//            
//            ZCSettingTVController *settingView=[[ZCSettingTVController alloc] init];
//            
//            
//            
//            settingView.uuidStr=uuidStr;
//            
//            
//            [self.navigationController pushViewController:settingView animated:YES];
//
//        }
        
    }
    
    
    
    
    
    ZCCity *city= self.dataArray[indexPath.section];
    ZCCityStadium *stadium = city.venues[indexPath.row];
    
    NSString *uuidStr=stadium.uuid;
    
    if ([self.delegaterr respondsToSelector:@selector(ZCSwitchTableViewController:andUuid:)]) {
        [self.delegaterr ZCSwitchTableViewController:self andUuid:uuidStr];
        
        ZCSettingTVController *vc = self.navigationController.viewControllers[2];
        
        vc.uuidStr=uuidStr;
        
       // ZCSettingTVController *settingView= [self.navigationController.viewControllers objectAtIndex:5];
        //ZCSettingTVController *settingView=[[ZCSettingTVController alloc] init];
        //self.delegate=settingView;
       // self.delegate=settingView;
        [self.navigationController popToViewController:vc animated:YES
         ];
    }
    
    
    ZCSettingTVController *vc = self.navigationController.viewControllers[2];
    vc.uuidStr=uuidStr;
    [self.navigationController popToViewController:vc animated:YES
     ];
    
//    ZCEventUuidTool *tool=[ZCEventUuidTool sharedEventUuidTool];
//    if ([tool.eventType isEqual:@"practice"]) {
//        
//        ZCSettingTVController *settingView=[[ZCSettingTVController alloc] init];
//        
//        
//        
//        settingView.uuidStr=uuidStr;
//        
//        
//        [self.navigationController pushViewController:settingView animated:YES];
//        
//    }

    
}

-(void)myAlertViewAccording:(NSString *)content
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"cell－content" message:content delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alert show];
}



//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
