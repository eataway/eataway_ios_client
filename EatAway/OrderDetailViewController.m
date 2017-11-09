//
//  OrderDetailViewController.m
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderDetailViewController.h"

#import "OrderDetailStateTableViewCell.h"
#import "OrderDetailFoodsTableViewCell.h"
#import "OrderDetailInfomationTableViewCell.h"

#import "OrderCommentViewController.h"
#import "MerchantViewController.h"

#import <MBProgressHUD.h>

@interface OrderDetailViewController ()<UITableViewDelegate,UITableViewDataSource,OrderCommentViewControllerDelegate>
{
    UITableView *_tableView;
    MBProgressHUD *progress;
    
    UIButton *btnPingjia;
    UIButton *btnMain;
    
    
    BOOL isFirstTimeIn;
    
    NSString *strOrderState;
    NSString *strDeliveryTime;
    NSString *strAddTime;
    NSArray *arrFoods;
    
    NSString *strPSFee;
    NSString *strDistance;
    NSString *strTotalPrice;
    
    NSString *strAddress;
    NSString *strTips;
    NSString *strHeadImageURL;
    NSString *strPhotoImageURL;
    NSString *strShopName;
    NSString *strShopID;
    NSString *strShopPhone;
    
    UIButton *btnYipingjia;
    
    
    NSString *strGoodsinfo;
    
    NSString *statu;
}
@end

