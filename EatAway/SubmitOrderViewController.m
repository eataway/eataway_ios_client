//
//  SubmitOrderViewController.m
//  EatAway
//
//  Created by apple on 2017/6/22.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SubmitOrderViewController.h"

#import "SubmitOrderAddressTableViewCell.h"
#import "SubmitOrderTimeTableViewCell.h"
#import "SubmitOrderListTableViewCell.h"
#import "TeastTableViewCell.h"
#import "SubmitOrderPayTableViewCell.h"



#import "AddressViewController.h"
#import "SelectDelveryTimeViewController.h"
#import "SubmitOrderTasteTViewController.h"
#import "SubmitOrderSelectPayViewController.h"
#import "BraintreeViewController.h"

#import <Braintree/Braintree.h>
#import <MBProgressHUD.h>



@interface SubmitOrderViewController ()<UITableViewDelegate,UITableViewDataSource,SelectDelveryTimeViewControllerDelegate,SubmitOrderTasteTViewControllerDelegate,SubmitOrderSelectPayViewControllerDelegate,AddressViewControllerDelegate,BTDropInViewControllerDelegate>
{
    UITableView *_tableView;
    UIView *viewBottom;
    UILabel *labelTotal;
    UIButton *btnCount1;
    SelectDelveryTimeViewController *SDTVC;
    SubmitOrderTasteTViewController *SOTVC;
    
    NSString *_strAddress;
    NSString *_strName;
    NSString *_strSex;
    NSString *_strPhoneNum;
    
    NSString *_strDeliveryTime;
    
    NSString *_strTips;
    
    NSString *_strPayment;
    NSString *_distance;
    
    NSString *_strLocation;
    
    NSString *strBrainTreeResult;
    
    
    CGFloat freeSendPrice;
    CGFloat freeSendDistance;
    CGFloat maxSendDistance;
    CGFloat priceFor1km;
    CGFloat realDistance;
    CGFloat maxMoney;
    MBProgressHUD *progress;
    

}
@property (nonatomic, strong) Braintree *braintree;

@end


@implementation SubmitOrderViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    self.title = ZEString(@"提交订单", @"Submit Orders");
    _strDeliveryTime = ZEString(@"尽快送达", @"ASAP");
    _strAddress = @"";
    _strName = @"";
    _strSex = @"";
    _strPhoneNum = @"";
    
    _strTips = @"";
    
    //---
//    _strPayment = ZEString(@"货到付款", @"Cash on delivery");
    _strPayment = @"";

    
    strBrainTreeResult = @"";
    _distance = @"";
    _strLocation = @"";
    
    [self tableViewInit];
}
-(void)tableViewInit
{
    UIButton *btnBack = [UIButton buttonWithType:UIButtonTypeCustom];
    btnBack.frame = CGRectMake(4, 20 + 14, 14, 20);
    [btnBack setImage:[UIImage imageNamed:@"Login_back_white1.png"] forState:UIControlStateNormal];
    [btnBack addTarget:self action:@selector(btnItemBackClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc]initWithCustomView:btnBack];
    self.navigationItem.leftBarButtonItem = itemBack;
    
    UIView *viewAboveNavi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 20)];
    viewAboveNavi.backgroundColor = [UIColor colorWithRed:132/255.0 green:220/255.0 blue:4/255.0 alpha:0];
    [self.view addSubview:viewAboveNavi];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//        btnBack.contentHorizontalAlignment =UIControlContentHorizontalAlignmentLeft;
