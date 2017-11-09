//
//  CurrentOrderViewController.m
//  EatAway
//
//  Created by apple on 2017/7/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "CurrentOrderViewController.h"

#import "CurrentOrderTableViewCell.h"

#import "OrderDetailViewController.h"

#import "OrderCommentViewController.h"

#import "MerchantViewController.h"

#import <MBProgressHUD.h>

@interface CurrentOrderViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    NSMutableArray *arrOrders;
    
    MBProgressHUD *progress;
    BOOL isFirstTimeIn;
    UILabel *labelNoOrder;
}
@end

@implementation CurrentOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.title = ZEString(@"当前订单", @"Current order");
    self.automaticallyAdjustsScrollViewInsets = NO;
    isFirstTimeIn = YES;
    arrOrders = [[NSMutableArray alloc]init];
    UIView *viewTopBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTopBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTopBar];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [self tableViewInit];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    CGFloat alpha = 0;
    self.navigationController.navigationBar.translucent = YES;
    
    UIColor *color = [UIColor colorWithRed:132/255.0 green:220/255.0 blue:4/255.0 alpha:alpha];
    
    CGRect rect = CGRectMake(0.0f, 0.0f, WINDOWWIDTH, 64);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (isFirstTimeIn)
    {
        [self loadData];
        isFirstTimeIn = NO;
    }
    
}
//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewWillDisappear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}
-(void)loadData
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak CurrentOrderViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/order/worderlist" parameter:@{@"userid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic)
        {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"获取当前订单失败，请检查网络连接", @"Get current order failed, please check the network connection") onViewController:blockSelf];
            }
            else if([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [arrOrders removeAllObjects];
                NSArray *arr = resultDic[@"msg"];
                [arrOrders addObjectsFromArray:arr];
                if (arrOrders.count == 0)
                {
                    labelNoOrder.hidden = NO;
                }
                else
                {
                    labelNoOrder.hidden = YES;
                }
                [_tableView reloadData];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"获取当前订单失败，请检查网络连接", @"Get current order failed, please check the network connection") onViewController:blockSelf];
            }
        }];
    }

}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    labelNoOrder = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, 40)];
    labelNoOrder.text = ZEString(@"当前无订单", @"No current order");
    labelNoOrder.font = [UIFont systemFontOfSize:13];
    labelNoOrder.textAlignment = NSTextAlignmentCenter;
    labelNoOrder.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    [self.view addSubview:labelNoOrder];
    labelNoOrder.hidden = YES;

    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return arrOrders.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
    return cell.frame.size.height;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CurrentOrderTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[CurrentOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.delegate = self;
    }
    cell.tag = indexPath.row;
    NSDictionary *dic = arrOrders[indexPath.row];
    NSMutableDictionary *dicFoods = [[NSMutableDictionary alloc]init];
    NSString *strGoodsinfo = dic[@"goodsinfo"];
    NSArray *arrGoodsStr = [strGoodsinfo componentsSeparatedByString:@"|"];
    NSMutableArray *arrMutableGoodsStr = [[NSMutableArray alloc]initWithArray:arrGoodsStr];
    if ([arrGoodsStr containsObject:@""])
    {
        [arrMutableGoodsStr removeObject:@""];
    }
    
    
    
    for (int a = 0; a < arrMutableGoodsStr.count; a ++)
    {
        
        
        NSString *str = arrMutableGoodsStr[a];
        NSArray *arrDetails = [str componentsSeparatedByString:@","];
        
        NSDictionary *dicValue = @{@"image":arrDetails[3],@"name":arrDetails[1],@"count":arrDetails[4],@"price":arrDetails[2]};
        NSString *strKey = arrDetails[0];
        
        [dicFoods setValue:dicValue forKey:strKey];
        
    }
    
    
    
    [cell setContentWithHeadImage:dic[@"shophead"] title:dic[@"shopname"] listDic:dicFoods shippingFee:dic[@"money"] totalPrice:dic[@"allprice"] orderState:dic[@"state"] distance:dic[@"juli"] statu:dic[@"statu"]];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *dic = arrOrders[indexPath.row];

    OrderDetailViewController *ODVC = [[OrderDetailViewController alloc]init];
    ODVC.strOrderID = dic[@"orderid"];
    [self.navigationController pushViewController:ODVC animated:YES];
}
-(void)CurrentOrderTableViewCellContactWithCellIndex:(NSInteger)cellIndex
{
    NSDictionary *dic = arrOrders[cellIndex];
    NSString *strPhoneNum = dic[@"mobile"];
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",strPhoneNum];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
-(void)CurrentOrderTableViewCellCommenttWithCellIndex:(NSInteger)cellIndex
{
    OrderCommentViewController *OCVC = [[OrderCommentViewController alloc]init];
    NSDictionary *dic = arrOrders[cellIndex];
    [OCVC setContentWithHeadPhotoURL:dic[@"shophead"] shopName:dic[@"shopname"] ShopImageURL:dic[@"shopphoto"] orderid:dic[@"orderid"] shopID:dic[@"shopid"]];
    OCVC.delegate = self;
    [self.navigationController pushViewController:OCVC animated:YES];

}
-(void)orderCommentViewControllerSucceed
{
    isFirstTimeIn = YES;
}
-(void)CurrentOrderTableViewCellOperationKind:(NSString *)strOperationKind WithCellIndex:(NSInteger)cellIndex
{
    __block NSMutableDictionary *dic =  [[NSMutableDictionary alloc]initWithDictionary:arrOrders[cellIndex]];
    NSString *strOrderID = dic[@"orderid"];
    __weak CurrentOrderViewController *blockSelf = self;
    if([strOperationKind isEqualToString:@"3"])
    {
        [[ObjectForRequest shareObject]requestWithURL:@"index.php/home/order/queren" parameter:@{@"userid":USERID,@"token":TOKEN,@"orderid":strOrderID} resultBlock:^(NSDictionary *resultDic) {
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"确认送达失败，请检查网络连接", @"Confirm  receiving failed, please check the Internet connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [dic setValue:@"4" forKey:@"state"];
                [arrOrders replaceObjectAtIndex:cellIndex withObject:dic];
                CurrentOrderTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:cellIndex inSection:0]];
                [cell changeCellStateWithState:@"4"];
                
                
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"确认送达失败，请检查网络连接", @"Confirm  receiving failed, please check the Internet connection") onViewController:blockSelf];
            }
        }];
    }

    else if ([strOperationKind isEqualToString:@"4"] || [strOperationKind isEqualToString:@"5"])
    {
        NSDictionary *dic = arrOrders[cellIndex];
        MerchantViewController *MVC = [[MerchantViewController alloc]init];
        MVC.shopID = dic[@"shopid"];
        MVC.userLocation = LOCATION;
        [self.navigationController pushViewController:MVC animated:YES];
    }
}

- (void)backAction{
    
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
