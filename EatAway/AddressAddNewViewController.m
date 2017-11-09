//
//  AddressAddNewViewController.m
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AddressAddNewViewController.h"

#import "AddressPickLocationViewController.h"

#import <MBProgressHUD.h>


@interface AddressAddNewViewController ()<UITableViewDelegate,UITableViewDataSource,AddressPickLocationViewControllerDelegate>
{
    UITableView *_tableView;
    UITextField *TFName;
    UITextField *TFPhoneNum;
    UITextField *TFAddress;
    
    UIButton *btnMale;
    UIButton *btnFemale;
    
    NSInteger userSex;
    
    NSString *strNameFrom;
    NSString *strPhoneFrom;
    NSString *strAddress1From;
    NSString *strAddress2From;
    NSString *strAddID;
    NSString *strLocationFrom;
    
    MBProgressHUD *progress;
    
}
@end

@implementation AddressAddNewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"新增收货地址", @"New address");
    userSex = 1;
    if ([self.reset isEqualToString:@"1"])
    {
        strNameFrom = self.dicAdd[@"real_name"];
        strPhoneFrom = self.dicAdd[@"mobile"];
        strAddress1From = self.dicAdd[@"location_address"];
        strAddress2From = self.dicAdd[@"detailed_address"];
        strAddID = self.dicAdd[@"addid"];
        userSex = [self.dicAdd[@"gender"] integerValue];
        strLocationFrom = self.dicAdd[@"coordinate"];
    }
    else
    {
        strNameFrom = @"";
        strPhoneFrom = @"";
        strAddress1From = @"";
        strAddress2From = @"";
        strAddID = @"";
        userSex = 1;
    }
    
    UIView *viewTopMainColor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT)];
    viewTopMainColor.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTopMainColor];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    //保存button
    UIButton * OkButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    OkButton.frame = CGRectMake(0, 0, 40, 40);
    [OkButton addTarget:self action:@selector(itemDoneClick) forControlEvents:(UIControlEventTouchUpInside)];
//    [OkButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    [OkButton setTitle:ZEString(@"保存", @"OK") forState:UIControlStateNormal];
    [OkButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:OkButton];
    