//        [btnBack setImageEdgeInsets:UIEdgeInsetsMake(-20, 0,0,0)];
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    [self.view addSubview:_tableView];
    
    viewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 45, WINDOWHEIGHT, 45)];
    viewBottom.backgroundColor = [UIColor colorWithRed:144/255.0 green:166/255.0 blue:177/255.0 alpha:0.5];
    [self.view addSubview:viewBottom];
    
    labelTotal = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 10 - 120 - 10, 25)];
    labelTotal.textColor = [UIColor whiteColor];
    labelTotal.text = [NSString stringWithFormat:@"%@%.2f",ZEString(@"总金额：$", @"Total：$"),self.totalPriceWithoutPS];
    [viewBottom addSubview:labelTotal];
    
    UIButton *btnCount = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCount.frame = CGRectMake(WINDOWWIDTH - 120, 0, 120, 45);
    btnCount.backgroundColor = [UIColor colorWithRed:1 green:158/255.0 blue:0 alpha:1];
    [btnCount setTitle:ZEString(@"提交订单", @"Place order") forState:UIControlStateNormal];
    [btnCount setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btnCount.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnCount addTarget:self action:@selector(btnSubmitOrderClick) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:btnCount];
    btnCount1 = btnCount;
    
    

}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 5)
    {
        return 10;
    }
    else if(indexPath.row == 1)
    {
        return 80;
    }
    else if(indexPath.row == 2 || indexPath.row == 6|| indexPath.row == 7)
    {
        return 50;
    }
    else if(indexPath.row == 4)
    {
        UITableViewCell *cell = [self tableView:_tableView cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else if(indexPath.row == 8)
    {
        return 100;
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0 || indexPath.row == 3 || indexPath.row == 5)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell035"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell035"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
        }
        
    }
    else if (indexPath.row == 1)
    {
        SubmitOrderAddressTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
        if (!cell0)
        {
            cell0 = [[SubmitOrderAddressTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell01"];
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        if (_strAddress.length <= 0)
        {
            [cell0 setContentWithAddress:ZEString(@"请选择收货地址", @"Please select a shipping address") name:@"" sex:@"" phoneNum:@""];
        }
        else
        {
            [cell0 setContentWithAddress:_strAddress name:_strName sex:_strSex phoneNum:_strPhoneNum];
        }
        cell = cell0;
        
    }
    else if (indexPath.row == 2)
    {
        SubmitOrderTimeTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        if (!cell0)
        {
            cell0 = [[SubmitOrderTimeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        [cell0 setContentWithTime:_strDeliveryTime];
        cell = cell0;
        
    }
    else if (indexPath.row == 4)
    {
        SubmitOrderListTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell04"];
        if (!cell0)
        {
            cell0 = [[SubmitOrderListTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell04"];
            
        }
        [cell0 setContentWithHeadImage:self.strHeadImageURL title:self.strShopName listDic:self.dicOrder totalPrice:[NSString stringWithFormat:@"%.2f",self.totalPriceWithoutPS]];

        cell = cell0;
        
    }
    else if (indexPath.row == 6)
    {
        TeastTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell06"];
        if (!cell0)
        {
            cell0 = [[TeastTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell06"];
        }
        cell0.detailLabelThis.text = _strTips;
        cell = cell0;
    }
    else if (indexPath.row == 7)
    {
        SubmitOrderPayTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell07"];
        if (!cell0)
        {
            cell0 = [[SubmitOrderPayTableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell07"];
            cell0.detailTextLabel.textColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            //---
            cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }

        cell0.detailLabelThis.text = _strPayment;
        cell = cell0;
        
    }
    else if(indexPath.row == 8)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell08"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell08"];
            cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
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
    if (indexPath.row == 1)
    {
        AddressViewController *AVC = [[AddressViewController alloc]init];
        AVC.strTitle = ZEString(@"选择收货地址", @"Address");
        AVC.delegate = self;
        AVC.isSelectAddress = YES;
        [self.navigationController pushViewController:AVC animated:YES];
    }
    else if (indexPath.row == 2)
    {
        SDTVC = [[SelectDelveryTimeViewController alloc]init];
        SDTVC.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:SDTVC.view];
    }
    else if (indexPath.row == 6)
    {
        SOTVC = [[SubmitOrderTasteTViewController alloc]init];
        SOTVC.delegate = self;
        [[UIApplication sharedApplication].keyWindow addSubview:SOTVC.view];
        
    }
    //---
    else if (indexPath.row == 7)
    {
        SubmitOrderSelectPayViewController *SOSPVC = [[SubmitOrderSelectPayViewController alloc]init];
        SOSPVC.delegate = self;
        [self.navigationController pushViewController:SOSPVC animated:YES];
        
    }

}
-(void)addressViewControllerSelectAddressWithDictionary:(NSDictionary *)dicAddress
{
    SubmitOrderAddressTableViewCell *cell0 = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    
    if (ISCHINESE)
    {
        _strAddress = [NSString stringWithFormat:@"%@ %@",dicAddress[@"location_address"],dicAddress[@"detailed_address"]];
    }
    else
    {
        _strAddress = [NSString stringWithFormat:@"%@ %@",dicAddress[@"detailed_address"],dicAddress[@"location_address"]];

    }
    _strSex = dicAddress[@"gender"];
    _strPhoneNum = dicAddress[@"mobile"];
    _strName = dicAddress[@"real_name"];
    _strLocation = dicAddress[@"coordinate"];
    
    
    
    
    [cell0 setContentWithAddress:_strAddress name:_strName sex:_strSex phoneNum:_strPhoneNum];
    __weak SubmitOrderViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/shop/jisuan" parameter:@{@"coordinate":_strLocation,@"shopid":_strShopID} resultBlock:^(NSDictionary *resultDic)
    {
        [progress hide:YES];
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"验证收货地址失败，请检查网络连接", @"Verify the address failed, please check the network connection") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(1)])
        {
            NSDictionary *dic = resultDic[@"msg"];
            //超过面配送费
            freeSendPrice = [dic[@"maxprice"] floatValue];
    
            
            //maxlong  的千米内 需要Maxmoney这么多的配送费
            freeSendDistance = [dic[@"maxlong"] floatValue];
           
            
            if ( freeSendDistance < 0) {
                 maxMoney =0;
            }else{
                 maxMoney = [dic[@"maxmoney"] floatValue];
            }
            
            //最大配送距离
            maxSendDistance = [dic[@"long"] floatValue];
            
            //NSString *priceFor1 = dic[@"lkmoney"] ;
            //每千米多少钱
            priceFor1km = [dic[@"lkmoney"] floatValue];
            
           
            
            //距离
            realDistance = [dic[@"juli"] floatValue];
            
            
            self.PSFee = realDistance * priceFor1km;
            //realDistance = [self  roundFloat:realDistance];
            
            [blockSelf reloadPSFee];
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"验证收货地址失败，请检查网络连接", @"Verify the address failed, please check the network connection") onViewController:blockSelf];

        }
    }];
    
    
}
-(void)reloadPSFee
{
    
    if (realDistance > maxSendDistance) {
        
         self.totalPrice = self.totalPriceWithoutPS;
        
        SubmitOrderListTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
        [cell setPSFee:[NSString stringWithFormat:@"%@",ZEString(@"超出配送", @"out of distance")] distance:[NSString stringWithFormat:@"%.1fkm",(int)(realDistance * 10)/10.0] totalPrice:[NSString stringWithFormat:@"%.2f",self.totalPrice]];
//        labelTotal.text = [NSString stringWithFormat:@"%@%.2f",ZEString(@"总金额：$", @"Total：$"),self.totalPriceWithoutPS];
        labelTotal.text = @"";
        
//        [btnCount1 setTitle:ZEString(@"不能支付", @"Can't pay") forState:UIControlStateNormal];
        
        btnCount1.titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        
        btnCount1.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1.0];
        btnCount1.userInteractionEnabled = NO;
        return;
    
    }
    
    
    
     if(freeSendPrice >= 0  && self.totalPriceWithoutPS >= freeSendPrice)
    {
        self.PSFee = 0.00;
        
        self.totalPrice = self.totalPriceWithoutPS + self.PSFee;

       //  self.totalPrice = [self roundFloat:self.totalPrice];
    }
    else if (freeSendDistance > 0 && realDistance <= freeSendDistance)
    {
        self.PSFee = maxMoney;
        
        self.totalPrice = self.totalPriceWithoutPS + self.PSFee;

      //  self.totalPrice = [self roundFloat:self.totalPrice];
    }
    
    

    else
    {
        CGFloat freeDis = freeSendDistance <= 0 ? 0 : freeSendDistance;
        
        CGFloat aaa = realDistance  - freeDis;
        //aaa = [self roundFloat:aaa];
        
        self.PSFee = aaa * priceFor1km + maxMoney;
        
       // self.PSFee = [self roundFloat:self.PSFee];
        
        self.totalPrice = self.totalPriceWithoutPS + self.PSFee;
        
       
    }
    
    self.totalPrice = self.totalPriceWithoutPS + self.PSFee;
    SubmitOrderListTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:4 inSection:0]];
    [cell setPSFee:[NSString stringWithFormat:@"%.2f",self.PSFee] distance:[NSString stringWithFormat:@"%.2fkm",realDistance] totalPrice:[NSString stringWithFormat:@"%.2f",self.totalPrice]];
    
    labelTotal.text = [NSString stringWithFormat:@"%@%.2f",ZEString(@"总金额：$", @"Total：$"),self.totalPrice];
    
    
    
}

