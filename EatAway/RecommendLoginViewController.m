//
//  RecommendLoginViewController.m
//  EatAway
//
//  Created by apple on 2017/6/12.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "RecommendLoginViewController.h"



#import "RegisterViewController.h"
#import "LoginWithPhoneViewController.h"


#import <ShareSDK/ShareSDK.h>
#import <MBProgressHUD.h>

#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

//#import <ShareSDKConnector/ShareSDKConnector.h>
//<FBSDKLoginButtonDelegate>
@interface RecommendLoginViewController ()
{
    UILabel *labelTips;
    UIButton *btnRegister;
    UIButton *btnLogin;
    
    UIButton *btnZhong;
    UIButton *btnEnglish;
    UILabel *labelWeixin;
    
    
    
    MBProgressHUD *progress;
}
@end

@implementation RecommendLoginViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    

    [ShareSDK cancelAuthorize:SSDKPlatformTypeWechat];
    [ShareSDK cancelAuthorize:SSDKPlatformTypeFacebook];
        
    
    [self setNavigationbarAlpha];
    [self viewInit];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
}
-(void)changeLanguage
{
    if (ISCHINESE)
    {
        [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
        [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
        labelTips.text = @"推荐登录方式";
        labelWeixin.text = @"微 信 登 录";
    }
    else
    {
        [btnRegister setTitle:@"Register" forState:UIControlStateNormal];
        [btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        labelTips.text = @"Recommend Login";
        labelWeixin.text = @"WeChat";
    }

}
-(void)setNavigationbarAlpha
{
    self.navigationController.navigationBar.translucent = YES;
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
    
    
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Login_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackClick)];
    self.navigationItem.leftBarButtonItem = itemBack;
    
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(0, -60) forBarMetrics:UIBarMetricsDefault];
    
}
-(void)viewInit
{
    UIImageView *IVBG = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Commend_bg.png"]];
    IVBG.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    [self.view addSubview:IVBG];
    
    UIImageView *IVLogo = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOWWIDTH-90)/2, 100, 90, 90)];
    IVLogo.image = [UIImage imageNamed:@"Login_logo.png"];
    [self.view addSubview:IVLogo];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake((WINDOWWIDTH - 90)/2, 100 + 90 + 10, 90, 20)];
    labelName.font = [UIFont systemFontOfSize:20];
    labelName.text = @"EatAway";
    labelName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelName];
    
    
    labelTips = [[UILabel alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - 270, WINDOWWIDTH - 40, 20)];
    labelTips.font = [UIFont systemFontOfSize:10];
    labelTips.textColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    labelTips.textAlignment = NSTextAlignmentCenter;
    //---
    [self.view addSubview:labelTips];
    if (ISCHINESE)
    {
        labelTips.text = @"推荐登录方式";
    }
    else
    {
        labelTips.text = @"Recommend Login";
    }
    
    UIButton *btnWeixinLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnWeixinLogin.frame = CGRectMake(20, WINDOWHEIGHT - 270 + 30, WINDOWWIDTH - 40, 45);
    btnWeixinLogin.backgroundColor = [UIColor colorWithRed:132/255.0 green:220/255.0 blue:4/255.0 alpha:1];
    btnWeixinLogin.clipsToBounds = YES;
    btnWeixinLogin.tag = 1;
    [btnWeixinLogin addTarget:self action:@selector(btnWXFBLogin:) forControlEvents:UIControlEventTouchUpInside];
    btnWeixinLogin.layer.cornerRadius = 6;
    //---
    [self.view addSubview:btnWeixinLogin];
    
    labelWeixin = [[UILabel alloc]initWithFrame: CGRectMake(20, WINDOWHEIGHT - 270 + 30, WINDOWWIDTH - 40, 45)];
    labelWeixin.font = [UIFont systemFontOfSize:15];
    labelWeixin.textAlignment = NSTextAlignmentCenter;
    labelWeixin.textColor = [UIColor whiteColor];
    //---

    [self.view addSubview:labelWeixin];
    if (!ISCHINESE)
    {
        labelWeixin.text = @"微 信 登 录";
    }
    else
    {
        labelWeixin.text = @"WeChat";
    }
    
    
    UIImageView *IVWeixin = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Commend-login_WeChat.png"]];
    IVWeixin.frame = CGRectMake((btnWeixinLogin.frame.size.width - 100)/(2 * 2) + 20, WINDOWHEIGHT - 270 + 30 + 10, 25, 25);
    //---

    [self.view addSubview:IVWeixin];
    
    
    
    UIButton *btnFacebookLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnFacebookLogin.frame = CGRectMake(20, WINDOWHEIGHT - 270 + 30 + 45 + 15, WINDOWWIDTH - 40, 45);
    btnFacebookLogin.backgroundColor = [UIColor colorWithRed:21/255.0 green:129/255.0 blue:216/255.0 alpha:1];
    btnFacebookLogin.clipsToBounds = YES;
    btnFacebookLogin.layer.cornerRadius = 6;
    btnFacebookLogin.tag = 2;
