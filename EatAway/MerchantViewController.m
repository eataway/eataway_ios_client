//
//  MerchantViewController.m
//  EatAway
//
//  Created by apple on 2017/6/20.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantViewController.h"

#import "MerchantFoodTableViewCell.h"
#import "MerchantCommentTableViewCell.h"
#import "MerchantInfoTableViewCell.h"
#import "MerchantInfoFirstTableViewCell.h"
#import "UINavigationBar+add.h"
#import "FoodDetailViewController.h"

#import "GoogleOnlyMapViewController.h"


#import "MerchantCartViewController.h"

#import "SubmitOrderViewController.h"

#import <UIImageView+WebCache.h>
#import <MBProgressHUD.h>
#import <MJRefresh.h>



@interface MerchantViewController ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate,MerchantFoodTableViewCellDelegate,MerchantCartViewControllerDelegate,FoodDetailViewControllerDelegate>
{
    //支付按钮
    UIButton *payBtn;
    
    //主要tableView
    UITableView *_tableView;
    //食物类型
    UITableView *TVKind;
    //菜单
    UITableView *TVFood;
    //评论
    UITableView *TVComment;
    //商户信息
    UITableView *TVInfo;
    //低栏
    UIView *viewBottom;
    //商品详情
    FoodDetailViewController *FDVC;
    //商品详情<
    UIButton *btnHideFoodDetail;
    //商品详情图
    UIImageView *IVFoodDetail;
    //食物数量
    UILabel *labelFoodAllCount;
    //商户头像
    NSString *strHeadImage;
    //ScrollView
    UIScrollView *SV;
    //商户主图
    UIImageView *IVMerchant;
    //顶部Navi样式
    UIView *viewAboveNavi;
    MerchantCartViewController *MerchantCartVC;
    
    //配送费
    UILabel *labelPeisong;
    //总价
    UILabel *labelTotalPrice;
    //提示评论为空
    UILabel *labelCommentEmpty;
    //食物种类按钮
    NSMutableArray *arrKindBtns;
    //食物种类
    NSMutableArray *arrOrderKind;
    //商户名
    NSString *_strShopName;
    //当前种类index
    NSInteger orderKindIndex;
    //页面index
    NSInteger pageIndex;
    
    CGFloat PSFee;
    CGFloat _totalPrice;
    CGFloat _totalPriceWithOutPS;
    CGFloat currentHeight;
    BOOL isFirstTimeIn;
    
    NSDictionary *dicShopInfo;
    NSMutableArray *arrComments;
    
    CGFloat freeSendPrice;
    CGFloat freeSendDistance;
    CGFloat maxSendDistance;
    CGFloat priceFor1km;
    CGFloat realDistance;
    CGFloat lmoney;

    MBProgressHUD *progress;
    MJRefreshAutoStateFooter *footer;
    MJRefreshStateHeader *header;
    
    NSNumber *page;
    NSString *shopOpen;

}

@end