-(void)SelectDelveryTimeViewControllerResultTime:(NSString *)strResult
{
    SubmitOrderTimeTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    _strDeliveryTime = strResult;
    [cell setContentWithTime:strResult];
}
-(void)SubmitOrderTasteTViewControllerResult:(NSString *)strResult
{
    TeastTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:6 inSection:0]];
    cell.detailLabelThis.text = strResult;
    _strTips = strResult;
}
-(void)SubmitOrderSelectPayViewControllerSelectResult:(NSString *)strResult
{
    SubmitOrderPayTableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:7 inSection:0]];
    _strPayment = strResult;
    cell.detailLabelThis.text = strResult;

    
}
-(void)btnSubmitOrderClick
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else if (_strAddress.length <= 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请选择收货地址", @"Please choose Shipping address") onViewController:self];
    }
    else if (_strPayment.length <= 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请选择支付方式", @"Please choose payment method") onViewController:self];
    }
    else
    {
        
        if ([_strPayment isEqualToString:@"银行卡支/Paypa"] || [_strPayment isEqualToString:@"Bank card/Paypal"])
        {
            
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            [[ObjectForRequest shareObject] requestGetWithFullURL:[NSString stringWithFormat:@"%@/%@",HTTPHOST,@"index.php/home/order/brtoken"] resultBlock:^(NSDictionary *resultDic) {
                [progress hide:YES];
                if (resultDic!= nil)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"token"] forKey:@"braintreetoken"];
                    self.braintree = [Braintree braintreeWithClientToken:BRAINTREETOKEN];
                    
                    BTDropInViewController *dropInViewController = [self.braintree dropInViewControllerWithDelegate:self];
                 
                    dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(userDidCancelPayment)];
                    
                    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dropInViewController];
                    [self presentViewController:navigationController animated:YES completion:nil];
                    
                    
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"braintreetoken"];
                }
            }];

        }
        else
        {
            [self sendTheOrderWithParamExtra:@{} url:@"index.php/home/order/haddorder"];
        }
        
    }
