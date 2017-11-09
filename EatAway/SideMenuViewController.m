//
//  SideMenuViewController.m
//  EatAway
//
//  Created by apple on 2017/6/10.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SideMenuViewController.h"

@interface SideMenuViewController ()
{
    UIButton *btnZhong;
    UIButton *btnEnglish;
    
    NSMutableArray *arrBtns;
}
@end

@implementation SideMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    [self setUI];
}


-(void)setUI{
    
   
    
    arrBtns = [[NSMutableArray alloc]init];
    
    
    //头像
    self.IVHead = [[UIImageView alloc]initWithFrame:CGRectMake( 20, 64 + 10, 50, 50)];
    self.IVHead.image = [UIImage imageNamed:@"2.1.2_icon_head.png"];
    self.IVHead.clipsToBounds = YES;
    self.IVHead.layer.cornerRadius = 25;
    [self.view addSubview:self.IVHead];
    
    //昵称
    self.labelNickname = [[UILabel alloc]initWithFrame:CGRectMake(20 + 50 + 10 , 64 + 10 +5, 125, 20)];
    self.labelNickname.font = [UIFont systemFontOfSize:14];
    self.labelNickname.textColor = [UIColor blackColor];
    [self.view addSubview:self.labelNickname];
    self.labelNickname.text = ZEString(@"登录/注册", @"Login/Register");
    
    //手机号
    self.labelPhoneNum = [[UILabel alloc]initWithFrame:CGRectMake(20 + 50 + 10 , 64 + 10 +5 + 20 +5, 125, 15)];
    self.labelPhoneNum.textColor = [UIColor colorWithWhite:0.8 alpha:1];
    self.labelPhoneNum.font = [UIFont systemFontOfSize:12];
    [self.view addSubview:self.labelPhoneNum];
    
    //头像点击按钮
    UIButton *btnHead = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHead.frame = CGRectMake(20, 64 + 10, 215 - 20 - 20, 50);
    [btnHead addTarget:self action:@selector(btnHeadAreaClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHead];
    
    
    CGFloat btnHeight = WINDOWHEIGHT/(2 * 4);
    if (btnHeight > 60)
    {
        btnHeight = 60;
    }
    
    CGFloat viewX = 140;
    
    NSArray *arrBtnTitle = @[ZEString(@"美食餐厅", @"Restaurant"),ZEString(@"当前订单",@"Current order"),ZEString(@"个人中心",@"Personal center"),ZEString(@"客服聊天",@"Customer service")];
    
    
    //四个按钮
    for (int a = 0 ; a < 4 ; a ++)
    {
        UIView *viewLine = [[UIView alloc]initWithFrame:CGRectMake(20, viewX, 215 - 20 - 20, 1)];
        viewLine.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
        [self.view addSubview:viewLine];
        
        UIImageView *IVBtn = [[UIImageView alloc]initWithFrame:CGRectMake(20,viewX + btnHeight/3, btnHeight/3, btnHeight/3)];
        IVBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"2.1.2_icon_0%d",a + 1]];
        [self.view addSubview:IVBtn];
        
        UILabel *labelBtnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20 + btnHeight/3 + 15, viewX + btnHeight/3, 150, btnHeight/3)];
        labelBtnTitle.text = arrBtnTitle[a];
        labelBtnTitle.textColor = [UIColor colorWithWhite:75/255.0 alpha:1];
        labelBtnTitle.font = [UIFont systemFontOfSize:15];
        [self.view addSubview:labelBtnTitle];
        
        UIButton *btnTrueBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        btnTrueBtn.frame = CGRectMake(20, viewX, 215- 20 - 20, btnHeight);
        btnTrueBtn.tag = a;
        [btnTrueBtn addTarget:self action:@selector(btnTrueBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:btnTrueBtn];
        
        [arrBtns addObject:labelBtnTitle];
        viewX = viewX + btnHeight;
        
    }
    
    UIView *viewLineLast = [[UIView alloc]initWithFrame:CGRectMake(20, viewX, 215 - 20 - 20, 1)];
    viewLineLast.backgroundColor = [UIColor colorWithWhite:0.8 alpha:1];
    [self.view addSubview:viewLineLast];
    
    
    //退出登录
    self.btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btnQuit.frame = CGRectMake(50, viewX + btnHeight, 215 - (50 * 2),35);
    self.btnQuit.backgroundColor = [UIColor colorWithRed:255/255.0 green:157/255.0 blue:0 alpha:1];
    self.btnQuit.clipsToBounds = YES;
    [self.btnQuit setTitle:ZEString(@"退出登录", @"logout") forState:UIControlStateNormal];
    self.btnQuit.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.btnQuit setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.btnQuit.layer.cornerRadius = 7;
    [self.view addSubview:self.btnQuit];
    [self.btnQuit addTarget:self action:@selector(btnQuitClick) forControlEvents:UIControlEventTouchUpInside];
    
    
    //中英切换
    btnZhong = [UIButton buttonWithType:UIButtonTypeCustom];
    btnZhong.frame = CGRectMake(22,WINDOWHEIGHT - 50, 30, 20);
    [btnZhong setTitle:@"EN" forState:UIControlStateNormal];
    btnZhong.titleLabel.font = [UIFont systemFontOfSize:12];
    btnZhong.tag = 1;
    [btnZhong addTarget:self action:@selector(btnChangeLanguageCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZhong];
    if (ISCHINESE)
    {
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    else
    {
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
    }
    
    UIView *viewl = [[UIView alloc]initWithFrame:CGRectMake(22 + 29,WINDOWHEIGHT - 50, 1, 20)];
    viewl.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    [self.view addSubview:viewl];
    
    btnEnglish = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnglish.frame = CGRectMake(22 + 30, WINDOWHEIGHT - 50, 30, 20);
    [btnEnglish setTitle:@"中" forState:UIControlStateNormal];
    btnEnglish.titleLabel.font = [UIFont systemFontOfSize:12];
    btnEnglish.tag = 2;
    [btnEnglish addTarget:self action:@selector(btnChangeLanguageCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnglish];
    if (ISCHINESE)
    {
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
    }
    else
    {
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }

}


-(void)changeLanguage
{
    if (ISCHINESE)
    {
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
}
    else
    {
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];

        
    }

    
    
    
    
    
    if ([ObjectForUser checkLogin])
    {
        
    }
    else
    {
        self.labelNickname.text = ZEString(@"登录/注册", @"Login/Register");
    }
    
    NSArray *arrBtnTitle = @[ZEString(@"美食餐厅", @"Restaurant"),ZEString(@"当前订单",@"Current order"),ZEString(@"个人中心",@"Personal center"),ZEString(@"客服聊天",@"Customer service")];
    for (int a = 0; a < arrBtns.count; a ++)
    {
        UILabel *label = arrBtns[a];
        label.text = arrBtnTitle[a];

    }
    
    [self.btnQuit setTitle:ZEString(@"退出登录", @"Logout") forState:UIControlStateNormal];

}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([ObjectForUser checkLogin])
    {
        self.btnQuit.hidden = NO;
    }
    else
    {
        self.btnQuit.hidden = YES;
    }
  
   
    
}

-(void)btnHeadAreaClick
{
    [self.delegate sideMenuHeadImageAreaClick];
}
-(void)btnQuitClick
{
    [self quitLoginViewChange];
    [self.delegate sideMenuQuitClick];
}
-(void)quitLoginViewChange
{
    self.labelNickname.text = ZEString(@"登录/注册", @"Login/Register");
    self.labelPhoneNum.text = @"";
    self.IVHead.image = [UIImage imageNamed:@"2.1.2_icon_head.png"];
    self.btnQuit.hidden = YES;
}
-(void)btnTrueBtnClick:(UIButton *)btn
{
    [self.delegate sideMenuListButtonClickWithIndex:btn.tag];
}
-(void)btnChangeLanguageCLick:(UIButton *)btn
{
    if (ISCHINESE && btn.tag == 2)
    {

        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"language"];
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        
    }
    else if(!ISCHINESE && btn.tag == 1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"language"];
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        
    }
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
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