@implementation OrderDetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = ZEString(@"订单详情", @"Order details");
    strOrderState = @"";
    strAddTime = @"";
    arrFoods = @[];
    strPSFee = @"";
    strDistance = @"";
    strTotalPrice = @"";
    strHeadImageURL = @"";
    strAddress = @"";
    strTips = @"";
    strShopName = @"";
    strShopID = @"";
    
    strDeliveryTime = @"";
    strShopPhone = @"";

    isFirstTimeIn = YES;
    
    UIView *viewTopBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTopBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTopBar];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"3.1.1_icon_phone.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnContaceClick)];
    self.navigationItem.rightBarButtonItem = item;
    
    [self tableViewInit];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    if (isFirstTimeIn)
    {
        if ([ObjectForUser checkLogin])
        {
            __weak OrderDetailViewController *blockSelf = self;
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject]requestWithURL:@"index.php/home/order/orderdetails" parameter:@{@"token":TOKEN,@"userid":USERID,@"orderid":self.strOrderID} resultBlock:^(NSDictionary *resultDic)
             {
                 [progress hide:YES];
                 if (resultDic == nil)
                 {
                     [TotalFunctionView alertContent:ZEString(@"获取订单详情失败，请检查网络连接", @"Get order details failed, please check the network connection") onViewController:blockSelf];
                 }
                 else if ([resultDic[@"status"] isEqual:@(9)])
                 {
                     ALERTCLEARLOGINBLOCK
                 }
                 else if ([resultDic[@"status"] isEqual:@(1)])
                 {
                     NSDictionary *dic = resultDic[@"msg"];
                     strOrderState = dic[@"state"];
                     strAddTime = dic[@"addtime"];
                     arrFoods = dic[@"goods"];
                     strPSFee = dic[@"money"];
                     strDistance = dic[@"juli"];
                     strTotalPrice = dic[@"allprice"];
                     strHeadImageURL = dic[@"shophead"];
                     strAddress = dic[@"address"];
                     strTips = dic[@"beizhu"];
                     strShopName = dic[@"shopname"];
                     strShopPhone = dic[@"shopphone"];
                     
                     strPhotoImageURL = dic[@"shopphoto"];
                     strDeliveryTime = dic[@"cometime"];
                     strShopID = dic[@"shopid"];
                     
                     strGoodsinfo = dic[@"goodsinfo"];
                     
                     [_tableView reloadData];
                     [blockSelf reloadButtom];
                 }
                 else
                 {
                     [TotalFunctionView alertContent:ZEString(@"获取订单详情失败，请检查网络连接", @"Get order details failed, please check the network connection") onViewController:blockSelf];
                 }
             }];
            
        }
        else
        {
            ALERTNOTLOGINANDPOP
        }

        isFirstTimeIn = NO;
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
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 90;
    }
    else if(indexPath.row == 1)
    {
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else if (indexPath.row == 2)
    {
        return 260;
    }
    else
    {
        return 60;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    

    
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        OrderDetailStateTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
        if (!cell0)
        {
            cell0 = [[OrderDetailStateTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
        }
        NSString *strStateContent;
        if ([statu integerValue] == 1) {
            strStateContent = ZEString(@"退单中", @"Refunding");
        }else if ([statu integerValue] == 2){
            strStateContent = ZEString(@"已退单", @"Refunded");
            
        }else{
        if ([strOrderState isEqualToString:@"1"])
        {
            strStateContent = ZEString(@"等待卖家接单", @"Order processing");
        }
        else if ([strOrderState isEqualToString:@"2"])
        {
            strStateContent = ZEString(@"卖家已接单", @"Order is being prepared");
        }
        else if ([strOrderState isEqualToString:@"3"])
        {
            strStateContent = ZEString(@"商品已送达", @"order has been delivered");
        }
        else if ([strOrderState isEqualToString:@"4"])
        {
            strStateContent = ZEString(@"待评价", @"Order complete");
        }
        else if ([strOrderState isEqualToString:@"5"])
        {
            strStateContent = ZEString(@"已完成", @"Order complete");
        }
        }
        [cell0 setContentWithOrderState:strStateContent time:strAddTime];
        

        cell = cell0;
    }
    else if (indexPath.row == 1)
    {
        OrderDetailFoodsTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
        if (!cell0)
        {
            cell0 = [[OrderDetailFoodsTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell01"];
        }

        NSMutableDictionary *dicFoods = [[NSMutableDictionary alloc]init];

//        for (int a = 0; a < arrFoods.count; a ++)
//        {
//            NSDictionary *aDic = arrFoods[a];
//            NSDictionary *dicValue = @{@"image":aDic[@"goodsphoto"],@"name":aDic[@"goodsname"],@"count":aDic[@"num"],@"price":aDic[@"goodsprice"]};
//            NSString *strKey = aDic[@"goodsid"];
//            
//            [dicFoods setValue:dicValue forKey:strKey];
//            
//        }
        
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
        

        
        
        [cell0 setContentWithHeadImage:strHeadImageURL title:strShopName listDic:dicFoods shippingFee:strPSFee totalPrice:strTotalPrice distance:[NSString stringWithFormat:@"%@km",strDistance]];
        cell = cell0;
    }
    else if (indexPath.row == 2)
    {
         OrderDetailInfomationTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        if (!cell0)
        {
            cell0 = [[OrderDetailInfomationTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
        }
        [cell0 setContentWithDeliveryTime:strDeliveryTime orderNum:self.strOrderID address:strAddress remarks:strTips];
        cell = cell0;
    }
    else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell03"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell03"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            
            btnPingjia = [UIButton buttonWithType:UIButtonTypeCustom];
            btnPingjia.frame = CGRectMake(10, 15, 100, 30);
            btnPingjia.backgroundColor = [UIColor whiteColor];
            btnPingjia.clipsToBounds = YES;
            btnPingjia.layer.cornerRadius = 7;
            [btnPingjia setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
            btnPingjia.titleLabel.font = [UIFont systemFontOfSize:12];
            [btnPingjia setTitle:ZEString(@"去评价", @"Go to reviews") forState:UIControlStateNormal];
            [btnPingjia addTarget:self action:@selector(btnPingjiaClick) forControlEvents:UIControlEventTouchUpInside];
            btnPingjia.layer.borderColor = [UIColor orangeColor].CGColor;
            btnPingjia.layer.borderWidth = 1;
            [cell addSubview:btnPingjia];
            btnPingjia.hidden = YES;
            
            btnYipingjia = [UIButton buttonWithType:UIButtonTypeCustom];
            btnYipingjia.frame = CGRectMake(10, 20, 100, 20);
            btnYipingjia.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
            btnYipingjia.titleLabel.font = [UIFont systemFontOfSize:13];
            NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:ZEString(@"已评价", @"Reviews completed")];
            NSRange titleRange = {0,[title length]};
            [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
            [title addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange];
            [btnYipingjia setAttributedTitle:title forState:UIControlStateNormal];
            [cell addSubview:btnYipingjia];
            btnYipingjia.hidden = YES;
            
            btnMain = [UIButton buttonWithType:UIButtonTypeCustom];
            btnMain.frame = CGRectMake(WINDOWWIDTH - 10 - 100, 15, 100, 30);
            btnMain.backgroundColor = [UIColor orangeColor];
            btnMain.clipsToBounds = YES;
            btnMain.layer.cornerRadius = 7;
            [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            btnMain.titleLabel.font = [UIFont systemFontOfSize:12];
            [btnMain setTitle:ZEString(@"确认送达", @"Receipt") forState:UIControlStateNormal];
            [btnMain addTarget:self action:@selector(btnMainCLick) forControlEvents:UIControlEventTouchUpInside];
            btnMain.layer.borderColor = [UIColor orangeColor].CGColor;
            btnMain.layer.borderWidth = 1;
            [cell addSubview:btnMain];
            btnMain.hidden = YES;
        }
        
        [self reloadButtom];
        
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
-(void)reloadButtom
{
    if ([strOrderState isEqualToString:@"1"] || [strOrderState isEqualToString:@"2"])
    {
        btnPingjia.hidden = YES;
        btnYipingjia.hidden = YES;
        btnMain.hidden = YES;
        
        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:ZEString(@"联系卖家", @"Contact ther seller")];
        NSRange titleRange = {0,[title length]};
        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
        [title addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange];
        [btnPingjia setAttributedTitle:title forState:UIControlStateNormal];
        
    }
    else if([strOrderState isEqualToString:@"3"])
    {
        btnPingjia.hidden = YES;
        btnYipingjia.hidden = YES;
        btnMain.hidden = NO;
        
        btnMain.backgroundColor = [UIColor orangeColor];
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMain setTitle:ZEString(@"确认送达", @"Receipt") forState:UIControlStateNormal];
        
    }
    else if ([strOrderState isEqualToString:@"4"])
    {
        btnPingjia.hidden = NO;
        btnYipingjia.hidden = YES;
        btnMain.hidden = NO;
        
//        NSMutableAttributedString *title = [[NSMutableAttributedString alloc] initWithString:ZEString(@"去评价", @"Go to Reviews")];
//        NSRange titleRange = {0,[title length]};
//        [title addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange];
//        [title addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange];
//        [btnPingjia setAttributedTitle:title forState:UIControlStateNormal];
        
        btnMain.backgroundColor = [UIColor orangeColor];
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMain setTitle:ZEString(@"再来一单", @"Buy again") forState:UIControlStateNormal];
    }
    else if ([strOrderState isEqualToString:@"5"])
    {
        btnPingjia.hidden = YES;
        btnYipingjia.hidden = NO;
        btnMain.hidden = NO;
        
        [btnPingjia setTitle:ZEString(@"已评价", @"Reviews completed") forState:UIControlStateNormal];
        
        
        btnMain.backgroundColor = [UIColor orangeColor];
        [btnMain setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [btnMain setTitle:ZEString(@"再来一单", @"Buy again") forState:UIControlStateNormal];
    }
}
-(void)btnPingjiaClick
{
    if ([strOrderState isEqualToString:@"1"] || [strOrderState isEqualToString:@"2"])
    {
        NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",strShopPhone];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else if ([strOrderState isEqualToString:@"4"])
    {
        OrderCommentViewController *OCVC = [[OrderCommentViewController alloc]init];
        [OCVC setContentWithHeadPhotoURL:strHeadImageURL shopName:strShopName ShopImageURL:strPhotoImageURL orderid:self.strOrderID shopID:strShopID];
        OCVC.delegate = self;
        [self.navigationController pushViewController:OCVC animated:YES];
    }

}
-(void)btnMainCLick
{
    if ([ObjectForUser checkLogin])
    {
        __weak OrderDetailViewController *blockSelf = self;
        if ([strOrderState isEqualToString:@"3"])
        {
            [[ObjectForRequest shareObject]requestWithURL:@"index.php/home/order/queren" parameter:@{@"userid":USERID,@"token":TOKEN,@"orderid":self.strOrderID} resultBlock:^(NSDictionary *resultDic) {
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
                    strOrderState = @"4";
                    [blockSelf reloadButtom];
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"确认送达失败，请检查网络连接", @"Confirm  receiving failed, please check the Internet connection") onViewController:blockSelf];
                }
            }];
        }
        else if ([strOrderState isEqualToString:@"4"] || [strOrderState isEqualToString:@"5"])
        {
            MerchantViewController *MVC = [[MerchantViewController alloc]init];
            MVC.shopID = strShopID;
            MVC.userLocation = LOCATION;
            [self.navigationController pushViewController:MVC animated:YES];
        }
    }
   
}
-(void)btnContaceClick
{
    NSMutableString* str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",strShopPhone];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
}
-(void)orderCommentViewControllerSucceed
{
    isFirstTimeIn = YES;
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
