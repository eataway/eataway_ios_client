//
//  FeedbackViewController.m
//  EatAway
//
//  Created by BossWang on 17/7/1.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FeedbackViewController.h"

#import <MBProgressHUD.h>

@interface FeedbackViewController ()<UITextViewDelegate>
{
    UITextView *feedBackTV;
    MBProgressHUD *progress;
}
@property (nonatomic, strong) UIButton *seleBtn;
@property (nonatomic, strong) UIButton *publishBtn;
@end

@implementation FeedbackViewController
{
    UIView *viewNCBarUnder;
}
//- (void)viewWillAppear:(BOOL)animated{
//    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.hidden = NO;
//    self.navigationController.navigationBar.barTintColor = MAINCOLOR;
//    
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = ZEString(@"意见反馈", @"Feedback");
    [self createUI];
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
}

- (void)createUI{
    
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 74, WINDOWWIDTH - 20, 240)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.clipsToBounds = NO;
    whiteView.layer.cornerRadius = 5;
    [self.view addSubview:whiteView];
    
    feedBackTV = [[UITextView alloc]initWithFrame:CGRectMake(2, 2, WINDOWWIDTH - 24, 150)];
    feedBackTV.text = ZEString(@"您有什么意见或建议，可在此反馈（如果您是微信或者FaceBook用户,请留下您的联系方式）...", @"If you have any comments or suggestions, leave feedback here ( If you are WeChat or FaceBook user, Please leave your phone number )...");
    feedBackTV.textColor = EWColor(204, 204, 204, 1);
    feedBackTV.delegate = self;
//    feedBackTV.backgroundColor = [UIColor greenColor];
    feedBackTV.font = [UIFont systemFontOfSize:14];
    [whiteView addSubview:feedBackTV];
    
    self.seleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.seleBtn.frame = CGRectMake(10, CGRectGetMaxY(whiteView.frame) + 10, 14, 14);
    self.seleBtn.backgroundColor = [UIColor colorWithRed:0.59f green:0.82f blue:0.15f alpha:1.00f];
    [self.seleBtn setBackgroundImage:[UIImage imageNamed:@"4.1.4_icon_04"] forState:UIControlStateSelected];
//    [self.seleBtn setImage:[UIImage imageNamed:@"4.1.4_icon_04"] forState:UIControlStateSelected];
    [self.seleBtn addTarget:self action:@selector(seleClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:self.seleBtn];
    
    UILabel *anonymousLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.seleBtn.frame) + 5, CGRectGetMaxY(whiteView.frame) + 10, 100, 14)];
    anonymousLab.text = @"匿名评价";
    anonymousLab.textColor = EWColor(153, 153, 153, 1);
    anonymousLab.textAlignment = NSTextAlignmentLeft;
    anonymousLab.font = [UIFont systemFontOfSize:10];
//    [self.view addSubview:anonymousLab];
    
    self.publishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.publishBtn.frame = CGRectMake(30, WINDOWHEIGHT - 60, WINDOWWIDTH - 60, 40);
    self.publishBtn.clipsToBounds = YES;
    self.publishBtn.layer.cornerRadius = 4;
    self.publishBtn.backgroundColor = [UIColor colorWithRed:0.96f green:0.63f blue:0.20f alpha:1.00f];
    [self.publishBtn setTitle:ZEString(@"发表反馈", @"Submit feedback") forState:UIControlStateNormal];
    [self.publishBtn addTarget:self action:@selector(publishClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.publishBtn];
    
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    
    if ([textView.text isEqualToString:ZEString(@"您有什么意见或建议，可在此反馈（如果您是微信或者FaceBook用户,请留下您的联系方式）...", @"If you have any comments or suggestions, leave feedback here ( If you are WeChat or FaceBook user, Please leave your phone number )...")]) {
        textView.text = @"";
        textView.textColor = EWColor(51, 51, 51, 1);
    }
}

- (void)textViewDidEndEditing:(UITextView *)textView{
    
    if (textView.text.length == 0) {
        textView.text = ZEString(@"您有什么意见或建议，可在此反馈（如果您是微信或者FaceBook用户,请留下您的联系方式）...", @"If you have any comments or suggestions, leave feedback here ( If you are WeChat or FaceBook user, Please leave your phone number )...");
        textView.textColor = EWColor(204, 204, 204, 1);
    }
}
#pragma mark - 选择按钮的点击事件
- (void)seleClick:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected == YES) {
        NSLog(@"-=-=-=-=-=-=-=-=-===-=-=-=-=-==-=-=-=-==-==-==-=-==-=====-=-==-匿名");
    }
}
#pragma mark - 发表反馈的点击事件
- (void)publishClick:(UIButton *)sender
{
    if ([ObjectForUser checkLogin])
    {
        if (feedBackTV.text.length <= 0 || [feedBackTV.text isEqualToString:@"您有什么意见或建议，可在此反馈（如果您是微信或者FaceBook用户,请留下您的联系方式）..."] || [feedBackTV.text isEqualToString:@"If you have any comments or suggestions, leave feedback here ( If you are WeChat or FaceBook user, Please leave your phone number )..."])
        {
            [TotalFunctionView alertContent:ZEString(@"请输入反馈内容", @"Please enter the feedback content" ) onViewController:self];
        }
        else
        {
            progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
            __weak FeedbackViewController *blockSelf = self;
            [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/evaluate/back" parameter:@{@"userid":USERID,@"token":TOKEN,@"content":feedBackTV.text} resultBlock:^(NSDictionary *resultDic)
            {
                [progress hide:YES];
                if(resultDic == nil)
                {
                    [TotalFunctionView alertContent:ZEString(@"反馈失败，请检查网络连接", @"Feedback failed, please check the network connection") onViewController:blockSelf];
                }
                else if ([resultDic[@"status"] isEqual:@(9)])
                {
                    ALERTCLEARLOGINBLOCK
                }
                else if ([resultDic[@"status"] isEqual:@(1)])
                {
                    [TotalFunctionView alertAndDoneWithContent:ZEString(@"反馈成功，感谢您提供的宝贵意见", @"Feedback success, thank you for your valuable feedback") onViewController:blockSelf];
                }
                else
                {
                    [TotalFunctionView alertContent:ZEString(@"反馈失败，请检查网络连接", @"Feedback failed, please check the network connection") onViewController:blockSelf];
                }
            }];

        }
        
    }
    else
    {
        ALERTNOTLOGIN
    }
    
    
    
}

- (void)changeLanguage{
    
    
}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
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