//    BraintreeViewController *BVC = [[BraintreeViewController alloc]init];
//    [self.navigationController pushViewController:BVC animated:YES];
}

-(void)sendTheOrderWithParamExtra:(NSDictionary *)dicExtra url:(NSString *)strURL
{
    NSMutableDictionary *paramDic = [[NSMutableDictionary alloc]init];
    NSArray *arrKeys = self.dicOrder.allKeys;
    
    for (NSInteger a = 0; a < arrKeys.count; a ++)
    {
        NSString *strKey = arrKeys[a];
        NSDictionary *dicFoodDetails =self.dicOrder[strKey];
        NSString *strFoodCount = dicFoodDetails[@"count"];
        [paramDic setValue:strKey forKey:[NSString stringWithFormat:@"goods[%ld][0]",a]];
        [paramDic setValue:strFoodCount forKey:[NSString stringWithFormat:@"goods[%ld][1]",a]];
        
    }
    
    [paramDic setValue:self.strShopID forKey:@"shopid"];
    [paramDic setValue:[NSString stringWithFormat:@"%.2f",self.PSFee] forKey:@"money"];
    [paramDic setValue:USERID forKey:@"userid"];
    [paramDic setValue:_strDeliveryTime forKey:@"cometime"];
    [paramDic setValue:[NSString stringWithFormat:@"%.2f",realDistance] forKey:@"juli"];
    [paramDic setValue:_strAddress forKey:@"address"];
    [paramDic setValue:_strName forKey:@"name"];
    [paramDic setValue:_strSex forKey:@"sex"];
    [paramDic setValue:_strPhoneNum forKey:@"phone"];
    [paramDic setValue:_strTips forKey:@"beizhu"];
    [paramDic setValue:TOKEN forKey:@"token"];
    [paramDic setValue:[NSString stringWithFormat:@"%.2f",self.totalPrice] forKey:@"allprices"];
    [paramDic setValuesForKeysWithDictionary:dicExtra];
    
    __weak SubmitOrderViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
    [[ObjectForRequest shareObject] requestWithURL:strURL parameter:paramDic resultBlock:^(NSDictionary *resultDic) {
        [progress hide:YES];
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"支付失败，请检查网络连接", @"Payment failed, please check the network connection") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(1)])
        {
            [TotalFunctionView alertAndDismissWithContent:ZEString(@"您的订单已提交", @"Your order has been submitted") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(9)])
        {
            ALERTCLEARLOGINBLOCK
        }
        else if([resultDic[@"status"] isEqual:@(0)])
        {
            [TotalFunctionView alertContent:ZEString(@"商品价格变化，请尝试刷新并重新下单", @"Price changes, please try to refresh and reorder") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(5)])
        {
            [TotalFunctionView alertContent:ZEString(@"超出最大配送距离", @"Exceeding the maximum distribution distance") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(4)])
        {
            [TotalFunctionView alertContent:ZEString(@"商户未营业，请刷新您的首页列表", @"Merchant not open.Please refresh your home list") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(66)])
        {
            [TotalFunctionView alertContent:ZEString(@"商户未营业，请刷新您的首页列表", @"Merchant not open.Please refresh your home list") onViewController:blockSelf];
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"支付失败，请检查网络连接", @"Payment failed, please check the network connection") onViewController:blockSelf];
        }
        
    }];

}
//braintree delegate
- (void)dropInViewController:(__unused BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod
{
    NSLog(@"PostContent = %@",paymentMethod.nonce);
    strBrainTreeResult = paymentMethod.nonce;
    [self dismissViewControllerAnimated:YES completion:nil];

    [self sendTheOrderWithParamExtra:@{@"nonce":strBrainTreeResult} url:@"index.php/home/order/addorder"];

    
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)userDidCancelPayment
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


-(void)btnItemBackClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



//-(float)roundFloat:(float)price{
//    NSString *temp = [NSString stringWithFormat:@"%.7f",price];
//    NSDecimalNumber *numResult = [NSDecimalNumber decimalNumberWithString:temp];
//    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
//                                       decimalNumberHandlerWithRoundingMode:NSRoundBankers
//                                       scale:2
//                                       raiseOnExactness:NO
//                                       raiseOnOverflow:NO
//                                       raiseOnUnderflow:NO
//                                       raiseOnDivideByZero:YES];
//    return [[numResult decimalNumberByRoundingAccordingToBehavior:roundUp] floatValue];
//}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