@implementation MerchantViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    arrKindBtns = [[NSMutableArray alloc]init];
    arrOrderKind = [[NSMutableArray alloc]init];
    orderKindIndex = 0;
    pageIndex = 0;
    PSFee = 0.00;
    page = @(1);
    shopOpen = @"";
    self.dicForSelectedFood = [[NSMutableDictionary alloc]init];
    isFirstTimeIn = YES;
    arrComments = [[NSMutableArray alloc]init];

    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [self tableViewInit];
}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:@"100"];
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    __weak MerchantViewController *blockSelf = self;
    if (isFirstTimeIn)
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view  animated:YES];
        NSString *strLoca ;
        if (self.userLocation == nil)
        {
            strLoca = @"";
        }
        else
        {
            strLoca = self.userLocation;
        }
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/shop/menulist" parameter:@{@"shopid":self.shopID,@"coor": strLoca} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"获取商户信息失败，请检查网络连接", @"Failed to get merchant information, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                NSDictionary *dicShopMsg = resultDic[@"msg"];
                dicShopInfo = dicShopMsg;
                shopOpen = dicShopMsg[@"state"];
                freeSendPrice = [dicShopMsg[@"maxprice"] floatValue];
                freeSendDistance = [dicShopMsg[@"maxlong"] floatValue];
                maxSendDistance = [dicShopMsg[@"long"] floatValue];
                priceFor1km = [dicShopMsg[@"lkmoney"] floatValue];
                realDistance = [dicShopMsg[@"juli"] floatValue];
                
                if (NULLString(dicShopMsg[@"lmoney"])) {
                    lmoney = 0.0;
                }else{
                    lmoney =  [dicShopMsg[@"lmoney"] floatValue];
                    
                }
                
                
            
            
                
                [blockSelf reloadPSFee];

                _strShopName = dicShopMsg[@"shopname"];
                strHeadImage = dicShopMsg[@"shophead"];
                [IVMerchant sd_setImageWithURL:[NSURL URLWithString:dicShopMsg[@"shopphoto"]] placeholderImage:[UIImage imageNamed:@"placeholder2.png"]];
                [arrComments removeAllObjects];
                [arrComments addObjectsFromArray:dicShopMsg[@"userspingjia"]];
                if (arrComments.count > 0)
                {
                    page = @(2);
                }
                if (arrComments.count > 0)
                {
                    labelCommentEmpty.hidden = YES;
                }
                else
                {
                    labelCommentEmpty.hidden = NO;
                }
                
                NSArray *arrFoodList = dicShopMsg[@"shopmessage"];
                [arrOrderKind removeAllObjects];
                [arrOrderKind addObjectsFromArray:arrFoodList];
                
                self.title = dicShopMsg[@"shopname"];
                [TVKind reloadData];
                [TVFood reloadData];
                [TVInfo reloadData];
                [TVComment reloadData];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"获取商户信息失败，请检查网络连接", @"Failed to get merchant information, please check the network connection") onViewController:blockSelf];
            }
        }];
        isFirstTimeIn = NO;
    }
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [_tableView removeObserver:self forKeyPath:@"contentOffset"];


}
-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [self setNavigationBarAlpha:0];
    
}
-(void)setNavigationBarAlpha:(CGFloat)alpha
{
    if (alpha == 1)
    {
        alpha = 0.99;
    }
    
    
    self.navigationController.navigationBar.translucent = YES;
    
    UIColor *color = [UIColor colorWithRed:132/255.0 green:220/255.0 blue:4/255.0 alpha:alpha];
//    UIColor *color = [UIColor redColor];

    CGRect rect = CGRectMake(0.0f, 0.0f, WINDOWWIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
    viewAboveNavi.backgroundColor = color;
    
}
//计算配送费
-(void)reloadPSFee
{
    if (LOCATION == nil || [LOCATION isEqualToString:@""])
    {
        if(self.view.frame.size.width <= 320)
        {
          //  labelPeisong.text = ZEString(@"暂时无法计算", @"Can't calculate");
        }
        else
        {
//            labelPeisong.text = ZEString(@"未选择位置无法计算配送费", @"No location for calculating delivery fee");
        }
    }
    else
    {
        if(freeSendDistance > 0 && realDistance <= freeSendDistance)
        {
            PSFee = 0.00;
        }
        else if (freeSendPrice > 0 && _totalPriceWithOutPS >= freeSendPrice)
        {
            PSFee = 0.00;
        }
        else
        {
            CGFloat freeDis = freeSendDistance < 0 ? 0 : freeSendDistance;
            PSFee = (int)((realDistance  - freeDis) * 10 )/10.0 * priceFor1km;
        }
        
        
//        labelPeisong.text = [NSString stringWithFormat:@"%@:$%.2f",ZEString(@"配送费", @"Delivery fee"),PSFee];

    }
}
-(void)reloadCommentTV
{
    __weak MerchantViewController *blockSelf = self;
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/evaluate/pingjialist" parameter:@{@"page":page,@"shopid":self.shopID} resultBlock:^(NSDictionary *resultDic) {
        if (footer.isRefreshing)
        {
            [footer endRefreshing];
        }
        if (header.isRefreshing)
        {
            [header endRefreshing];
        }
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"获取评论失败，请检查网络连接", @"Get comment list failed, please check the network connection") onViewController:blockSelf];
        }
        else if([resultDic[@"status"] isEqual:@(1)])
        {
            NSArray *arr = resultDic[@"msg"][@"userspingjia"];
            if (arr.count > 0)
            {
                page = @([page integerValue] + 1);
                
                [arrComments addObjectsFromArray:arr];
            }
            if (arrComments.count > 0)
            {
                labelCommentEmpty.hidden = YES;
            }
            else
            {
                labelCommentEmpty.hidden = NO;
            }
            [TVComment reloadData];
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"获取评论失败，请检查网络连接", @"Get comment list failed, please check the network connection") onViewController:blockSelf];
        }
    }];
}
-(void)tableViewInit
{
    
    //主要TableView
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.bounces = NO;
    _tableView.tag = 100;
    [self.view addSubview:_tableView];
    
    viewAboveNavi = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 20)];
    viewAboveNavi.backgroundColor = [UIColor colorWithRed:132/255.0 green:220/255.0 blue:4/255.0 alpha:0];
    [self.view addSubview:viewAboveNavi];
    
    _tableView.estimatedRowHeight = 0;
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        _tableView.contentInset = UIEdgeInsetsMake(0, 0, 49, 0);
        _tableView.scrollIndicatorInsets = _tableView.contentInset;
    }
    else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    //食物类型TableView
    TVKind = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH * 170/750, WINDOWHEIGHT - 64 - 45) style:UITableViewStylePlain];
    TVKind.delegate = self;
    TVKind.dataSource = self;
    TVKind.tag = 1;
    TVKind.separatorStyle = UITableViewCellSeparatorStyleNone;
    TVKind.showsVerticalScrollIndicator = NO;
    TVKind.scrollEnabled = NO;
    
    //食物TableView
    TVFood = [[UITableView alloc]initWithFrame:CGRectMake(WINDOWWIDTH * 170/750,0 , WINDOWWIDTH * (1 -170/750), WINDOWHEIGHT - 64 - 45 ) style:UITableViewStylePlain];
    TVFood.delegate = self;
    TVFood.dataSource = self;
    TVFood.tag = 2;
    TVFood.separatorStyle = UITableViewCellSeparatorStyleNone;
    TVFood.scrollEnabled = NO;

    //评论TableView
    TVComment = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , WINDOWWIDTH, WINDOWHEIGHT - 64 - 45) style:UITableViewStylePlain];
    TVComment.delegate = self;
    TVComment.dataSource = self;
    TVComment.tag = 3;
    TVComment.separatorStyle = UITableViewCellSeparatorStyleNone;
    TVComment.scrollEnabled = NO;
    
    //空结果label
    labelCommentEmpty = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 40)];
    labelCommentEmpty.backgroundColor = [UIColor whiteColor];
    labelCommentEmpty.textAlignment = NSTextAlignmentCenter;
    labelCommentEmpty.font = [UIFont systemFontOfSize:13];
    labelCommentEmpty.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    labelCommentEmpty.text = ZEString(@"未查询到结果", @"No results found");
    [TVComment addSubview:labelCommentEmpty];
    labelCommentEmpty.hidden = YES;
    
    
    __weak MerchantViewController *blockSelf = self;
    footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf reloadCommentTV];
    }];
    footer.refreshingTitleHidden = YES;
    [footer setTitle:ZEString(@"上拉加载更多", @"Get More information") forState:MJRefreshStateIdle];
    [footer setTitle:ZEString(@"松开进行加载", @"Release the load")  forState:MJRefreshStatePulling];
    [footer setTitle:ZEString(@"加载中", @"Loading") forState:MJRefreshStateRefreshing];
    [footer setTitle:ZEString(@"暂无更多数据", @"No more data") forState:MJRefreshStateNoMoreData];
    
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [arrComments removeAllObjects];
        [TVComment reloadData];
        page = @(1);
        [blockSelf reloadCommentTV];
        
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;

    header.stateLabel.hidden = YES;
    TVComment.mj_header = header;
    TVComment.mj_footer = footer;
    
    //商户信息TableView
    TVInfo = [[UITableView alloc]initWithFrame:CGRectMake(0,0 , WINDOWWIDTH, WINDOWHEIGHT - 64 - 45) style:UITableViewStylePlain];
    TVInfo.delegate = self;
    TVInfo.dataSource = self;
    TVInfo.tag = 4;
    TVInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    TVInfo.scrollEnabled = NO;
    
    //商品详情页
    IVFoodDetail = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWWIDTH * 400/750)];
    IVFoodDetail.hidden = YES;
    IVFoodDetail.clipsToBounds = YES;
    IVFoodDetail.userInteractionEnabled = YES;
    IVFoodDetail.contentMode = UIViewContentModeScaleAspectFill;
    [[UIApplication sharedApplication].keyWindow addSubview:IVFoodDetail];

    btnHideFoodDetail = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHideFoodDetail.frame = CGRectMake(0, 20, 50, 55);
    btnHideFoodDetail.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 15, 20);
