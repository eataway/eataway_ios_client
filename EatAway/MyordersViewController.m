//
//  MyordersViewController.m
//  EatAway
//
//  Created by BossWang on 17/7/4.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MyordersViewController.h"
#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"
@interface MyordersViewController ()<UITableViewDelegate,UITableViewDataSource,MyOrderDelegate>

@property (nonatomic, strong) UITableView *myTable;
@property (nonatomic, assign) NSInteger page;
@property (nonatomic, strong) MyOrderModel *orderModel;
@property (nonatomic,strong) NSMutableArray * apps;

@end

@implementation MyordersViewController{
    
    UIView *viewNCBarUnder;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = ZEString(@"我的订单", @"myOrder");
    self.page = 1;
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [self createTable];
    [self MyDatas];
}

- (void)createTable{
    self.myTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    self.myTable.delegate = self;
    self.myTable.dataSource = self;
    self.myTable.separatorStyle = UITableViewCellSelectionStyleNone;
    self.myTable.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:self.myTable];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *myOrderID = @"myorderCell";
    MyOrderTableViewCell *myOrderCell = [tableView dequeueReusableCellWithIdentifier:myOrderID];
    if (!myOrderCell) {
        myOrderCell = [[MyOrderTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:myOrderID];
        myOrderCell.myOrderDelegate = self;
        myOrderCell.orderModel = self.apps[indexPath.row];
        myOrderCell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return myOrderCell;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.apps.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 180;
}
//确认确认订单的点击事件
- (void)affirmReceiving{
    
}
//再来一单的点击事件
- (void)againOrder{
    
}

- (void)MyDatas{

    self.apps = [[NSMutableArray alloc]init];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    params[@"userid"] = USERID;
    params[@"token"] = TOKEN;
    params[@"page"] = [NSString stringWithFormat:@"%ld",_page];
    
    [HWHttpTool post:Server_Orderlist params:params success:^(id json) {
        
        self.apps = [MyOrderModel arrayOfModelsFromDictionaries:json[@"msg"] error:nil];
        [self.myTable reloadData];
       
    } failure:^(NSError *error) {
        [SVProgressHUD showInfoWithStatus:@"网络连接失败"];
    }];
    
}

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
