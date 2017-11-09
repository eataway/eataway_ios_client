//
//  AddressViewController.m
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AddressViewController.h"

#import "AddressTableViewCell.h"

#import "AddressAddNewViewController.h"

#import <MBProgressHUD.h>

@interface AddressViewController ()<UITableViewDelegate,UITableViewDataSource,AddressAddNewViewControllerDelegate,AddressTableViewCellDelegate>
{
    UITableView *_tableView;
    BOOL needRefreshData;
    MBProgressHUD *progress;
    NSMutableArray *arrAddresss;
}
@end

@implementation AddressViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = self.strTitle;
    needRefreshData = YES;
    arrAddresss = [[NSMutableArray alloc]init];
    
    UIView *viewTopBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTopBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTopBar];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
//    UIBarButtonItem *itemRight = [[UIBarButtonItem alloc]initWithTitle:ZEString(@"管理", @"Control") style:UIBarButtonItemStylePlain target:self action:@selector(btnClntrolClick)];
//    self.navigationItem.rightBarButtonItem = itemRight;
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
//-(void)btnClntrolClick
//{
//    [_tableView setEditing:!_tableView.editing animated:YES];
//}
-(void)reloadTableViewData
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else
    {
        __weak AddressViewController *blockSelf = self;
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
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHeader = [[UIView alloc]init];
    viewHeader.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 50)];
    viewBG.backgroundColor  = [UIColor whiteColor];
    viewBG.clipsToBounds = YES;
    viewBG.layer.cornerRadius = 7;
    [viewHeader addSubview:viewBG];
    
    UIImageView *imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10 + 10, 10 + 17.5 , 15, 15)];
    imageV.image = [UIImage imageNamed:@"2.2.4_icon_add.png"];
    [viewHeader addSubview:imageV];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 10 + 15 + 10, 10 + 10, WINDOWWIDTH - 45 - 30, 30)];
    labelTitle.font = [UIFont systemFontOfSize:13];
    labelTitle.text = ZEString(@"新增收货地址", @"New Address");
    [viewHeader addSubview:labelTitle];
    
    UIImageView *imageV2 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10 - 8, 25, 8, 14)];
    imageV2.image = [UIImage imageNamed:@"2.2.4_icon_more.png"];
    [viewHeader addSubview:imageV2];
    
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
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSDictionary *dic = arrAddresss[indexPath.row];
        __weak AddressViewController *blockSelf = self;
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
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.isSelectAddress)
    {
        if ([self.delegate respondsToSelector:@selector(addressViewControllerSelectAddressWithDictionary:)])
        {
            NSDictionary *dic = arrAddresss[indexPath.row];
            [self.delegate addressViewControllerSelectAddressWithDictionary:dic];
            [self.navigationController popViewControllerAnimated:YES];
            
            
            
        }
    }
}
-(void)btnHeaderClick
{
    AddressAddNewViewController *AANVC = [[AddressAddNewViewController alloc]init];
    AANVC.delegate = self;
    [self.navigationController pushViewController:AANVC animated:YES];
}
-(void)AddressTableViewCellChangeAddressWithIndex:(NSInteger)cellIndex
{
    NSDictionary *dic = arrAddresss[cellIndex];
    
    AddressAddNewViewController *AANVC = [[AddressAddNewViewController alloc]init];
    AANVC.delegate = self;
    AANVC.reset = @"1";
    AANVC.dicAdd = dic;
    
    [self.navigationController pushViewController:AANVC animated:YES];
}
-(void)AddressAddNewAddressSucceed
{
    needRefreshData = YES;
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