//    [btnFacebookLogin addTarget:self action:@selector(fetchFaceBookToken) forControlEvents:UIControlEventTouchUpInside];
    [btnFacebookLogin addTarget:self action:@selector(btnWXFBLogin:) forControlEvents:UIControlEventTouchUpInside];
    //---

    [self.view addSubview:btnFacebookLogin];
    
    UILabel *labelFacebook = [[UILabel alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - 270 + 30 + 45 + 15, WINDOWWIDTH - 40, 45)];
    labelFacebook.font = [UIFont systemFontOfSize:15];
    labelFacebook.textAlignment = NSTextAlignmentCenter;
    labelFacebook.textColor = [UIColor whiteColor];
    //---
    
    [self.view addSubview:labelFacebook];
    labelFacebook.text = @"Facebook";
    
    UIImageView *IVFacebook = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"Commend-login_Facebook.png"]];
    IVFacebook.frame = CGRectMake((btnFacebookLogin.frame.size.width - 100)/(2 * 2) + 20, WINDOWHEIGHT - 270 + 30 + 45 + 15 + 10, 25, 25);
    //---

    [self.view addSubview:IVFacebook];
    
    
    btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(WINDOWWIDTH/2 + 10, WINDOWHEIGHT - 270 + 30 + 45 + 15 + 45 + 15, (WINDOWWIDTH - 40 - 20)/2, 45);
    btnRegister.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    btnRegister.clipsToBounds = YES;
    [btnRegister setTitleColor:[UIColor colorWithWhite:119/255.0 alpha:1] forState:UIControlStateNormal];
    btnRegister.layer.cornerRadius = 6;
    [btnRegister addTarget:self action:@selector(btnRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    if (!ISCHINESE)
    {
        [btnRegister setTitle:@"注册" forState:UIControlStateNormal];
    }
    else
    {
        [btnRegister setTitle:@"Register" forState:UIControlStateNormal];
    }

    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame = CGRectMake(20, WINDOWHEIGHT - 270 + 30 + 45 + 15 + 45 + 15, (WINDOWWIDTH - 40 - 20)/2, 45);
    btnLogin.backgroundColor = [UIColor colorWithWhite:1 alpha:0.5];
    btnLogin.clipsToBounds = YES;
    [btnLogin setTitleColor:[UIColor colorWithWhite:119/255.0 alpha:1] forState:UIControlStateNormal];
    btnLogin.layer.cornerRadius = 6;
    [btnLogin addTarget:self action:@selector(btnLoginClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    if (!ISCHINESE)
    {
        [btnLogin setTitle:@"登录" forState:UIControlStateNormal];
    }
    else
    {
        [btnLogin setTitle:@"Login" forState:UIControlStateNormal];
    }
    
    btnZhong = [UIButton buttonWithType:UIButtonTypeCustom];
    btnZhong.frame = CGRectMake(WINDOWWIDTH - 20 - 60, WINDOWHEIGHT - 50, 30, 20);
    [btnZhong setTitle:@"EN" forState:UIControlStateNormal];
    btnZhong.titleLabel.font = [UIFont systemFontOfSize:12];
    btnZhong.tag = 2;
    [btnZhong addTarget:self action:@selector(btnChangeLanguageCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnZhong];
    
    
    if (!ISCHINESE)
    {
         [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
    }
    else
    {
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    
    UIView *viewl = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 60 + 29, WINDOWHEIGHT -50, 1, 20)];
    viewl.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    [self.view addSubview:viewl];
    
    btnEnglish = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnglish.frame = CGRectMake(WINDOWWIDTH - 20 - 60 + 30, WINDOWHEIGHT - 50, 30, 20);
    [btnEnglish setTitle:@"中" forState:UIControlStateNormal];
    btnEnglish.titleLabel.font = [UIFont systemFontOfSize:12];
    btnEnglish.tag = 1;
    [btnEnglish addTarget:self action:@selector(btnChangeLanguageCLick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnEnglish];
    if (!ISCHINESE)
    {
        
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    }
    else
    {
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
    }
 
    
}
-(void)btnBackClick
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
-(void)btnChangeLanguageCLick:(UIButton *)btn
{
    
    
    if (btn.tag == 2)
    {
        
        [[NSUserDefaults standardUserDefaults] setObject:@"2" forKey:@"language"];
        [btnEnglish setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        [btnZhong setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        
    }
    else if(btn.tag == 1)
    {
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"language"];
        [btnEnglish setTitleColor:MAINCOLOR forState:UIControlStateNormal];
        [btnZhong setTitleColor:[UIColor colorWithWhite:179/255.0 alpha:1] forState:UIControlStateNormal];
        
    }

    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeLanguage" object:nil];
}
-(void)btnRegisterClick
{
    RegisterViewController *RVC = [[RegisterViewController alloc]init];
    [self.navigationController pushViewController:RVC animated:YES];
}
-(void)btnLoginClick
{
    LoginWithPhoneViewController *LWPVC = [[LoginWithPhoneViewController alloc]init];
    [self.navigationController pushViewController:LWPVC animated:YES];
}

-(void)btnWXFBLogin:(UIButton *)btn
{

    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    SSDKPlatformType type;
    if (btn.tag == 1)
    {
        type = SSDKPlatformTypeWechat;
    }
    else
    {
        type = SSDKPlatformTypeFacebook;
    }
    

    
    
    [ShareSDK getUserInfo:type
           onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error)
     {
         if (state == SSDKResponseStateSuccess)
         {
             
             NSLog(@"uid=%@",user.uid);
             NSLog(@"%@",user.credential);
             NSLog(@"token=%@",user.credential.token);
             NSLog(@"nickname=%@",user.nickname);
             
             NSString *strPlatform;
             if (type == SSDKPlatformTypeWechat)
             {
                 strPlatform = @"wechat";
             }
             else
             {
                 strPlatform = @"facebook";
             }
             
             NSString *nickname = user.nickname;
             NSString *openid = user.uid;
             
             __weak RecommendLoginViewController *blockSelf = self;
             
             [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/third_login" parameter:@{@"type":strPlatform,@"openid":openid,@"username":nickname} resultBlock:^(NSDictionary *resultDic) {
                 [progress hide:YES];
                 if (resultDic == nil)
                 {
                     [TotalFunctionView alertContent:ZEString(@"登录失败，请检查网络连接", @"login failed,please check the network connection") onViewController:blockSelf];
                 }
                 else if ([resultDic[@"status"] isEqual:@(1)])
                 {
                     progress = [MBProgressHUD showHUDAddedTo:blockSelf.view animated:YES];
                     [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"userid"] forKey:@"userid"];
                     [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"token"] forKey:@"token"];
                     [blockSelf dismissViewControllerAnimated:YES completion:^{
                         [progress hide:YES];
                     }];
                 }
                 else
                 {
                     [TotalFunctionView alertContent:ZEString(@"登录失败，请检查网络连接", @"login failed,please check the network connection") onViewController:blockSelf];
                 }
             }];
             
             
         }
         else
         {
             [progress hide:YES];
             NSLog(@"%@",error);
         }
         
     }];
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
