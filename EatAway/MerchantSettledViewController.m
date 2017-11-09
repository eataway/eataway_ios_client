//
//  MerchantSettledViewController.m
//  EatAway
//
//  Created by BossWang on 17/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantSettledViewController.h"

@interface MerchantSettledViewController ()

@property (nonatomic, strong) UIButton *downloadBtn;
@end

@implementation MerchantSettledViewController{
    
    NSMutableArray *arrBtns;
    UIView *viewNCBarUnder;
}


//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"商家入驻", @"Business account");
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
//    [self cereatNav];
    [self cerateUI];
}

- (void)cereatNav{
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(0, 0, 20, 20);
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    backBtn.backgroundColor = [UIColor redColor];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithCustomView:backBtn];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)cerateUI{
    
//    CGFloat btnHeight = WINDOWHEIGHT/(2 * 4);
//    CGFloat viewX = 115;
//    
//    NSArray *arrLabTitle1 = @[ZEString(@"第一步", @"Restaurant"),ZEString(@"第二步",@"Order"),ZEString(@"第三步",@"Person Center"),ZEString(@"第四步",@"Customer Service")];
//    NSArray *arrLabTitle2 = @[ZEString(@"下载注册EatAway商户端", @"wewwewe"),ZEString(@"商户端申请认证", @"sffsfsdf"),ZEString(@"等待平台人员上门认证", @"sdfdsf"),ZEString(@"签约上线", @"gdsfdsaf")];
//    
//    for (int a = 0 ; a < 4 ; a ++)
//    {
//        
//        UIImageView *IVBtn = [[UIImageView alloc]initWithFrame:CGRectMake(20,viewX + 5, 50, 50)];
//        IVBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"4.1.4_icon_0%d",a + 1]];
//        [self.view addSubview:IVBtn];
//        
//        UILabel *labelBtnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20 + 40 + 15, viewX +10, 150, btnHeight/3)];
//        labelBtnTitle.text = arrLabTitle1[a];
//        labelBtnTitle.textColor = [UIColor colorWithWhite:75/255.0 alpha:1];
//        labelBtnTitle.font = [UIFont systemFontOfSize:15];
//        [self.view addSubview:labelBtnTitle];
//        
//        UILabel *labelBtnTitle2 = [[UILabel alloc]initWithFrame:CGRectMake(20 + 40 + 15, viewX + 30, 150, btnHeight/3)];
//        labelBtnTitle2.text = arrLabTitle2[a];
//        labelBtnTitle2.textColor = [UIColor colorWithWhite:75/255.0 alpha:1];
//        labelBtnTitle2.font = [UIFont systemFontOfSize:15];
//        [self.view addSubview:labelBtnTitle2];
//      
//        
//        
//        viewX = viewX + btnHeight + 18;
//        
//        }
    UIImageView *IV = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWWIDTH/750 *959)];
    if (ISCHINESE)
    {
        IV.image = [UIImage imageNamed:@"4.1.4_SJRZ_English2.png"];
        
    }
    else
    {
        IV.image = [UIImage imageNamed:@"4.1.4_SJRZ.png"];
    }
    [self.view addSubview:IV];
    
    self.downloadBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.downloadBtn.frame = CGRectMake(30, WINDOWHEIGHT - 60, WINDOWWIDTH - 60, 40);
    self.downloadBtn.clipsToBounds = YES;
    self.downloadBtn.layer.cornerRadius = 4;
    self.downloadBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.63f blue:0.20f alpha:1.00f];
    [self.downloadBtn setTitle:ZEString(@"下载商家端", @"Download the business app") forState:UIControlStateNormal];
    [self.downloadBtn addTarget:self action:@selector(downloadClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.downloadBtn];
    
    
}
#pragma mark - 下载商家端的点击事件
- (void)downloadClick:(UIButton *)sender{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/eatawaymerchant/id1262707480?mt=8"]];
}

- (void)backClick{
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
