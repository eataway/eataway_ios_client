//
//  FirstViewController.m
//  EatAway
//
//  Created by apple on 2017/6/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FirstViewController.h"

#import "FirstViewTableViewCell.h"
#import "FirstNavigationController.h"
#import "SideMenuViewController.h"

#import "RecommendLoginViewController.h"
#import "RecommendNavigationController.h"
#import "PersonalInfoViewController.h"
#import "MerchantViewController.h"
#import "FirstSelectLocationViewController.h"
#import "CurrentOrderViewController.h"
#import "PersonCenterViewController.h"

#import "UserInfoViewController.h"

#import <MBProgressHUD.h>
#import <CoreLocation/CoreLocation.h>
#import <MJRefresh.h>
#import <HyphenateLite/HyphenateLite.h>
#import <EaseUI.h>
#import <UIButton+WebCache.h>


@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource,FirstNavigationControllerDelegate,SideMenuViewControllerDelegate,CLLocationManagerDelegate,UITextFieldDelegate,EaseMessageViewControllerDataSource,EaseMessageViewControllerDelegate,EaseChatBarMoreViewDelegate,FirstSelectLocationViewControllerDelegate,UIScrollViewDelegate>
{
    UITableView *_tableView;
    //广告栏
    UIScrollView *scrollView;
    //排序按钮数组
    NSMutableArray *arrOrderBtns;
    //边栏VC
    SideMenuViewController *viewside;
    //顺序栏
    UIView *viewWhite;
    //顶部背景
    UIView *viewNCBarUnder;
    
    //搜索结果
    UITableView *_tableViewSearch;
    //分页
    NSNumber *page;
    //商店列表
    NSMutableArray *arrShopList;
    //轮播图
    NSArray *arrPoster;
    //未查询到结果label
    UILabel *labelNoResult;
    //搜索结果
    NSArray *arrSearchResult;
    //是否第一次进入页面
    BOOL isFirstTimeIn;
    //排列模式
    NSInteger orderIndex;
    //轮播图pagecontrol
    UIPageControl *_pageControl;
    
    NSTimer *_timer;
    
    UIButton *btnRightAlpha;
    
    MBProgressHUD *progress;
    MJRefreshNormalHeader *header;
    MJRefreshAutoNormalFooter *footer;
}
@property (nonatomic, strong) CLLocationManager* locationManager;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
    self.view.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    isFirstTimeIn = YES;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    [self registerForKeyboardNotifications];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    thisNavi.delegateObj = self;
    
    self.navigationController.navigationBar.translucent = YES;
    
    //navigationbar透明样式
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0.0f, 0.0f, WINDOWWIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;

    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    

    [self dataInit];
    [self sideViewInit];
    [self tableViewInit];
    [self searchTableViewInit];
    [self addRecognizer];

    
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    thisNavi.navigationBar.hidden = YES;
    thisNavi.topBar.hidden = NO;
    thisNavi.TFSearch.delegate = self;
    [thisNavi.topBar addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:@"navi"];
    
    if ([ObjectForUser checkLogin])
    {
        viewside.btnQuit.hidden = NO;
    }
    else
    {
        viewside.btnQuit.hidden = YES;
    }
    
    if ([ObjectForUser checkLogin])
    {
        if (![[EMClient sharedClient] isLoggedIn])
        {
            EMError *error = [[EMClient sharedClient] loginWithUsername:USERID password:USERID];
            if (!error)
            {
//                NSLog(@"登录成功");
            }
            else if([error.errorDescription isEqualToString:@"EMErrorUserNotFound"] || [error.errorDescription isEqualToString:@"User dosn't exist"])
            {
                EMError *error = [[EMClient sharedClient] registerWithUsername:USERID password:USERID];
                if (error==nil)
                {
                    EMError *error = [[EMClient sharedClient] loginWithUsername:USERID password:USERID];
                    if (!error)
                    {
//                        NSLog(@"登录成功");
                    }
                }
            }
            else
            {
//                NSLog(@"登录失败");
            }

        }
        else
        {
//            NSLog(@"已登录");
        }


    }

}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self rightButtonAlphaInit];

    __block FirstViewController *blockSelf = self;
    
    //获取个人信息
    if ([ObjectForUser checkLogin])
    {
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/personal_center" parameter:@{@"userid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"获取个人信息失败，请检查网络连接", @"Failed to get personal information, please check the network connection") onViewController:blockSelf];
            }
            else if([resultDic[@"status"] isEqual:@(9)])
            {
                [viewside quitLoginViewChange];
                [ObjectForUser clearLogin];
                [TotalFunctionView alertContent:ZEString(@"用户信息过期，请重新登录", @"User information expired, please login again") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                NSDictionary *dic = resultDic[@"msg"];;

                viewside.labelNickname.text = dic[@"username"];
                viewside.labelPhoneNum.text = dic[@"mobile"];
                [viewside.IVHead sd_setImageWithURL:[NSURL URLWithString:dic[@"head_photo"]] placeholderImage:[UIImage imageNamed:@"2.1.2_icon_head.png"]];
                
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"username"] forKey:@"nickname"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"mobile"] forKey:@"phonenumber"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"head_photo"] forKey:@"headphoto"];

            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"获取个人信息失败，请检查网络连接", @"Failed to get personal information, please check the network connection") onViewController:blockSelf];
            }
            
            
        }];
    }
    else
    {

        [viewside quitLoginViewChange];
        
    }
    
    //首次登录
    if (isFirstTimeIn)
    {
        [self.locationManager requestWhenInUseAuthorization];
        [arrShopList removeAllObjects];
        page = @(1);
        [self reloadTableViewData];
        isFirstTimeIn = NO;
    }
    
    //定时器
    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerForScrollView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    else
    {
        [_timer fire];
    }
    
    
}
-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    thisNavi.navigationBar.hidden = NO;
    thisNavi.topBar.hidden = YES;
    
    [thisNavi.topBar removeObserver:self forKeyPath:@"frame"];

    [_timer invalidate];
    _timer = nil;
    
    
    if ([thisNavi.TFSearch isFirstResponder])
    {
        [thisNavi.TFSearch endEditing:YES];
    }
    
    [btnRightAlpha removeFromSuperview];
    btnRightAlpha = nil;
    
}
-(void)timerForScrollView
{
    CGPoint currentContentOffset = scrollView.contentOffset;
    CGSize contentSize = scrollView.contentSize;
    if (contentSize.width > WINDOWWIDTH)
    {
        if (currentContentOffset.x >= scrollView.contentSize.width - WINDOWWIDTH)
        {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            [scrollView setContentOffset:CGPointMake(currentContentOffset.x + WINDOWWIDTH, 0) animated:YES];
        }
    }

}
-(void)dataInit
{
    arrOrderBtns = [[NSMutableArray alloc]init];
    page = @(1);
    arrShopList = [[NSMutableArray alloc]init];
    orderIndex = 0;
}
//转换语言
-(void)changeLanguage
{
    NSArray *arrTitle = @[ZEString(@"默认排序", @"Best Match"),ZEString(@"商家推荐", @"Suggested"),ZEString(@"距离最近", @"Nearest"), ZEString(@"销量最高", @"Most Popular")];
    for (int a = 0; a < 4; a ++)
    {
        UIButton *btn = arrOrderBtns[a];
        [btn setTitle:arrTitle[a] forState:UIControlStateNormal];
    }
    labelNoResult.text = ZEString(@"未查询到结果", @"No results found");
    
    [footer setTitle:ZEString(@"上拉加载更多", @"Get More information") forState:MJRefreshStateIdle];
    [footer setTitle:ZEString(@"松开进行加载", @"Release the load")  forState:MJRefreshStatePulling];
    [footer setTitle:ZEString(@"加载中", @"Loading") forState:MJRefreshStateRefreshing];
    [footer setTitle:ZEString(@"暂无更多数据", @"No more data") forState:MJRefreshStateNoMoreData];
    
}
-(void)rightButtonAlphaInit
{
    if (btnRightAlpha == nil)
    {
        btnRightAlpha = [UIButton buttonWithType:UIButtonTypeCustom];
        btnRightAlpha.frame = CGRectMake(215, 0, WINDOWWIDTH - 215, WINDOWHEIGHT);
        [btnRightAlpha addTarget:self action:@selector(navgationTopBarLeftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [[UIApplication sharedApplication].keyWindow addSubview:btnRightAlpha];
        
        FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
        if(thisNavi.topBar.frame.origin.x == 0)
        {
            btnRightAlpha.hidden = YES;
        }
        else
        {
            btnRightAlpha.hidden = NO;
        }
        
    }
}
//左右滑动手势
-(void)addRecognizer
{
    UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.view addGestureRecognizer:recognizer];

    UISwipeGestureRecognizer *recognizer2 = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handle2SwipeFrom:)];
    [recognizer2 setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.view addGestureRecognizer:recognizer2];
}
-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)rec
{
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    [thisNavi.TFSearch endEditing:YES];
    if(thisNavi.topBar.frame.origin.x == 0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            thisNavi.topBar.frame = CGRectMake(215, thisNavi.topBar.frame.origin.y, WINDOWWIDTH, 64);
            _tableView.frame = CGRectMake(215, 64, WINDOWWIDTH, WINDOWHEIGHT - 64);
            if (![viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
            {
                viewWhite.frame = CGRectMake(215, 64, WINDOWWIDTH, 45);
            }
            btnRightAlpha.hidden = NO;
        }
        completion:^(BOOL finished) {
                             
        }];

    }
   
}
-(void)handle2SwipeFrom:(UISwipeGestureRecognizer *)rec
{
    
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    [thisNavi.TFSearch endEditing:YES];
    if(thisNavi.topBar.frame.origin.x > 0)
    {
        [UIView animateWithDuration:0.3 animations:^{
            
            thisNavi.topBar.frame = CGRectMake(0, thisNavi.topBar.frame.origin.y, WINDOWWIDTH, 64);
            _tableView.frame = CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64);
            if (![viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
            {
                viewWhite.frame = CGRectMake(0, 64, WINDOWWIDTH, 45);
            }
            btnRightAlpha.hidden = YES;
            
        }
    completion:^(BOOL finished) {
                             
    }];
        
    }
    
}
-(void)navgationTopBarLeftButtonClick:(UIButton *)btn
{
    
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    [thisNavi.TFSearch endEditing:YES];
    btn.enabled = NO;
    
    [UIView animateWithDuration:0.3 animations:^{
        if (thisNavi.topBar.frame.origin.x == 0)
        {
            thisNavi.topBar.frame = CGRectMake(215, thisNavi.topBar.frame.origin.y, WINDOWWIDTH, 64);
            _tableView.frame = CGRectMake(215, 64, WINDOWWIDTH, WINDOWHEIGHT - 64);
            if (![viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
            {
                viewWhite.frame = CGRectMake(215, 64, WINDOWWIDTH, 45);
            }
            btnRightAlpha.hidden = NO;
        }
        else
        {
            thisNavi.topBar.frame = CGRectMake(0, thisNavi.topBar.frame.origin.y, WINDOWWIDTH, 64);
            _tableView.frame = CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64);
            if (![viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
            {
                viewWhite.frame = CGRectMake(0, 64, WINDOWWIDTH, 45);
            }
            btnRightAlpha.hidden = YES;
        }
    } completion:^(BOOL finished) {
        btn.enabled = YES;
    }];
    
    
}
//navigationbar右上角按钮
-(void)navgationTopBarRightButtonClick:(UIButton *)btn
{
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    [thisNavi.TFSearch endEditing:YES];
    
    if ([CLLocationManager locationServicesEnabled] && ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusNotDetermined || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorized))
    {
        
        //定位功能可用
        FirstSelectLocationViewController *FSLVC = [[FirstSelectLocationViewController alloc]init];
        FSLVC.delegate = self;
        [self.navigationController pushViewController:FSLVC animated:YES];
        
    }
    else if ([CLLocationManager authorizationStatus] ==kCLAuthorizationStatusDenied)
    {
        
        //定位不能用
        [TotalFunctionView alertContent:ZEString(@"请开启应用的定位功能", @"Do not have location permissions") onViewController:self];
        
    }
}
//侧边栏初始化
-(void)sideViewInit
{
    viewside = [[SideMenuViewController alloc]init];
    viewside.delegate = self;
    viewside.view.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    [self.view addSubview:viewside.view];
}
-(void)sideMenuQuitClick
{
    [[EMClient sharedClient] logout:YES];
    [ObjectForUser clearLogin];
}
-(void)sideMenuListButtonClickWithIndex:(NSInteger)btnIndex
{
    if (btnIndex == 0)
    {
        
        FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
        [thisNavi.TFSearch endEditing:YES];
        
        [UIView animateWithDuration:0.3 animations:^{

        thisNavi.topBar.frame = CGRectMake(0, thisNavi.topBar.frame.origin.y, WINDOWWIDTH, 64);
        _tableView.frame = CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64);
        if (![viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
        {
            viewWhite.frame = CGRectMake(0, 64, WINDOWWIDTH, 45);
        }
            btnRightAlpha.hidden = YES;
        } completion:^(BOOL finished) {
            
        }];
        
    }
    else if (btnIndex == 1)
    {
        if ([ObjectForUser checkLogin])
        {
            CurrentOrderViewController *COVC = [[CurrentOrderViewController alloc]init];
            [self.navigationController pushViewController:COVC animated:YES];
        }
        else
        {
            ALERTNOTLOGIN
        }
    }
    else if (btnIndex == 2)
    {
        //个人中心
        if ([ObjectForUser checkLogin])
        {
            PersonCenterViewController *vc = [[PersonCenterViewController alloc]init];
            [self.navigationController pushViewController:vc animated:YES];
        }
        else
        {
            ALERTNOTLOGIN
        }
        
    }
    else if (btnIndex == 3)
    {
        if([ObjectForUser checkLogin])
        {
            [[EMClient sharedClient].chatManager getConversation:@"8001" type:EMConversationTypeChat createIfNotExist:YES];
            
            
            EaseMessageViewController *chatController = [[EaseMessageViewController alloc] initWithConversationChatter:@"EatAway" conversationType:EMConversationTypeChat];
            chatController.dataSource = self;
            chatController.delegate = self;
            chatController.chatBarMoreView.delegate = chatController;
            [chatController.chatBarMoreView removeItematIndex:3];
            [chatController.recordView removeFromSuperview];

            UIView *viewTop = [[UIView alloc]initWithFrame:CGRectMake(0, -64, WINDOWWIDTH, 64)];
            viewTop.backgroundColor = MAINCOLOR;
            [chatController.view addSubview:viewTop];
            
            UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, WINDOWWIDTH, 44)];
            labelTitle.textColor = [UIColor whiteColor];
            labelTitle.textAlignment = NSTextAlignmentCenter;
            labelTitle.text = ZEString(@"客服", @"Customer service");
            [viewTop addSubview:labelTitle];
            
            [self.navigationController pushViewController:chatController animated:YES];
        }
        else
        {
            ALERTNOTLOGIN
        }
   

    }
}
//加载首页数据
-(void)reloadTableViewData
{
    __block FirstViewController *blockSelf = self;
    if (!header.isRefreshing && !footer.isRefreshing)
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    }
    NSString *strCoor = LOCATION;
    if (strCoor == nil)
    {
        strCoor = @"";
    }
    NSString *strRow = [NSString stringWithFormat:@"%ld",((long)([page integerValue]- 1) * 15)];
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/shop/shoplist" parameter:@{@"page":page,@"coor":strCoor,@"num":[NSString stringWithFormat:@"%ld",(long)orderIndex],@"row":strRow} resultBlock:^(NSDictionary *resultDic) {
        if (!progress.isHidden)
        {
            [progress hide:YES];
        }
        if (header.isRefreshing)
        {
            [header endRefreshing];
        }
        if (footer.isRefreshing)
        {
            [footer endRefreshing];
        }

        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"获取商户列表失败，请检查网络连接", @"Failed to get merchant list, please check the network connection") onViewController:blockSelf];
        }
        else if ([resultDic[@"status"] isEqual:@(1)])
        {
            arrPoster = resultDic[@"msg1"];
            NSArray *arrMsg = resultDic[@"msg"];
            [arrShopList addObjectsFromArray:arrMsg];
            if (arrMsg.count > 0)
            {
                page = @([page integerValue] + 1);
            }
            [_tableView reloadData];
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"获取商户列表失败，请检查网络连接", @"Failed to get merchant list, please check the network connection") onViewController:blockSelf];
        }
    }];

}
//初始化主要TableView
-(void)tableViewInit
{
    
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    viewWhite = [[UIView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, 45)];
    viewWhite.backgroundColor = [UIColor whiteColor];
    NSArray *arrTitle = @[ZEString(@"默认排序", @"Best Match"),ZEString(@"商家推荐", @"Suggested"),ZEString(@"距离最近", @"Nearest"), ZEString(@"销量最高", @"Most Popular")];
    
    for (int a = 0; a < 4; a ++)
    {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(a * WINDOWWIDTH/4, 0, WINDOWWIDTH/4, 45);
        [btn setTitle:arrTitle[a] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.tag = a;
        [btn addTarget:self action:@selector(btnOrderClick:) forControlEvents:UIControlEventTouchUpInside];
        [viewWhite addSubview:btn];
        [arrOrderBtns addObject:btn];
        if(a == 0)
        {
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        }
        else
        {
            [btn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
        }
    }

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tag = 100;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [_tableView addObserver:self forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:nil];
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    __weak FirstViewController *blockSelf = self;
    footer =[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [blockSelf reloadTableViewData];
    }];
    footer.refreshingTitleHidden = YES;
    [footer setTitle:ZEString(@"上拉加载更多", @"Get More information") forState:MJRefreshStateIdle];
    [footer setTitle:ZEString(@"松开进行加载", @"Release the load")  forState:MJRefreshStatePulling];
    [footer setTitle:ZEString(@"加载中", @"Loading") forState:MJRefreshStateRefreshing];
    [footer setTitle:ZEString(@"暂无更多数据", @"No more data") forState:MJRefreshStateNoMoreData];
    _tableView.mj_footer = footer;
    
    header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [arrShopList removeAllObjects];
        [_tableView reloadData];
        page = @(1);
        [blockSelf reloadTableViewData];
        
        
    }];
    header.lastUpdatedTimeLabel.hidden = YES;
    _tableView.mj_header = header;
    header.stateLabel.hidden = YES;
    _tableView.mj_header = header;
    _tableView.mj_footer = footer;
    
}
//初始化搜索结果TableView
-(void)searchTableViewInit
{
    _tableViewSearch = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    _tableViewSearch.delegate = self;
    _tableViewSearch.dataSource = self;
    _tableViewSearch.tag = 200;
    _tableViewSearch.hidden = YES;
    _tableViewSearch.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableViewSearch.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableViewSearch];
    
    labelNoResult = [[UILabel alloc]initWithFrame:CGRectMake(10, 70, WINDOWWIDTH - 20, 40)];
    labelNoResult.font = [UIFont systemFontOfSize:13];
    labelNoResult.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    labelNoResult.text = ZEString(@"未查询到结果", @"No results found");
    labelNoResult.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelNoResult];
    labelNoResult.hidden = YES;
    
}
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
{
    FirstNavigationController *thisNavi = (FirstNavigationController *) self.navigationController;
    CGFloat topbarX = thisNavi.topBar.frame.origin.x;
    if (_tableView.contentOffset.y > WINDOWWIDTH * 280/750 && [viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
    {
        [viewWhite removeFromSuperview];
        [self.view addSubview:viewWhite];
        viewWhite.frame = CGRectMake(topbarX, 64, WINDOWWIDTH, 45);
    }
    else if(_tableView.contentOffset.y <= WINDOWWIDTH * 280/750 && ![viewWhite.superview.class isSubclassOfClass:[UITableViewCell class]])
    {
        [viewWhite removeFromSuperview];
        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
        [cell addSubview:viewWhite];
        viewWhite.frame = CGRectMake(0, 0, WINDOWWIDTH, 45);
    }
    viewNCBarUnder.frame = CGRectMake(topbarX, 0, WINDOWWIDTH, 64);
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag == 100)
    {
        return arrShopList.count + 2;

    }
    else if (tableView.tag == 200)
    {
        return arrSearchResult.count + 1;
    }
    else
    {
        return 5;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100)
    {
        if (indexPath.row == 0)
        {
            return WINDOWWIDTH * 280/750;
        }
        else if (indexPath.row == 1)
        {
            return 45;
        }
        else
        {
            return 150;
        }

    }
    else if (tableView.tag == 200)
    {
        return 150;
    }
    else
    {
        return 100;
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
                
                scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWWIDTH * 280/750)];
                scrollView.delegate = self;
                scrollView.pagingEnabled = YES;
                scrollView.showsHorizontalScrollIndicator = NO;
                [cell addSubview:scrollView];
                
                
                _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(WINDOWWIDTH/2,  WINDOWWIDTH * 280/750 - 30, 0, 30)];

                [_pageControl setCurrentPageIndicatorTintColor:MAINCOLOR];
                _pageControl.enabled = NO;
                [cell addSubview:_pageControl];
                
            }
            
            for (UIView *aView in scrollView.subviews)
            {
                [aView removeFromSuperview];
            }
            

            scrollView.contentSize = CGSizeMake(arrPoster.count * WINDOWWIDTH, WINDOWWIDTH * 280/750);
            for (int a = 0 ; a < arrPoster.count; a ++)
            {
                NSDictionary *dic = arrPoster[a];
                
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(a * WINDOWWIDTH, 0, WINDOWWIDTH, WINDOWWIDTH * 280/750);
                [btn sd_setImageWithURL:[NSURL URLWithString:dic[@"shopphoto"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
                btn.tag = a;
                [btn addTarget:self action:@selector(btnPosterClick:) forControlEvents:UIControlEventTouchUpInside];
                [scrollView addSubview:btn];
            }
            [_pageControl setNumberOfPages:arrPoster.count];
            CGFloat pageControlWidth = 8 + 16 * arrPoster.count - 1;
            _pageControl.frame = CGRectMake(WINDOWWIDTH/2 - pageControlWidth/2,  WINDOWWIDTH * 280/750 - 30, pageControlWidth, 30);
        }
        else if (indexPath.row == 1)
        {
            cell = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
            if (!cell)
            {
                cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell01"];
                
                [cell addSubview:viewWhite];
                viewWhite.frame = CGRectMake(0, 0, WINDOWWIDTH, 45);
            }
            
        }
        else
        {
            FirstViewTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (!cell0)
            {
                cell0 = [[FirstViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
            }
            NSDictionary *dic = arrShopList[indexPath.row - 2];
            BOOL isOpen;
            if ([dic[@"state"] isEqualToString:@"1"])
            {
                isOpen = YES;
            }
            else
            {
                isOpen = NO;
            }
            
            NSLog(@"location = %@",LOCATION);
            NSNumber *numDistance = dic[@"juli"];
            NSArray *arrCategory = dic[@"category"];
            NSMutableString *strCategory = [[NSMutableString alloc]init];
            NSInteger count = arrCategory.count >= 3 ?3:arrCategory.count;
//            for (int a = 0; a < count; a ++ )
//            {
//                [strCategory appendString:arrCategory[a][@"cname"]];
//                [strCategory appendString:@"  "];
//            }
            if(count == 0)
            {
                [strCategory appendString:@""];
            }
            else
            {
                [strCategory appendString:arrCategory[0][@"cname"]];
            }

            [cell0 setContentWithHeadImage:dic[@"shophead"] tips:strCategory backgroundImage:dic[@"shopphoto"] title:dic[@"shopname"] distance:[NSString stringWithFormat:@"%.2f km",[numDistance floatValue]] isOpen:isOpen];
            
            cell = cell0;
            
        }

    }
    else if (tableView.tag == 200)
    {

            if(indexPath.row == arrSearchResult.count)
            {
                cell = [tableView dequeueReusableCellWithIdentifier:@"cellblank"];
                if (!cell)
                {
                    cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellblank"];
                    cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
                }
                
            }
        else
        {
            FirstViewTableViewCell *cell0 = [tableView dequeueReusableCellWithIdentifier:@"cellsearch"];
            if (!cell0)
            {
                cell0 = [[FirstViewTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cellsearch"];
            }
            NSDictionary *dic = arrSearchResult[indexPath.row];
            BOOL isOpen;
            if ([dic[@"state"] isEqualToString:@"1"])
            {
                isOpen = YES;
            }
            else
            {
                isOpen = NO;
            }
            
            NSLog(@"location = %@",LOCATION);
            NSNumber *numDistance = dic[@"juli"];
            NSArray *arrCategory = dic[@"category"];
            NSMutableString *strCategory = [[NSMutableString alloc]init];
            NSInteger count = arrCategory.count >= 3 ?3:arrCategory.count;

            if(count == 0)
            {
                [strCategory appendString:@""];
            }
            else
            {
                [strCategory appendString:arrCategory[0][@"cname"]];
            }
            [cell0 setContentWithHeadImage:dic[@"shophead"] tips:strCategory backgroundImage:dic[@"shopphoto"] title:dic[@"shopname"] distance:[NSString stringWithFormat:@"%.2f km",[numDistance floatValue]] isOpen:isOpen];
            
            cell = cell0;
            

        }


    }
    
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView.tag == 100)
    {
        if (indexPath.row >= 2)
        {
            NSDictionary *dic = arrShopList[indexPath.row - 2];
            MerchantViewController *MVC = [[MerchantViewController alloc]init];
            MVC.shopID = dic[@"shopid"];
            MVC.userLocation = LOCATION;
            [self.navigationController pushViewController:MVC animated:YES];
        }
    }
    else
    {
        if (indexPath.row == arrSearchResult.count )
        {
            
        }
        else
        {
            NSDictionary *dic = arrSearchResult[indexPath.row];
            MerchantViewController *MVC = [[MerchantViewController alloc]init];
            MVC.shopID = dic[@"shopid"];
            MVC.userLocation = LOCATION;
            [self.navigationController pushViewController:MVC animated:YES];
        }
        
        
    }

    
}
//轮播图点击
-(void)btnPosterClick:(UIButton *)btn
{
    NSDictionary *dic = arrPoster[btn.tag];
    MerchantViewController *MVC = [[MerchantViewController alloc]init];
    MVC.shopID = dic[@"shopid"];
    [self.navigationController pushViewController:MVC animated:YES];

}
//选择地址
-(void)FirstSelectLocationViewControllerSelectAddressWithDictionary:(NSDictionary *)dicAddress
{
    isFirstTimeIn = YES;
}
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    [_pageControl setCurrentPage:(int)(scrollView.contentOffset.x/WINDOWWIDTH)];
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [_pageControl setCurrentPage:(int)(scrollView.contentOffset.x/WINDOWWIDTH)];

    if (_timer == nil)
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timerForScrollView) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
        
    }
}
- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [_timer invalidate];
    _timer = nil;
    
}

- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:) name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter]  addObserver:self selector:@selector(keyboardWasHidden:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)keyboardWasShown:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    
    NSLog(@"keyBoard:%f", keyboardSize.height);  //216
    _tableViewSearch.frame = CGRectMake(0, _tableViewSearch.frame.origin.y, WINDOWWIDTH, WINDOWHEIGHT - _tableViewSearch.frame.origin.y -  keyboardSize.height);
    
}
- (void) keyboardWasHidden:(NSNotification *) notif
{
    NSDictionary *info = [notif userInfo];
    
    NSValue *value = [info objectForKey:UIKeyboardFrameBeginUserInfoKey];
    CGSize keyboardSize = [value CGRectValue].size;
    NSLog(@"keyboardWasHidden keyBoard:%f", keyboardSize.height);
    // keyboardWasShown = NO;
    _tableViewSearch.frame = CGRectMake(0, _tableViewSearch.frame.origin.y, WINDOWWIDTH, WINDOWHEIGHT - _tableViewSearch.frame.origin.y -  keyboardSize.height);

    
}


//搜索TextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _tableViewSearch.hidden = NO;
    viewWhite.hidden = YES;
}
-(void)textFieldDidEndEditing:(UITextField *)textField
{
    _tableViewSearch.hidden = YES;
    viewWhite.hidden = NO;
}
//搜索结果
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    __weak FirstViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/shop/sercheshop" parameter:@{@"shopname":textField.text} resultBlock:^(NSDictionary *resultDic)
    {
        [progress hide:YES];
        if (resultDic == nil)
        {
            [TotalFunctionView alertContent:ZEString(@"搜索失败，请检查网络连接", @"Search failed, please check the network connection") onViewController:blockSelf];
            labelNoResult.hidden = YES;
        }
        else if([resultDic[@"status"] isEqual:@(3)])
        {
            arrSearchResult = @[];
            [_tableViewSearch reloadData];
            labelNoResult.hidden = NO;
        }
        else if([resultDic[@"status"] isEqual:@(1)])
        {
            arrSearchResult = resultDic[@"msg"];
            [_tableViewSearch reloadData];
            labelNoResult.hidden = YES;
        }
        else
        {
            [TotalFunctionView alertContent:ZEString(@"搜索失败，请检查网络连接", @"Search failed, please check the network connection") onViewController:blockSelf];
            labelNoResult.hidden = YES;
        }

    }];
    return YES;
}
//侧边栏点击头像
-(void)sideMenuHeadImageAreaClick
{
    NSLog(@"点击头像");
    
    if ([ObjectForUser checkLogin])
    {
        
        UserInfoViewController *UIVC = [[UserInfoViewController alloc]init];
        [self.navigationController pushViewController:UIVC animated:YES];
    }
    else
    {
        RecommendLoginViewController *RVC = [[RecommendLoginViewController alloc]init];
        RecommendNavigationController *RNC = [[RecommendNavigationController alloc]initWithRootViewController:RVC];
        [self presentViewController:RNC animated:YES completion:^{
            
        }];
    }

    
}
//餐厅顺序点击
-(void)btnOrderClick:(UIButton *)btn
{
    if (btn.tag != orderIndex)
    {
        for (UIButton *aBtn in arrOrderBtns)
        {
            if(aBtn.tag == btn.tag)
            {
                [aBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            }
            else
            {
                [aBtn setTitleColor:[UIColor colorWithWhite:0.8 alpha:1] forState:UIControlStateNormal];
            }
        }
        
        orderIndex = btn.tag;
        page = @(1);
        [arrShopList removeAllObjects];
        [self reloadTableViewData];
    }
   
    
}
//环信
- (id<IMessageModel>)messageViewController:(EaseMessageViewController *)viewController
                           modelForMessage:(EMMessage *)message
{
    //用户可以根据自己的用户体系，根据message设置用户昵称和头像
    id<IMessageModel> model = nil;
    model = [[EaseMessageModel alloc] initWithMessage:message];

    if(model.isSender)
    {
        model.avatarURLPath = HEADPHOTO;
        model.nickname = NICKNAME;
    }
    else
    {
        model.avatarImage = [UIImage imageNamed:@"logo_1024px.png"];//默认头像
        model.nickname = @"EatAway";
    }

    return model;
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
