//
//  RegisterViewController.m
//  EatAway
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "RegisterViewController.h"

#import "PhoneLoginTextFieldView.h"
#import "CheckBoxButton.h"
#import "CheckNumTextFieldView.h"

#import "LoginWithPhoneViewController.h"

#import <SMS_SDK/SMSSDK.h>
#import <MBProgressHUD.h>
#import<CommonCrypto/CommonDigest.h>
#import "ServiceTermsViewController.h"

@interface RegisterViewController ()<UITextFieldDelegate>
{
    PhoneLoginTextFieldView *viewUsername;
    PhoneLoginTextFieldView *viewPassword;
    PhoneLoginTextFieldView *viewPasswordAgain;
    CheckNumTextFieldView *checkNumView;
    UILabel *labelText;
    UIButton *btnForRead;
    UIButton *btnLogin;
    UIButton *btnRegister;
    UIButton *btnZhong;
    UIButton *btnEnglish;
    
    NSString *strCheckedPhoneNum;
    
    
    CheckBoxButton *btnAgree;
    
    MBProgressHUD *progress;
    
}
@end

@implementation RegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (ISCHINESE)
    {
        self.title = @"注册";
    }
    else
    {
        self.title = @"Sign up";
    }
    self.view.backgroundColor = [UIColor whiteColor];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];

    strCheckedPhoneNum = @"780412";
    
    [self navigationBarInit];
    [self viewInit];
    
    NSLog(@"userid = %@,token = %@",USERID,TOKEN);
    
}
-(void)changeLanguage
{
    
    if (ISCHINESE)
    {
        self.title = @"注册";
        viewUsername.textField.placeholder = @"请输入手机号";
        viewPassword.textField.placeholder = @"请输入密码";
        viewPasswordAgain.textField.placeholder = @"请再次输入密码";
        [btnLogin setTitle:@"点此登录" forState:UIControlStateNormal];
        labelText.text = @"我已阅读并同意";
        checkNumView.textField.placeholder = @"请输入验证码";
        [checkNumView.button setTitle:@"发送验证码" forState:UIControlStateNormal];
        CGSize size = [self sizeOfString:@"我已阅读并同意" fontSize:11];
        [btnRegister setTitle:@"注 册" forState:UIControlStateNormal]; ;
        labelText.frame = CGRectMake(labelText.frame.origin.x, labelText.frame.origin.y, size.width , 15);
        CGFloat fromHeight;
        if (WINDOWHEIGHT<=568)
        {
            fromHeight = 340;
        }
        else
        {
            fromHeight = 400;
        }
        btnForRead.frame = CGRectMake(20 + 15 + labelText.frame.size.width + 2, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5 + 15 + 10 + 45 + 4, 150, 15);
        [btnForRead setTitle:@"《EatAway 服务条款》" forState:UIControlStateNormal]; ;
    }
    else
    {
        self.title = @"Sign up";
        viewUsername.textField.placeholder = @"Phone Number";
        viewPassword.textField.placeholder = @"Password";
        viewPasswordAgain.textField.placeholder = @"Password Again";
        [btnLogin setTitle:@"Login" forState:UIControlStateNormal];
        labelText.text = @"I have read and agree";
        if (self.view.frame.size.height <= 568)
        {
            checkNumView.textField.placeholder = @"Code";
        }
        else
        {
            checkNumView.textField.placeholder = @"Verification code";
        }
        [checkNumView.button setTitle:@"Obtain" forState:UIControlStateNormal];
        CGSize size = [self sizeOfString:@"I have read and agree" fontSize:11];
        [btnRegister setTitle:@"Sing up" forState:UIControlStateNormal]; ;
        labelText.frame = CGRectMake(labelText.frame.origin.x, labelText.frame.origin.y, size.width , 15);
        CGFloat fromHeight;
        if (WINDOWHEIGHT<=568)
        {
            fromHeight = 340;
        }
        else
        {
            fromHeight = 400;
        }
        btnForRead.frame = CGRectMake(20 + 15 + labelText.frame.size.width + 2, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5 + 15 + 10 + 45 + 4, 150, 15);
        [btnForRead setTitle:@"\"EatAway Terms Of Service\"" forState:UIControlStateNormal]; ;
    }

    
}
-(void)navigationBarInit
{
    UIView *viewnavigationBarBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewnavigationBarBG.backgroundColor = [UIColor colorWithWhite:247/255.0 alpha:1];
    [self.view addSubview:viewnavigationBarBG];
    
    UIBarButtonItem *itemBack = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"Login_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnBackClick)];
    self.navigationItem.leftBarButtonItem = itemBack;

}
-(void)viewInit
{
    UIImageView *IVLogo = [[UIImageView alloc]initWithFrame:CGRectMake((WINDOWWIDTH-90)/2, 100, 90, 90)];
    IVLogo.image = [UIImage imageNamed:@"Login_logo.png"];
    [self.view addSubview:IVLogo];
    
    UILabel *labelName = [[UILabel alloc]initWithFrame:CGRectMake((WINDOWWIDTH - 90)/2, 100 + 90 + 10, 90, 20)];
    labelName.font = [UIFont systemFontOfSize:20];
    labelName.text = @"EatAway";
    labelName.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelName];

    CGFloat fromHeight;
    if (WINDOWHEIGHT<=568)
    {
        fromHeight = 340;
    }
    else
    {
        fromHeight = 400;
    }
    
    
    viewUsername = [[PhoneLoginTextFieldView alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - fromHeight, WINDOWWIDTH - 40, 45)];
    viewUsername.imageV.image = [UIImage imageNamed:@"Login_icon_user.png"];
    viewUsername.textField.delegate = self;
    viewUsername.textField.tag = 1;
    [self.view addSubview:viewUsername];
    if (ISCHINESE)
    {
        viewUsername.textField.placeholder = @"请输入手机号";
    }
    else
    {
        viewUsername.textField.placeholder = @"Phone Number";
    }
    
    checkNumView = [[CheckNumTextFieldView alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - fromHeight + 45 + 15, WINDOWWIDTH - 40, 45)];
    checkNumView.imageV.image = [UIImage imageNamed:@"Regist_icon_user.png"];
    checkNumView.textField.delegate = self;
    checkNumView.textField.tag = 1;
    [checkNumView.button addTarget:self action:@selector(btnSendCheckNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:checkNumView];
    if (ISCHINESE)
    {
        checkNumView.textField.placeholder = @"请输入验证码";
        [checkNumView.button setTitle:@"发送验证码" forState:UIControlStateNormal];
    }
    else
    {
        if (self.view.frame.size.height <= 568)
        {
            checkNumView.textField.placeholder = @"Code";
        }
        else
        {
            checkNumView.textField.placeholder = @"Verification code";
        }
        [checkNumView.button setTitle:@"Obtain" forState:UIControlStateNormal];
    }
    
    viewPassword = [[PhoneLoginTextFieldView alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15, WINDOWWIDTH - 40, 45)];
    viewPassword.imageV.image = [UIImage imageNamed:@"Login_icon_password.png"];
    viewPassword.textField.secureTextEntry = YES;
    [self.view addSubview:viewPassword];
    if (ISCHINESE)
    {
        viewPassword.textField.placeholder = @"请输入密码(不得少于6位)";
    }
    else
    {
        viewPassword.textField.placeholder = @"Password(More than 6 characters)";
    }

    
    viewPasswordAgain = [[PhoneLoginTextFieldView alloc]initWithFrame:CGRectMake(20, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15, WINDOWWIDTH - 40, 45)];
    viewPasswordAgain.imageV.image = [UIImage imageNamed:@"Login_icon_password.png"];
    viewPasswordAgain.textField.secureTextEntry = YES;
    [self.view addSubview:viewPasswordAgain];
    if (ISCHINESE)
    {
        viewPasswordAgain.textField.placeholder = @"请再次输入密码";
    }
    else
    {
        viewPasswordAgain.textField.placeholder = @"Password Again";
    }
    
    btnLogin = [UIButton buttonWithType:UIButtonTypeCustom];
    btnLogin.frame = CGRectMake(WINDOWWIDTH- 100 - 20,WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5, 100, 15);
    btnLogin.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [btnLogin setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btnLogin.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnLogin addTarget:self action:@selector(btnGoToLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnLogin];
    if(ISCHINESE)
    {
        [btnLogin setTitle:@"点此登录" forState:UIControlStateNormal]; ;
    }
    else
    {
        [btnLogin setTitle:@"Login" forState:UIControlStateNormal]; ;
    }
    
    btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(20, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5 + 15 + 10, WINDOWWIDTH - 40, 45);
    btnRegister.backgroundColor = MAINCOLOR;
    btnRegister.clipsToBounds = YES;
    btnRegister.layer.cornerRadius = 7;
    [btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(btnRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    if(ISCHINESE)
    {
        [btnRegister setTitle:@"注 册" forState:UIControlStateNormal]; ;
    }
    else
    {
        [btnRegister setTitle:@"Sign up" forState:UIControlStateNormal]; ;
    }
    
    btnAgree = [CheckBoxButton buttonWithType:UIButtonTypeCustom];
    btnAgree.frame = CGRectMake(20, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5 + 15 + 10 + 45 + 5, 13, 13);
    [btnAgree setImage:[UIImage imageNamed:@"Regist_Marquee_sel.png"] forState:UIControlStateNormal];
    btnAgree.isChecked = YES;
    [btnAgree addTarget:self action:@selector(btnAgreeClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnAgree];
    
    labelText = [[UILabel alloc]initWithFrame:CGRectMake(20 + 15, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5 + 15 + 10 + 45 + 4, 100, 15)];
    labelText.font = [UIFont systemFontOfSize:11];
//    [labelText sizeToFit];
    labelText.textColor = [UIColor colorWithWhite:230/255.0 alpha:1];
    [self.view addSubview:labelText];
    if(ISCHINESE)
    {
        labelText.text = @"我已阅读并同意";
        CGSize size = [self sizeOfString:@"我已阅读并同意" fontSize:11];
        labelText.frame = CGRectMake(labelText.frame.origin.x, labelText.frame.origin.y, size.width , 15);
        
    }
    else
    {
        labelText.text = @"I have read and agreed";
        CGSize size = [self sizeOfString:@"I have read and agreed" fontSize:11];
        labelText.frame = CGRectMake(labelText.frame.origin.x, labelText.frame.origin.y, size.width , 15);
    }
    
    btnForRead = [UIButton buttonWithType:UIButtonTypeCustom];
    btnForRead.frame = CGRectMake(20 + 15 + labelText.frame.size.width + 2, WINDOWHEIGHT - fromHeight + 45 + 15 + 45 + 15 + 45 + 15 + 45 + 5 + 15 + 10 + 45 + 4, 150, 15);
    btnForRead.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [btnForRead setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    btnForRead.titleLabel.font = [UIFont systemFontOfSize:11];
    [btnForRead addTarget:self action:@selector(selectService) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnForRead];
    if(ISCHINESE)
    {
        [btnForRead setTitle:@"《EatAway 服务条款》" forState:UIControlStateNormal]; ;
    }
    else
    {
        [btnForRead setTitle:@"<EatAway terms of service>" forState:UIControlStateNormal]; ;
    }
    
    CGFloat zhongEnglishHei;
    if (WINDOWHEIGHT<=568)
    {
        zhongEnglishHei = 25;
    }
    else
    {
        zhongEnglishHei = 50;
    }
    
    btnZhong = [UIButton buttonWithType:UIButtonTypeCustom];
    btnZhong.frame = CGRectMake(WINDOWWIDTH - 20 - 60,WINDOWHEIGHT - zhongEnglishHei, 30, 20);
    [btnZhong setTitle:@"中" forState:UIControlStateNormal];
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
    
    UIView *viewl = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 20 - 60 + 29,WINDOWHEIGHT - zhongEnglishHei, 1, 20)];
    viewl.backgroundColor = [UIColor colorWithWhite:179/255.0 alpha:1];
    [self.view addSubview:viewl];
    
    btnEnglish = [UIButton buttonWithType:UIButtonTypeCustom];
    btnEnglish.frame = CGRectMake(WINDOWWIDTH - 20 - 60 + 30, WINDOWHEIGHT - zhongEnglishHei, 30, 20);
    [btnEnglish setTitle:@"EN" forState:UIControlStateNormal];
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

-(void)selectService
{
    ServiceTermsViewController *serviceVC = [ServiceTermsViewController new];
    [self.navigationController pushViewController:serviceVC animated:YES];
}
-(void)btnBackClick
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)btnAgreeClick
{
    btnAgree.isChecked = !btnAgree.isChecked;
    
    if (btnAgree.isChecked)
    {
        [btnAgree setImage:[UIImage imageNamed:@"Regist_Marquee_sel.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnAgree setImage:[UIImage imageNamed:@"Regist_Marquee_nor.png"] forState:UIControlStateNormal];
    }
    
    
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
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if(textField.tag == 1)
    {
        //        NSLog(@"range.location = %ld,rang.length = %ld,string = %@",range.location,range.length,string);
        NSArray *arr = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
        if (range.length == 1 && [string isEqualToString:@""])
        {
            return YES;
        }
        else if(textField.text.length>= 11)
        {
            return NO;
        }
        else if ([arr containsObject:string])
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else
    {
        return YES;
    }
}
-(void)btnSendCheckNumClick:(UIButton *)btn
{
    __weak RegisterViewController *blockSelf = self;
    
    if(viewUsername.textField.text.length <9)
    {
        [TotalFunctionView alertContent:@"您输入的手机号码有误" onViewController:self];
    }
    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/veri_mobile" parameter:@{@"mobile":viewUsername.textField.text} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"发送验证码失败，请检查网络连接", @"Send verification code failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(2)])
            {
                [TotalFunctionView alertContent:ZEString(@"该手机号已被注册", @"this phone number has been registered") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(4)] ||[resultDic[@"status"] isEqual:@(5)]  )
            {
                [TotalFunctionView alertContent:ZEString(@"该手机号格式不正确", @"wrong phone number") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(3)])
            {
                [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:viewUsername.textField.text zone:@"61" result:^(NSError *error) {
                    
                    if (!error)
                    {
                        strCheckedPhoneNum = viewUsername.textField.text;
                        NSTimeInterval period = 1.0; //设置时间间隔
                        __block int a = 60
                        ;
                        dispatch_queue_t queue = dispatch_get_main_queue();
                        
                        dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
                        
                        dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0); //每秒执行
                        
                        dispatch_source_set_event_handler(_timer, ^{
                            
                            
                            a = a - 1;
                            
                            NSString *strZ = [NSString stringWithFormat:@"%d秒后可再次发送",a];
                            NSString *strE = [NSString stringWithFormat:@"send again after %d seconds",a];
                            [btn setTitle:ZEString(strZ, strE) forState:UIControlStateNormal];
                            
                            
                            if (a == 0)
                            {
                                dispatch_cancel(_timer);
                                btn.enabled = YES;
                                //            btn.backgroundColor = [UIColor colorWithRed:0 green:238/255.0 blue:179/255.0 alpha:1];
                                [btn setTitle:ZEString(@"重新发送验证码", @"send again") forState:UIControlStateNormal ];
                                
                            }
                        });
                        dispatch_resume(_timer);
                    }
                    else
                    {
                        [TotalFunctionView alertContent:ZEString(@"发送短信失败，请检查手机号码并尝试重新发送", @"Send message failed, please check the phone number and send again")  onViewController:blockSelf];
                    }
                }];
                
                
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"发送验证码失败，请检查网络连接", @"Send verification code failed, please check the network connection") onViewController:blockSelf];
            }
        }];
        

    }
    
 
}
-(void)btnGoToLogin
{
    LoginWithPhoneViewController *LVPVC = [[LoginWithPhoneViewController alloc]init];
    [self.navigationController pushViewController:LVPVC animated:YES];
}
-(void)btnRegisterClick
{
    __block RegisterViewController *blockSelf = self;
    if(viewUsername.textField.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请填写手机号码", @"Please fill in the phone number") onViewController:self];
    }
    else if (![strCheckedPhoneNum isEqualToString:viewUsername.textField.text])
    {
        [TotalFunctionView alertContent:ZEString(@"手机号错误", @"wrong phone number") onViewController:self];
    }
    else if (viewPassword.textField.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入密码", @"please enter the password") onViewController:self];
    }
    else if (viewPassword.textField.text.length < 6)
    {
        [TotalFunctionView alertContent:ZEString(@"密码不得少于六位", @"Password length is less than six") onViewController:self];
    }
    else if (viewPasswordAgain.textField.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请再次输入密码", @"please enter the password again") onViewController:self];
    }
    else if (![viewPasswordAgain.textField.text isEqualToString:viewPasswordAgain.textField.text])
    {
        [TotalFunctionView alertContent:ZEString(@"密码输入不一致", @"passwords do not match") onViewController:self];
    }

    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [SMSSDK commitVerificationCode:checkNumView.textField.text phoneNumber:strCheckedPhoneNum zone:@"61" result:^(NSError *error) {
            [progress hide:YES];
            if (!error)
            {
                progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
                [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/register" parameter:@{@"mobile":viewUsername.textField.text,@"password":[blockSelf md5:[NSString stringWithFormat:@"%@EatAway",viewPassword.textField.text]]} resultBlock:^(NSDictionary *resultDic) {
                    [progress hide:YES];
                    if(resultDic == nil)
                    {
                        [TotalFunctionView alertContent:ZEString(@"注册失败，请检查网络连接", @"Sign up failed, please check the network connection") onViewController:blockSelf];
                    }
                    else if ([resultDic[@"status"] isEqual:@(1)])
                    {

                        if ([blockSelf.delegate respondsToSelector:@selector(RegisterSucceedWithPhoneNum:)])
                        {

                            
                            [blockSelf.delegate RegisterSucceedWithPhoneNum:viewUsername.textField.text];
                            [blockSelf.navigationController popViewControllerAnimated:YES];
                        }
                        else
                        {
                            LoginWithPhoneViewController *LWVC = [[LoginWithPhoneViewController alloc]init];
                            LWVC.RegisterVC = blockSelf;
                            LWVC.phoneNum = viewUsername.textField.text;
                            [blockSelf.navigationController pushViewController:LWVC animated:YES];
                        }
                        
                        
                    }
                    else
                    {
                        [TotalFunctionView alertContent:ZEString(@"注册失败，请检查网络连接", @"Sign up failed, please check the network connection") onViewController:blockSelf];
                    }
                    
                    
                }];
                
                
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"验证码错误", @"Verification code error") onViewController:blockSelf];
            }
        }];
    }
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(999,15) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
}
- (NSString *) md5:(NSString *) input
{
    
    const char *cStr = [input UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, strlen(cStr), digest ); // This is the md5 call

    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
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