//    btnHideFoodDetail.backgroundColor = [UIColor redColor];
    [btnHideFoodDetail setImage:[UIImage imageNamed:@"Login_back_white1.png"] forState:UIControlStateNormal];
    [btnHideFoodDetail addTarget:self action:@selector(btnHideFoodDetailCLick) forControlEvents:UIControlEventTouchUpInside];
    btnHideFoodDetail.hidden = YES;
    [IVFoodDetail addSubview:btnHideFoodDetail];
    
    FDVC = [[FoodDetailViewController alloc]init];
    FDVC.delegate = self;
    FDVC.view.frame = CGRectMake(0, WINDOWWIDTH * 400/750, WINDOWWIDTH, WINDOWHEIGHT);
    [self.view addSubview:FDVC.view];
    FDVC.view.hidden = YES;
    
    
    //购物车
    MerchantCartVC = [[MerchantCartViewController alloc]init];
    MerchantCartVC.delegate = self;
    MerchantCartVC.view.hidden = YES;
    [self.view addSubview:MerchantCartVC.view];
    
    //低栏View
    viewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 45, WINDOWHEIGHT, 45)];
    viewBottom.backgroundColor = [UIColor colorWithRed:144/255.0 green:166/255.0 blue:177/255.0 alpha:0.8];
    [self.view addSubview:viewBottom];
    
    UIButton *btnList = [UIButton buttonWithType:UIButtonTypeCustom];
    btnList.frame = CGRectMake(20, -5, 50, 50);
    [btnList setImage:[UIImage imageNamed:@"2.2.0_icon_shopping.png"] forState:UIControlStateNormal];
    [btnList addTarget:self action:@selector(btnListClick) forControlEvents:UIControlEventTouchUpInside];
    [viewBottom addSubview:btnList];
    
    labelFoodAllCount = [[UILabel alloc]initWithFrame:CGRectMake(50, -10, 26, 26)];
    labelFoodAllCount.backgroundColor = [UIColor orangeColor];
    labelFoodAllCount.font = [UIFont systemFontOfSize:10];
    labelFoodAllCount.textColor = [UIColor whiteColor];
    [viewBottom addSubview:labelFoodAllCount];
    labelFoodAllCount.text = @"0";
    labelFoodAllCount.clipsToBounds = YES;
    labelFoodAllCount.layer.cornerRadius = 11;
    labelFoodAllCount.textAlignment = NSTextAlignmentCenter;
    labelFoodAllCount.center = labelFoodAllCount.center;
    labelFoodAllCount.bounds = CGRectMake(0, 0,22, 22);

    labelTotalPrice = [[UILabel alloc]initWithFrame:CGRectMake(20 + 50 + 20, 3, WINDOWWIDTH - (20 + 50 + 20 + 120 + 10), 17)];
    labelTotalPrice.textColor = MAINCOLOR;
    labelTotalPrice.font = [UIFont systemFontOfSize:15];
    labelTotalPrice.text = [NSString stringWithFormat:@"%@:$0",ZEString(@"总价", @"Total")];
    [viewBottom addSubview:labelTotalPrice];
    
    labelPeisong = [[UILabel alloc]initWithFrame:CGRectMake(20 + 50 + 20, 20, WINDOWWIDTH - (20 + 50 + 20 + 120 + 10), 25)];
    labelPeisong.textColor = [UIColor whiteColor];
    labelPeisong.font = [UIFont systemFontOfSize:11];
    labelPeisong.numberOfLines = 2;
    
    //labelPeisong.text = [NSString stringWithFormat:@"%@:$%.2f",ZEString(@"配送费", @"Delivery fee"),PSFee];
    
    labelPeisong.text = ZEString(@"购物车为空", @"Shopping cart is empty") ;
    
    //[self refreshTotalPrice];
    [viewBottom addSubview:labelPeisong];
    
    UIButton *btnCount = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCount.frame = CGRectMake(WINDOWWIDTH - 120, 0, 120, 45);
    [btnCount setTitle:ZEString(@"去结算", @"Checkout") forState:UIControlStateNormal];
    btnCount.titleLabel.font = [UIFont systemFontOfSize:13];
    //btnCount.titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
    
    [btnCount setTitleColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.3] forState:UIControlStateNormal];
    btnCount.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1.0];
    btnCount.layer.borderWidth = 0.3;
    [btnCount addTarget:self action:@selector(btnSubmitOrderClick) forControlEvents:UIControlEventTouchUpInside];
    btnCount.userInteractionEnabled = NO;
    [viewBottom addSubview:btnCount];
    payBtn  = btnCount;
    

    
    
    
}
//改变透明度
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    if ([(__bridge NSString *)context isEqual:@"100"])
    {

    CGFloat naviBarAlpha = 0;
    if (_tableView.contentOffset.y  == 0)
    {
        naviBarAlpha = 0;
        
    }
    else if (_tableView.contentOffset.y + 0.5 >= WINDOWWIDTH * 400/750 - 64)
    {
        naviBarAlpha = 1;
        TVComment.scrollEnabled = YES;
        TVKind.scrollEnabled = YES;
        TVFood.scrollEnabled = YES;
        TVInfo.scrollEnabled = YES;

    }
    else
    {
        naviBarAlpha = _tableView.contentOffset.y/(WINDOWWIDTH * 400/750 - 64);

    }
    [self setNavigationBarAlpha:naviBarAlpha];

    }

    if (_tableView.contentOffset.y + 0.5 < WINDOWWIDTH * 400/750 - 64) {
        TVFood.scrollEnabled = NO;
        TVKind.scrollEnabled = NO;
        TVComment.scrollEnabled = NO;
        TVInfo.scrollEnabled = NO;
        _tableView.scrollEnabled = YES;
    }
    else
    {
        TVKind.scrollEnabled = YES;
        TVFood.scrollEnabled = YES;
        TVComment.scrollEnabled = YES;
        TVInfo.scrollEnabled = YES;
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView.tag == 2)
    {
        return arrOrderKind.count;
    }
    else
    {
        return 1;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100)
    {
        return 3;
    }
    else if (tableView.tag == 1)
    {
        return arrOrderKind.count + 1;
    }
    else if (tableView.tag == 2)
    {
        if (section == arrOrderKind.count - 1 )
        {
            return [arrOrderKind[section][@"goods"] count] + 1;
        }
        else
        {
            return [arrOrderKind[section][@"goods"] count];
        }
    }
    else if (tableView.tag == 3)
    {
        return arrComments.count;
    }
    else if (tableView.tag == 4)
    {
        return 6;
    }
    else
    {
        return 0;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100)
    {
        if (indexPath.row == 0)
        {
            return WINDOWWIDTH * 400/750;
        }
        else if (indexPath.row == 1)
        {
            return 45;
        }
        else if(indexPath.row == 2)
        {
            return WINDOWHEIGHT - 64 - 45;
        }
        else
        {
            return 0;
        }
    }
    else if (tableView.tag == 1)
    {
        return 55;
    }
    else if (tableView.tag == 2)
    {
        return 80;
    }
    else if (tableView.tag == 3)
    {
        UITableViewCell *cell = [self tableView:TVComment cellForRowAtIndexPath:indexPath];
        return cell.frame.size.height;
    }
    else if (tableView.tag == 4)
    {
        if (indexPath.row == 0 || indexPath.row == 2)
        {
            return 10;
        }
        else if (indexPath.row == 1)
        {
            UITableViewCell *cell = [self tableView:TVInfo cellForRowAtIndexPath:indexPath];
            return cell.frame.size.height;
        }
        else
        {
            return 50;
        }
    }
    else
    {
        return 0;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (tableView.tag == 100)
    {
        if (indexPath.row == 0)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
                IVMerchant = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWWIDTH * 400/750)];
                IVMerchant.contentMode = UIViewContentModeScaleAspectFill;
                IVMerchant.clipsToBounds = YES;
                IVMerchant.image = [UIImage imageNamed:@"placehoder2.png"];
                [cell addSubview:IVMerchant];
            }
            
        }
        else if (indexPath.row == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell01"];
                NSArray *arrTitle = @[ZEString(@"点餐", @"Order"),ZEString(@"评价",@"Reviews"),ZEString(@"商家",@"About us")];
                for (int a = 0; a < 3; a ++)
                {
                    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                    btn.frame = CGRectMake(a * WINDOWWIDTH/3, 0, WINDOWWIDTH/3, 45);
                    [btn setTitle:arrTitle[a] forState:UIControlStateNormal];
                    btn.titleLabel.font = [UIFont systemFontOfSize:15];
                    [btn addTarget:self action:@selector(btnWhiteBtnClick:) forControlEvents:UIControlEventTouchUpInside];
                    if (a == 0)
                    {
                        [btn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
                    }
                    else
                    {
                        [btn setTitleColor:[UIColor colorWithWhite:153/255.0 alpha:1] forState:UIControlStateNormal];
                    }
                    btn.tag = a;
                    [cell addSubview:btn];
                    [arrKindBtns addObject:btn];
                    
                }
                
                UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 43, WINDOWWIDTH, 2)];
                viewDown.backgroundColor = [UIColor colorWithWhite:238/255.0 alpha:1];
                [cell addSubview:viewDown];
                
            }
            
        }
        else if (indexPath.row == 2)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
               
                [cell addSubview:TVKind];
                [cell addSubview:TVFood];
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

    }
    else if (tableView.tag == 1)
    {
        if (indexPath.row == arrOrderKind.count)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell)
            {
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
        }
        else
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"celltag1"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celltag1"];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
                cell.textLabel.font = [UIFont systemFontOfSize:13];
                cell.textLabel.numberOfLines = 2;
            }
            if (indexPath.row == orderKindIndex)
            {
                cell.backgroundColor = [UIColor whiteColor];
                cell.textLabel.textColor = MAINCOLOR;
            }
            else
            {
                cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
                cell.textLabel.textColor = [UIColor blackColor];
            }
            NSDictionary *dic = arrOrderKind[indexPath.row];
            cell.textLabel.text = dic[@"cname"];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    else if (tableView.tag == 2)
    {
        if (indexPath.section == arrOrderKind.count - 1 && indexPath.row == ([[arrOrderKind lastObject][@"goods"] count]) )
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
        }
        else
        {
            MerchantFoodTableViewCell *cell0;
            cell0 = [tableView dequeueReusableCellWithIdentifier:@"celltag2"];
            if (!cell0)
            {
                cell0 = [[MerchantFoodTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celltag2"];
                cell0.selectionStyle = UITableViewCellSelectionStyleNone;
                cell0.delegate = self;
            }
            NSDictionary *dicKind = arrOrderKind[indexPath.section];
            NSArray *arrFoods = dicKind[@"goods"];
            NSDictionary *dicFood = arrFoods[indexPath.row];
            NSString *strFoodID = dicFood[@"goodsid"];
            NSString *strSaling = dicFood[@"flag"];
            NSArray *arrSeleceIDs = self.dicForSelectedFood.allKeys;
            
            if ([arrSeleceIDs containsObject:strFoodID])
            {
                NSDictionary *dic = self.dicForSelectedFood[strFoodID];
                [cell0 setContentWithTitle:dic[@"name"] image:dic[@"image"] num:dic[@"count"] price:dic[@"price"] foodID:strFoodID saling:@"1"];
            }
            else
            {
                [cell0 setContentWithTitle:dicFood[@"goodsname"] image:dicFood[@"goodsphoto"] num:@"0" price:dicFood[@"goodsprice"] foodID:strFoodID saling:strSaling];
            }
            cell = cell0;
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

    }
    else if (tableView.tag == 3)
    {
        MerchantCommentTableViewCell *cell0;
        cell0 = [tableView dequeueReusableCellWithIdentifier:@"celltag3"];
        if (!cell0)
        {
            cell0 = [[MerchantCommentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celltag3"];
            cell0.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        NSDictionary *dic = arrComments[indexPath.row];
        NSString *strName = @"";
        NSString *strImageURL = @"";
        if([dic[@"state"] isEqual:@"1"])
        {
            strName = ZEString(@"匿名", @"Anonymous");
            strImageURL = @"";
        }
        else
        {
            strName = dic[@"username"];
            strImageURL = dic[@"head_photo"];
        }
        
        
        
        NSArray *arrTime = [dic[@"addtime"] componentsSeparatedByString:@" "];
        NSMutableArray *arrImages = [[NSMutableArray alloc]init];
        if (dic[@"photo1"] != nil && ![dic[@"photo1"] isEqualToString: @""])
        {
            [arrImages addObject:dic[@"photo1"]];
        }
        if (dic[@"photo2"] != nil && ![dic[@"photo2"] isEqualToString: @""])
        {
            [arrImages addObject:dic[@"photo2"]];
        }
        NSString *strPingjiaBack ;
        strPingjiaBack = dic[@"backpingjia"];
        if (strPingjiaBack == nil)
        {
            strPingjiaBack = @"";
        }
        [cell0 setContentWithTitle:strName headImage:strImageURL time:[arrTime firstObject] level:dic[@"pingjia"] content:dic[@"content"] images:arrImages reply:strPingjiaBack];
        currentHeight = cell0.cellHeight;
        [cell0 setFrame:CGRectMake(0, 0, WINDOWWIDTH, currentHeight)];
        cell = cell0;
    }
    else if (tableView.tag == 4)
    {
        if (indexPath.row == 0 || indexPath.row == 2)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cellblank"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellblank"];
                cell.backgroundColor = [UIColor colorWithWhite:242/255.0 alpha:1];
            }
        }
        else if (indexPath.row == 1)
        {
            MerchantInfoFirstTableViewCell *cell0;
            cell0 = [tableView dequeueReusableCellWithIdentifier:@"celltag41"];
            if (!cell0)
            {
                cell0 = [[MerchantInfoFirstTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celltag41"];
                cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell0 setContentWithHeadImage:dicShopInfo[@"shophead"] title:dicShopInfo[@"shopname"] text:dicShopInfo[@"content"]];

            cell = cell0;
        }
        else
        {
            MerchantInfoTableViewCell *cell0;
            cell0 = [tableView dequeueReusableCellWithIdentifier:@"celltag42"];
            if (!cell0)
            {
                cell0 = [[MerchantInfoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"celltag42"];
                cell0.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            NSArray *arr = @[@"2.4.0_icon_phone.png",@"2.2.3_icon_location.png",@"2.2.3_icon_time.png"];
            NSString *strMSG = @"";
            if (indexPath.row == 3)
            {
                strMSG = dicShopInfo[@"mobile"];
                cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if (indexPath.row == 4)
            {
                strMSG = dicShopInfo[@"detailed_address"];
                cell0.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            }
            else if(indexPath.row == 5)
            {
                strMSG = [NSString stringWithFormat:@"%@:%@",ZEString(@"配送时间", @"Delivery time"),dicShopInfo[@"gotime"]];
                cell0.accessoryType = UITableViewCellAccessoryNone;
            }
            [cell0 setContentWithHeadImage:[UIImage imageNamed:arr[indexPath.row - 3]] text:strMSG];
            
            cell = cell0;
        }
        return cell;
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
//        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    return cell;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView.tag == 2)
    {
        return 30;
    }
    else
    {
        return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *viewHead = [[UIView alloc]init];
    if (tableView.tag == 2)
    {
        viewHead.backgroundColor = [UIColor colorWithWhite:247/255.0 alpha:1];
        UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(20, 5, WINDOWWIDTH * (1 -170/750) - 20 - 20, 20)];
        labelTitle.textColor = [UIColor colorWithWhite:136/255.0 alpha:1];
        labelTitle.font = [UIFont systemFontOfSize:13];
        NSDictionary *dic = arrOrderKind[section];
        labelTitle.text = dic[@"cname"];
        [viewHead addSubview:labelTitle];
    }
    return viewHead;
}
-(void)btnWhiteBtnClick:(UIButton *)btn
{
    if (btn.tag != pageIndex)
    {
        for (int a = 0; a < arrKindBtns.count; a ++)
        {
            UIButton *btnThis = arrKindBtns[a];
            if (btn.tag == btnThis.tag)
            {
                [btnThis setTitleColor:MAINCOLOR forState:UIControlStateNormal];
            }
            else
            {
                [btnThis setTitleColor:[UIColor colorWithWhite:153/255.0 alpha:1] forState:UIControlStateNormal];
            }
            
        }
        pageIndex = btn.tag;
        [self reloadBottomTableView];
    }
}
-(void)reloadBottomTableView
{
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    for (UIView *aView in cell.subviews)
    {
        [aView removeFromSuperview];
    }

    if (pageIndex == 0)
    {
        [cell addSubview:TVKind];
        [cell addSubview:TVFood];
        viewBottom.hidden = NO;
    }
    else if (pageIndex == 1)
    {
        [cell addSubview:TVComment];
        viewBottom.hidden = YES;
    }
    else if (pageIndex == 2)
    {
        [cell addSubview:TVInfo];
        viewBottom.hidden = YES;

    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 1)
    {
        if (indexPath.row < arrOrderKind.count)
        {
            if (indexPath.row != orderKindIndex)
            {
                UITableViewCell *cellOld = [TVKind cellForRowAtIndexPath:[NSIndexPath indexPathForRow:orderKindIndex inSection:0]];
                cellOld.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
                cellOld.textLabel.textColor = [UIColor blackColor];
                
                UITableViewCell *cellNew = [TVKind cellForRowAtIndexPath:indexPath];
                cellNew.backgroundColor = [UIColor whiteColor];
                cellNew.textLabel.textColor = MAINCOLOR;
                
                orderKindIndex = indexPath.row;
                
                if ([arrOrderKind[indexPath.row][@"goods"] count]>0 )
                {
                    [TVFood scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] atScrollPosition:UITableViewScrollPositionTop animated:YES];
                    
                }
                
                
            }
        }

     
    }
    else if (tableView.tag == 2)
    {
        NSDictionary *dicKind = arrOrderKind[indexPath.section];
        NSArray *arrFoods = dicKind[@"goods"];
        
        if (indexPath.row < arrFoods.count)
        {
            NSDictionary *dicFood = arrFoods[indexPath.row];
            NSString *strFoodID = dicFood[@"goodsid"];
            
            NSArray *arrIDs = self.dicForSelectedFood.allKeys;
            if ( [arrIDs containsObject:strFoodID])
            {
                NSDictionary *dic = self.dicForSelectedFood[strFoodID];
                
                NSString *strContent = @"";
                
                for (NSDictionary *aDic in arrFoods)
                {
                    if ([aDic[@"goodsid"] isEqualToString:strFoodID])
                    {
                        strContent = aDic[@"goodscontent"];
                    }
                }
                
                
                [IVFoodDetail sd_setImageWithURL:[NSURL URLWithString:dic[@"image"]] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
                [FDVC setContentWithTitle:dic[@"name"] image:dic[@"image"] num:dic[@"count"] price:dic[@"price"] foodID:strFoodID foodDetails:dicFood[@"goodscontent"]];
            }
            else
            {
                [IVFoodDetail sd_setImageWithURL:[NSURL URLWithString:dicFood[@"goodsphoto"]] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
                [FDVC setContentWithTitle:dicFood[@"goodsname"] image:@"" num:@"0" price:dicFood[@"goodsprice"] foodID:strFoodID foodDetails:dicFood[@"goodscontent"]];
                
                
            }
            if (!MerchantCartVC.view.hidden)
            {
                MerchantCartVC.view.hidden = YES;
            }
            IVFoodDetail.hidden = NO;
            FDVC.view.hidden =NO;
            btnHideFoodDetail.hidden = NO;
        }
        
    }
    else if (tableView.tag == 4)
    {
        if (indexPath.row == 3)
        {
            NSMutableString *str=[[NSMutableString alloc] initWithFormat:@"tel:%@",dicShopInfo[@"mobile"]];
            UIWebView *callWebview = [[UIWebView alloc] init];
            [callWebview loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:str]]];
            [self.view addSubview:callWebview];


        }
        else if (indexPath.row == 4)
        {
            GoogleOnlyMapViewController *GOMVC = [[GoogleOnlyMapViewController alloc] init];
            GOMVC.strLocation = dicShopInfo[@"coordinate"];
            [self.navigationController pushViewController:GOMVC animated:YES];
        }
    }
}
-(void)MerchantFoodTableViewCellChangeFoodNumber:(NSInteger)strNum foodID:(NSString *)strFoodID foodName:(NSString *)strFoodName foodPrice:(NSString *)strFoodPrice imageURL:(NSString *)strImageURL
{
    NSString *strCount = [NSString stringWithFormat:@"%ld",strNum];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];

    [dic setValue:strCount forKey:@"count"];
    [dic setValue:strFoodName forKey:@"name"];
    [dic setValue:strFoodPrice forKey:@"price"];
    [dic setValue:strImageURL forKey:@"image"];
    if ([strCount isEqualToString:@"0"])
    {
        if ([self.dicForSelectedFood.allKeys containsObject:strFoodID])
        {
            [self.dicForSelectedFood removeObjectForKey:strFoodID];
        }
    }
    else
    {
        [self.dicForSelectedFood setValue:dic forKey:strFoodID];
    }
    [self refreshTotalPrice];

    
}
-(void)FoodDetailViewControllerChangeFoodNumber:(NSInteger)strNum foodID:(NSString *)strFoodID foodName:(NSString *)strFoodName foodPrice:(NSString *)strFoodPrice imageURL:(NSString *)strImageURL
{
    NSString *strCount = [NSString stringWithFormat:@"%ld",strNum];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:strCount forKey:@"count"];
    [dic setValue:strFoodName forKey:@"name"];
    [dic setValue:strFoodPrice forKey:@"price"];
    [dic setValue:strImageURL forKey:@"image"];
    if ([strCount isEqualToString:@"0"])
    {
        if ([self.dicForSelectedFood.allKeys containsObject:strFoodID])
        {
            [self.dicForSelectedFood removeObjectForKey:strFoodID];
        }
    }
    else
    {
        [self.dicForSelectedFood setValue:dic forKey:strFoodID];
    }
    
    [self refreshTotalPrice];
    [TVFood reloadData];
}
-(void)refreshTotalPrice
{
    CGFloat totalPrice  = 0.0;
    NSInteger allCount = 0;
    NSArray *arrSelectIDs =  self.dicForSelectedFood.allKeys;
    
    NSString *shopCounts = [NSString string];
    for (int a = 0; a < arrSelectIDs.count; a ++)
    {
        NSString *strKey = arrSelectIDs[a];
        NSDictionary *dicFood = self.dicForSelectedFood[strKey];
        NSString *strPrice = dicFood[@"price"];
        NSString *strCount = dicFood[@"count"];
        allCount = allCount + [strCount integerValue];
        CGFloat thisPrice = [strPrice floatValue] * [strCount integerValue];
        totalPrice = totalPrice + thisPrice;

        shopCounts = strCount;
        
    }
    _totalPriceWithOutPS = totalPrice;
    [self reloadPSFee];
    totalPrice = _totalPriceWithOutPS + PSFee;
    _totalPrice = totalPrice;
    
    //计算
    CGFloat chajia = lmoney - _totalPriceWithOutPS;
    NSString * lmoney1 = [NSString stringWithFormat:@"%0.2f", lmoney];
    NSString * chajia1 = [NSString stringWithFormat:@"%0.2f", chajia];
    NSString *cStr = [NSString stringWithFormat:@"最低$%@还差$%@",lmoney1,chajia1];
    NSString *eStr =[NSString stringWithFormat:@"$%@ MIN, REMAINING $%@",lmoney1,chajia1];
    NSString *str = ZEString(cStr,eStr);
    
    if ([shopCounts integerValue] < 1) {
         labelPeisong.text = ZEString(@"购物车为空", @"Shopping cart is empty") ;
    }else if ([shopCounts integerValue] > 0 && _totalPriceWithOutPS <  lmoney) {
        
        labelPeisong.text = str;
        payBtn.userInteractionEnabled = NO;
        payBtn.layer.borderWidth = 0.3;
        payBtn.titleLabel.textColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.3];
        payBtn.backgroundColor = [UIColor colorWithRed:235 green:235 blue:235 alpha:1.0];
        
    }else{
        
        payBtn.layer.borderWidth = 0.0;
        payBtn.backgroundColor = [UIColor colorWithRed:1 green:158/255.0 blue:0 alpha:1];
        payBtn.titleLabel.textColor = [UIColor whiteColor];
        payBtn.userInteractionEnabled = YES;
        labelPeisong.text = @"";
   
    }

    
    
    
    
   // labelPeisong.text = str;
    
    labelTotalPrice.text = [NSString stringWithFormat:@"%@:$%.2f",ZEString(@"总价", @"Total"),_totalPriceWithOutPS];
    
    NSString *countResultStr = allCount >99 ? @"99+":[NSString stringWithFormat:@"%ld",allCount];
    
    labelFoodAllCount.text = [NSString stringWithFormat:@"%@",countResultStr];
    
    
}
-(void)MerchantCartViewControllerChangeDictonary:(NSDictionary *)dic
{
    [self refreshTotalPrice];

    [TVFood reloadData];
}
-(void)btnSubmitOrderClick
{
    if (![shopOpen isEqualToString:@"1"])
    {
        [TotalFunctionView alertContent:ZEString(@"商户未营业", @"This shop has been closed") onViewController:self];
    }
    else if (self.dicForSelectedFood.allKeys.count == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"购物车为空", @"Shopping cart is empty") onViewController:self];
    }
    else
    {
        [self btnHideFoodDetailCLick];
        
        SubmitOrderViewController *SOVC = [[SubmitOrderViewController alloc]init];
        UINavigationController *NC = [[UINavigationController alloc]initWithRootViewController:SOVC];
        SOVC.dicOrder = self.dicForSelectedFood;
        SOVC.PSFee = PSFee;
        SOVC.totalPriceWithoutPS = _totalPriceWithOutPS;
        SOVC.strShopID = self.shopID;
        SOVC.strHeadImageURL = strHeadImage;
        SOVC.strShopName = _strShopName;
        [self presentViewController:NC animated:YES completion:^{
        
        }];
    }

}

-(void)btnHideFoodDetailCLick
{
    IVFoodDetail.hidden = YES;
    FDVC.view.hidden = YES;
    btnHideFoodDetail.hidden = YES;
}
-(void)btnListClick
{

    [MerchantCartVC refreshListWithCartDic:self.dicForSelectedFood all:_tableView.contentOffset.y >= WINDOWWIDTH * 400/750 - 64];
    MerchantCartVC.view.hidden = !MerchantCartVC.view.hidden;
    if (!MerchantCartVC.view.hidden)
    {
        [self btnHideFoodDetailCLick];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(999,20) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
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
