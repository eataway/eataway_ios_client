//
//  AboutUsViewController.m
//  EatAway
//
//  Created by BossWang on 17/7/1.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AboutUsViewController.h"

@interface AboutUsViewController ()

@property (nonatomic, strong)UIImageView *imageVC;
@property (nonatomic, strong)UILabel *versionNumber;
@property (nonatomic, strong)UILabel *companyLab;

@end

@implementation AboutUsViewController
{
    UIView *viewNCBarUnder;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.title = ZEString(@"关于我们", @"About us");
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    [self createUI];
}

- (void)createUI{
    
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH/2 - 50, 104, 100, 100)];
    self.imageVC.clipsToBounds = NO;
    self.imageVC.layer.cornerRadius = 5;
    self.imageVC.image = [UIImage imageNamed:@"4.1.7_icon_logo"];
    [self.view addSubview:self.imageVC];
    
    self.versionNumber = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageVC.frame)+25, WINDOWWIDTH, 30)];
    self.versionNumber.textColor = EWColor(102, 102, 102, 1);
    self.versionNumber.text = ZEString(@"版本号V8.1.0.1523", @"Version numberV8.1.0.1523");
    self.versionNumber.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.versionNumber];
    
    self.companyLab = [[UILabel alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 50, WINDOWWIDTH, 20)];
    self.companyLab.textAlignment = NSTextAlignmentCenter;
    self.companyLab.text = ZEString(@"河北优枫网络科技有限公司", @"You Feng Internet Technology Co,.Ltd");
    self.companyLab.font = [UIFont systemFontOfSize:13];
    self.companyLab.textColor = EWColor(153, 153, 153, 1);
    [self.view addSubview:self.companyLab];
    
    
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
