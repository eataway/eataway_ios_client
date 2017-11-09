//
//  ChangeNumberViewController.m
//  EatAway
//
//  Created by BossWang on 17/7/5.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ChangeNumberViewController.h"

#import <MBProgressHUD.h>
#import <SMS_SDK/SMSSDK.h>

@interface ChangeNumberViewController ()<UITextFieldDelegate>

@end

@implementation ChangeNumberViewController
{
    UIView *viewNCBarUnder;
    MBProgressHUD *progress;
    NSString *strCheckedPhoneNum;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:viewNCBarUnder];
    strCheckedPhoneNum = @"NO";
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.title = ZEString(@"换绑手机号", @"Change Phone Number");
    strCheckedPhoneNum = @"780412";
    [self createUI];
}

- (void)createUI{
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, 80, WINDOWWIDTH, 101)];
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
//    UILabel *phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(14, 10, 70, 30)];
//    phoneLab.textColor = EWColor(51, 51, 51, 1);
//    phoneLab.text = ZEString(@"手机号", @"Phone");
//    phoneLab.font = [UIFont systemFontOfSize:15];
//    phoneLab.textAlignment = NSTextAlignmentLeft;
//    [whiteView addSubview:phoneLab];
    
    self.phoneField = [[UITextField alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 30)];
    self.phoneField.placeholder = ZEString(@"请输入新手机号", @"Please enter a new phone number");
    self.phoneField.textAlignment = NSTextAlignmentLeft;
    self.phoneField.textColor = EWColor(102, 102, 102, 1);
    self.phoneField.font = [UIFont systemFontOfSize:15];
    self.phoneField.delegate = self;
    self.phoneField.tag = 1;
    [whiteView addSubview:self.phoneField];
    
    UIView *lineVIew = [[UIView alloc]initWithFrame:CGRectMake(0, 50, WINDOWWIDTH, 1)];
    lineVIew.backgroundColor = EWColor(240, 240, 240, 1);
    [whiteView addSubview:lineVIew];
    
//    UILabel *CAPTCHALab = [[UILabel alloc]initWithFrame:CGRectMake(14, 61, 70, 30)];
//    CAPTCHALab.textColor = EWColor(51, 51, 51, 1);
//    CAPTCHALab.font = [UIFont systemFontOfSize:15];
//    CAPTCHALab.textAlignment = NSTextAlignmentLeft;
//    CAPTCHALab.text = ZEString(@"验证码", @"Verification code");
//    [whiteView addSubview:CAPTCHALab];
    
    UITextField *CaptchaField = [[UITextField alloc]initWithFrame:CGRectMake(10, 61, WINDOWWIDTH - 20, 30)];
    self.TFCheckBox = CaptchaField;
    CaptchaField.delegate = self;
    CaptchaField.tag = 1;
//    CaptchaField.placeholder = ZEString(@"请输入验证码", @"Please enter code");
    CaptchaField.textAlignment = NSTextAlignmentLeft;
    CaptchaField.textColor = EWColor(102, 102, 102, 1);
    CaptchaField.font = [UIFont systemFontOfSize:15];
    [whiteView addSubview:CaptchaField];
    
    UIView *verticalLineView = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 131, 66, 1, 20)];
    verticalLineView.backgroundColor = EWColor(102, 102, 102, 1);
    [whiteView addSubview:verticalLineView];
    
    UIButton *getCaptchaBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    getCaptchaBtn.frame = CGRectMake(WINDOWWIDTH - 120, 61, 110, 30);
    getCaptchaBtn.titleLabel.numberOfLines = 2;
    [getCaptchaBtn setTitle:ZEString(@"发送验证码", @"Send Code") forState:UIControlStateNormal];
    [getCaptchaBtn setTitleColor:EWColor(51, 51, 51, 1) forState:UIControlStateNormal];
    getCaptchaBtn.titleLabel.font = [UIFont systemFontOfSize:13];
//    getCaptchaBtn.layer.borderWidth = 1;
    getCaptchaBtn.layer.borderColor = [[UIColor grayColor]CGColor];
    [getCaptchaBtn addTarget:self action:@selector(btnSendCheckNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView addSubview:getCaptchaBtn];
    
    UIButton *btnRegister = [UIButton buttonWithType:UIButtonTypeCustom];
    btnRegister.frame = CGRectMake(20, 110 + 80, WINDOWWIDTH - 40, 45);
    btnRegister.backgroundColor = MAINCOLOR;
    btnRegister.clipsToBounds = YES;
    btnRegister.layer.cornerRadius = 7;
    [btnRegister setTitle:ZEString(@"确定", @"Done") forState:UIControlStateNormal];
    [btnRegister setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnRegister addTarget:self action:@selector(btnRegisterClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnRegister];
    
}

- (void)getCaptchaClick:(UIButton *)sender{
    
    
    [SMGlobalMethod startTime:sender];
    
    if ([self.changeNumberDelegate respondsToSelector:@selector(changeNumber:)]) {
        [self.changeNumberDelegate changeNumber:self.phoneField.text];
    }
    
}
-(void)btnSendCheckNumClick:(UIButton *)btn
{
    __weak ChangeNumberViewController *blockSelf = self;
    
    if(self.phoneField.text.length <10)
    {
        [TotalFunctionView alertContent:@"您输入的手机号码有误" onViewController:self];
    }
    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/veri_mobile" parameter:@{@"mobile":self.phoneField.text} resultBlock:^(NSDictionary *resultDic) {
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
                [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:self.phoneField.text zone:@"61" result:^(NSError *error) {
                    
                    if (!error)
                    {
                        strCheckedPhoneNum = self.phoneField.text;
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
-(void)btnRegisterClick
{
    __block ChangeNumberViewController *blockSelf = self;
    if(self.phoneField.text.length == 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请填写手机号码", @"Please fill in the phone number") onViewController:self];
    }
    else if ([strCheckedPhoneNum isEqualToString:@"NO"])
    {
        [TotalFunctionView alertContent:ZEString(@"请发送验证码", @"Please send verification") onViewController:self];
    }
    else if (![strCheckedPhoneNum isEqualToString:self.phoneField.text])
    {
        [TotalFunctionView alertContent:ZEString(@"手机号错误", @"wrong phone number") onViewController:self];
    }
    else if (self.TFCheckBox.text.length <= 0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入验证码", @"Please enter the verification") onViewController:self];
    }
    else
    {
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [SMSSDK commitVerificationCode:self.TFCheckBox.text phoneNumber:strCheckedPhoneNum zone:@"61" result:^(NSError *error) {
            [progress hide:YES];
            if (!error)
            {
                [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/editmobile" parameter:@{@"userid":USERID,@"token":TOKEN,@"mobile":self.phoneField.text} resultBlock:^(NSDictionary *resultDic) {
                    [progress hide:YES];
                    if(resultDic == nil)
                    {
                        [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
                    }
                    else if ([resultDic[@"status"] isEqual:@(1)])
                    {
                        [blockSelf.changeNumberDelegate changeNumber:self.phoneField.text];
                        [[NSUserDefaults standardUserDefaults] setObject:self.phoneField.text  forKey:@"phonenumber"];
                        [blockSelf.navigationController popViewControllerAnimated:YES];
                        
                    }
                    else
                    {
                        [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
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

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
