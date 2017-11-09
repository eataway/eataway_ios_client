//
//  FirstSelectLocationViewController.m
//  EatAway
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FirstSelectLocationViewController.h"



#import "AddressTableViewCell.h"

#import "AddressAddNewViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MBProgressHUD.h>

@interface FirstSelectLocationViewController ()<UITableViewDelegate,UITableViewDataSource,AddressAddNewViewControllerDelegate,AddressTableViewCellDelegate,CLLocationManagerDelegate>
{
    UITableView *_tableView;
    UIView *viewNCBarUnder;
    BOOL needRefreshData;
    MBProgressHUD *progress;
    NSMutableArray *arrAddresss;
    
    UILabel *labelHeadTitle;
}
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation FirstSelectLocationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.strTitle;
    needRefreshData = YES;
    arrAddresss = [[NSMutableArray alloc]init];
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    [self.locationManager requestWhenInUseAuthorization];
    
    self.title = ZEString(@"选择位置", @"Select location");
    
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(btnClntrolClick)];
        self.navigationItem.rightBarButtonItem = itemRight;
    [self tableViewInit];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (needRefreshData)
    {
        [self reloadTableViewData];
        needRefreshData = NO;
    }
}
-(void)btnClntrolClick
{
    AddressAddNewViewController *AANVC = [[AddressAddNewViewController alloc]init];
    AANVC.delegate = self;
    [self.navigationController pushViewController:AANVC animated:YES];
}
-(void)AddressAddNewAddressSucceed
{
    needRefreshData = YES;
}
-(void)reloadTableViewData
{
    if (![ObjectForUser checkLogin])
    {
        
    }
    else
    {
        __weak FirstSelectLocationViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/get_address" parameter:@{@"userid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"获取收货地址失败，请检查网络连接", @"Failed to get address, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [arrAddresss removeAllObjects];
                [arrAddresss addObjectsFromArray:resultDic[@"msg"]];
                [_tableView reloadData];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"获取收货地址失败，请检查网络连接", @"Failed to get address, please check the network connection") onViewController:blockSelf];
            }
        }];
    }
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64 ) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrAddresss.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[AddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    NSDictionary *dic = arrAddresss[indexPath.row];
    [cell setcontentWithAddress:[NSString stringWithFormat:@"%@ %@",dic[@"location_address"],dic[@"detailed_address"]] name:dic[@"real_name"] sex:dic[@"gender"] phoneNumber:dic[@"mobile"] selected:YES selectOrWrite:1];
    
    cell.tag = indexPath.row;
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 70;
}
//header当前位置
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc]init];
    viewHeader.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 50)];
    viewBG.backgroundColor  = [UIColor whiteColor];
    viewBG.clipsToBounds = YES;
    viewBG.layer.cornerRadius = 7;
    [viewHeader addSubview:viewBG];
    
    
    if(labelHeadTitle == nil)
    {
        labelHeadTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 10 , 10 + 10, WINDOWWIDTH - 40 , 30)];
        labelHeadTitle.font = [UIFont systemFontOfSize:13];
        labelHeadTitle.textAlignment = NSTextAlignmentCenter;
        labelHeadTitle.text = ZEString(@"当前地址：定位中", @"Current address: positioning");
    }
 
    [viewHeader addSubview:labelHeadTitle];

    
    UIButton *btnHeader = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHeader.frame = CGRectMake(0, 10, WINDOWWIDTH, 50);
    [btnHeader addTarget:self action:@selector(btnHeaderClick) forControlEvents:UIControlEventTouchUpInside];
    [viewHeader addSubview:btnHeader];
    
    return viewHeader;
}
-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
//右滑删除功能
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSDictionary *dic = arrAddresss[indexPath.row];
        __weak FirstSelectLocationViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/alldel_address" parameter:@{@"userid":USERID,@"token":TOKEN,@"str_addid":dic[@"addid"]} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"删除失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [arrAddresss removeObjectAtIndex:indexPath.row];
                [_tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"删除失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
        }];
    }
}
//点击选择地址
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
        if ([self.delegate respondsToSelector:@selector(FirstSelectLocationViewControllerSelectAddressWithDictionary:)])
        {
            NSDictionary *dic = arrAddresss[indexPath.row];
            [[NSUserDefaults standardUserDefaults] setObject:arrAddresss[indexPath.row][@"coordinate"] forKey:@"location"];
            [self.delegate FirstSelectLocationViewControllerSelectAddressWithDictionary:dic];
            [self.navigationController popViewControllerAnimated:YES];
       
        }

}
//修改地址
-(void)AddressTableViewCellChangeAddressWithIndex:(NSInteger)cellIndex
{
    NSDictionary *dic = arrAddresss[cellIndex];
    AddressAddNewViewController *AANVC = [[AddressAddNewViewController alloc]init];
    AANVC.delegate = self;
    AANVC.reset = @"1";
    AANVC.dicAdd = dic;
    [self.navigationController pushViewController:AANVC animated:YES];
}

//定位
#pragma mark - 代理方法，当授权改变时调用
- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    
    
    // 获取授权后，通过
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        //开始定位(具体位置要通过代理获得)
        [self.locationManager startUpdatingLocation];
        //设置精确度
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBestForNavigation;
        //设置过滤距离
        self.locationManager.distanceFilter = 1000;
        //开始定位方向
        [self.locationManager startUpdatingHeading];
    }
    
}



#pragma mark - 方向
- (void)locationManager:(CLLocationManager *)manager didUpdateHeading:(CLHeading *)newHeading {
    
    //输出方向
    //地理方向
    NSLog(@"true = %f ",newHeading.trueHeading);
    
    // 磁极方向
    NSLog(@"mag = %f",newHeading.magneticHeading);
    
    
}

#pragma mark - 定位代理
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations {
    
    //    NSLog(@"%@",locations);
    
    //获取当前位置
    CLLocation *location = manager.location;
    //获取坐标
    CLLocationCoordinate2D corrdinate = location.coordinate;
    
    //打印地址
    NSLog(@"latitude = %f longtude = %f",corrdinate.longitude,corrdinate.latitude);
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"%f,%f",corrdinate.longitude,corrdinate.latitude] forKey:@"location"];
    // 地址的编码通过经纬度得到具体的地址
    CLGeocoder *gecoder = [[CLGeocoder alloc] init];
    
    [gecoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        
        CLPlacemark *placemark = [placemarks firstObject];
        
        //打印地址
        NSLog(@"%@",placemark.name);
        labelHeadTitle.text =[NSString stringWithFormat:@"%@:%@",ZEString(@"当前位置", @"Current address"),placemark.name];
    }];
    
    
    //停止定位
    [self.locationManager stopUpdatingLocation];
    
}
-(void)btnHeaderClick
{
    [self.delegate FirstSelectLocationViewControllerSelectAddressWithDictionary:nil];

    [self.navigationController popViewControllerAnimated:YES];
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