//    [self navigationbarInit];
    [self tableViewInit];
}
-(void)navigationbarInit
{
    UIBarButtonItem *itemDone = [[UIBarButtonItem alloc]initWithTitle:ZEString(@"保存", @"OK") style:UIBarButtonItemStylePlain target:self action:@selector(itemDoneClick)];
    self.navigationItem.rightBarButtonItem = itemDone;
    
}
-(void)tableViewInit
{
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 4)
    {
        return 30;
    }
    else
    {
        return 50;
    }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0 || indexPath.row == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell04"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell04"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            cell.textLabel.font = [UIFont systemFontOfSize:12];
            cell.textLabel.textColor = [UIColor colorWithWhite:180/255.0 alpha:1];
        }
        if (indexPath.row == 0)
        {
            cell.textLabel.text = ZEString(@"联系人", @"Contacts");
        }
        else
        {
            cell.textLabel.text = ZEString(@"送餐地址", @"Delivery address");
        }
        
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell01"];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 55, 30)];
            label.font = [UIFont systemFontOfSize:13];
            label.text = ZEString(@"姓名：", @"Name：");
            [cell addSubview:label];
            
            TFName = [[UITextField alloc]initWithFrame:CGRectMake(10 + 55, 10, WINDOWWIDTH - 10 - 55 - 10, 30)];
            TFName.font = [UIFont systemFontOfSize:13];
            TFName.placeholder = ZEString(@"请填写联系人姓名", @"Enter first name");
            TFName.text = strNameFrom;
            [cell addSubview:TFName];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        
    }
    else if (indexPath.row == 2)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
            
            btnMale = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMale.frame = CGRectMake(10 + 45, 15, 20, 20);
            btnMale.tag = 0;
            if (userSex == 1)
            {
                [btnMale setImage:[UIImage imageNamed:@"2.2.6_icon_sel.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnMale setImage:[UIImage imageNamed:@"2.2.5_icon_nor.png"] forState:UIControlStateNormal];
            }
            [btnMale addTarget:self action:@selector(btnMaleClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnMale];
            
            UILabel *labelMale = [[UILabel alloc]initWithFrame:CGRectMake(10 + 45 + 20 + 10, 15, 50, 20)];
            labelMale.font = [UIFont systemFontOfSize:13];
            labelMale.text = ZEString(@"先生", @"Male");
            [cell addSubview:labelMale];
            
            btnFemale = [UIButton buttonWithType:UIButtonTypeCustom];
            btnFemale.frame = CGRectMake(10 + 45 + 20 + 10 + 50 + 10, 15, 20, 20);
            btnFemale.tag = 0;
            if (userSex == 1)
            {
                [btnFemale setImage:[UIImage imageNamed:@"2.2.5_icon_nor.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnFemale setImage:[UIImage imageNamed:@"2.2.6_icon_sel.png"] forState:UIControlStateNormal];
            }
            [btnFemale addTarget:self action:@selector(btnFemaleClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnFemale];
            
            UILabel *labelFemale = [[UILabel alloc]initWithFrame:CGRectMake(10 + 45 + 20 + 10 + 50 + 10 + 20 + 10, 15, 50, 20)];
            labelFemale.font = [UIFont systemFontOfSize:13];
            labelFemale.text = ZEString(@"女士", @"Female");
            [cell addSubview:labelFemale];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
            
        }
        
        
    }
    else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell03"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell03"];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 55, 30)];
            label.font = [UIFont systemFontOfSize:13];
            label.text = ZEString(@"手机号：", @"Phone：");
            [cell addSubview:label];
            
            TFPhoneNum = [[UITextField alloc]initWithFrame:CGRectMake(10 + 55, 10, WINDOWWIDTH - 10 - 55 - 10, 30)];
            TFPhoneNum.font = [UIFont systemFontOfSize:13];
            TFPhoneNum.placeholder = ZEString(@"请填写收货人手机号", @"Enter phone number");
            TFPhoneNum.text = strPhoneFrom;
            [cell addSubview:TFPhoneNum];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        
    }
    else if (indexPath.row == 5)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell05"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell05"];
            cell.textLabel.font = [UIFont systemFontOfSize:13];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
            
        }
        if ([self.reset isEqualToString:@"1"])
        {
            cell.textLabel.text = strAddress1From;
            cell.textLabel.textColor = [UIColor blackColor];
        }
        else
        {
            cell.textLabel.textColor = [UIColor colorWithWhite:204/255.0 alpha:1];
            cell.textLabel.text = ZEString(@"街道地址", @"District/building/School");
        }

        
        
    }
    else if (indexPath.row == 6)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell06"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell06"];
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
            if (ISCHINESE)
            {
                label.frame = CGRectMake(10, 10, 90, 30);
            }
            else
            {
                label.frame = CGRectMake(10, 10, 110, 30);
            }
            label.font = [UIFont systemFontOfSize:13];
            label.text = ZEString(@"楼号/门牌号：", @"House number：");
            [cell addSubview:label];
            
            TFAddress = [[UITextField alloc]init ];
        
            if (ISCHINESE)
            {
                TFAddress.frame = CGRectMake(10 + 90, 10, WINDOWWIDTH - 10 - 90 - 10, 30);
            }
            else
            {
                TFAddress.frame = CGRectMake(10 + 110, 10, WINDOWWIDTH - 10 - 110 - 10, 30);
            }
            TFAddress.font = [UIFont systemFontOfSize:13];
            TFAddress.placeholder = ZEString(@"例：2号楼-306室(可不填写)", @"Example: room306,building2(optional)");
            TFAddress.text = strAddress2From;
            [cell addSubview:TFAddress];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [cell addSubview:viewDown];
        }
        
    }

    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 5)
    {
//        GMSPlacePickerConfig *config = [[GMSPlacePickerConfig alloc] initWithViewport:nil];
//        _placePicker = [[GMSPlacePickerViewController alloc]initWithConfig:config];
//        _placePicker.delegate = self;
//        
//        
//        
//        [self.navigationController pushViewController:_placePicker animated:YES];
        
        AddressPickLocationViewController *APLVC = [[AddressPickLocationViewController alloc]init];
        APLVC.delegate = self;
        [self.navigationController pushViewController:APLVC animated:YES];
        
        
    }
}
-(void)AddressPickLocationViewControllerSelectResult:(NSString *)strResult location:(NSString *)strLocation
{
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    cell.textLabel.text = strResult;
    cell.textLabel.textColor = [UIColor blackColor];
    
    strLocationFrom = strLocation;
    
}
-(void)btnFemaleClick
{
    userSex = 2;
    [btnMale setImage:[UIImage imageNamed:@"2.2.5_icon_nor.png"] forState:UIControlStateNormal];
    [btnFemale setImage:[UIImage imageNamed:@"2.2.6_icon_sel.png"] forState:UIControlStateNormal];
}
-(void)btnMaleClick
{
    userSex = 1;
    [btnMale setImage:[UIImage imageNamed:@"2.2.6_icon_sel.png"] forState:UIControlStateNormal];
    [btnFemale setImage:[UIImage imageNamed:@"2.2.5_icon_nor.png"] forState:UIControlStateNormal];
}
-(void)itemDoneClick
{
    __weak AddressAddNewViewController *blockSelf = self;
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:5 inSection:0]];
    BOOL isSelectedAddress = [cell.textLabel.text isEqualToString:@"小区/大厦/学校"] || [cell.textLabel.text isEqualToString:@"District/building/School"];
    if(![ObjectForUser checkLogin])
    {
        [TotalFunctionView alertContent:ZEString(@"请先登录", @"Please login first") onViewController:blockSelf];
    }
    else if (TFName.text.length <= 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入姓名", @"Please enter your name") onViewController:blockSelf];
    }
    else if (TFPhoneNum.text.length <= 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入手机号", @"Please enter your phone number") onViewController:blockSelf];
    }
    else
    {
        NSString *strAddress = @"";
        if (TFAddress.text.length <= 0 || isSelectedAddress)
        {
            strAddress = @"";
        }
        else
        {
            strAddress = TFAddress.text;
        }
        
        if (self.reset)
        {
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/edit_address" parameter:@{@"userid":USERID,@"token":TOKEN,@"addid":strAddID,@"real_name":TFName.text,@"gender":[NSString stringWithFormat:@"%ld",(long)userSex],@"mobile":TFPhoneNum.text,@"location_address":cell.textLabel.text,@"detailed_address":strAddress,@"coordinate":strLocationFrom} resultBlock:^(NSDictionary *resultDic) {
                if (resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    [ObjectForUser checkLogin];
                    [TotalFunctionView alertContent:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    [blockSelf.delegate AddressAddNewAddressSucceed];
                    [TotalFunctionView alertAndDoneWithContent:ZEString(@"修改地址成功", @"Operation  successfully") onViewController:blockSelf];
                    
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                }
            }];

        }
        else
        {
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/add_address" parameter:@{@"userid":USERID,@"token":TOKEN,@"real_name":TFName.text,@"gender":[NSString stringWithFormat:@"%ld",(long)userSex],@"mobile":TFPhoneNum.text,@"location_address":cell.textLabel.text,@"detailed_address":strAddress,@"coordinate":strLocationFrom} resultBlock:^(NSDictionary *resultDic)
            {
                [progress hide:YES];
                if (resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"添加失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    [ObjectForUser checkLogin];
                    [TotalFunctionView alertContent:ZEString(@"登录信息过期，请重新登录", @"Login information is outdated, please login again") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    [blockSelf.delegate AddressAddNewAddressSucceed];
                    [TotalFunctionView alertAndDoneWithContent:ZEString(@"添加地址成功", @"Add address successfully") onViewController:blockSelf];
                    
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"添加失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                }
            }];

        }
        
        
    }
    
   
}

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
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
