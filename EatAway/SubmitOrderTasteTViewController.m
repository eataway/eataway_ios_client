//
//  SubmitOrderTasteTViewController.m
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SubmitOrderTasteTViewController.h"

@interface SubmitOrderTasteTViewController ()
{
    UITextField *TFContent;
}

@end

@implementation SubmitOrderTasteTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    btn.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    [btn addTarget:self action:@selector(btnBGClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIView *viewWhiteBG = [[UIView alloc]initWithFrame:CGRectMake((WINDOWWIDTH - 300)/2, (WINDOWHEIGHT - 150)/2, 300, 150)];
    viewWhiteBG.backgroundColor = [UIColor whiteColor];
    viewWhiteBG.clipsToBounds = YES;
    viewWhiteBG.layer.cornerRadius = 15;
    [self.view addSubview:viewWhiteBG];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 49)];
    labelTitle.text = ZEString(@"备注", @"Remarks");
    labelTitle.font = [UIFont systemFontOfSize:13];
    [viewWhiteBG addSubview:labelTitle];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 300, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWhiteBG addSubview:viewDown];
    
    
    TFContent = [[UITextField alloc]initWithFrame:CGRectMake(10, 50 + 10, 280, 30)];
    TFContent.font = [UIFont systemFontOfSize:13];
    TFContent.textAlignment = NSTextAlignmentCenter;
    TFContent.placeholder = ZEString(@"请输入备注", @"Enter remarks");
    [viewWhiteBG addSubview:TFContent];
    
    UIView *viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50 + 49, 300, 1)];
    viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWhiteBG addSubview:viewDown2];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(0, 50 + 50, 149, 50);
    [btnCancel setTitle:ZEString(@"取消", @"Cancel") forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnBGClick) forControlEvents:UIControlEventTouchUpInside];
    [viewWhiteBG addSubview:btnCancel];
    
    UIView *viewDown3 = [[UIView alloc]initWithFrame:CGRectMake(149, 100, 1, 50)];
    viewDown3.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWhiteBG addSubview:viewDown3];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(150, 50 + 50, 149, 50);
    [btnDone setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [btnDone setTitle:ZEString(@"确定", @"Confirm") forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnDone addTarget:self action:@selector(btnDoneSelectTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [viewWhiteBG addSubview:btnDone];
    
    
    
    
}
-(void)btnBGClick
{
    [self.view removeFromSuperview];
}
-(void)btnDoneSelectTimeClick
{
    [self.delegate SubmitOrderTasteTViewControllerResult:TFContent.text];
    [self.view removeFromSuperview];

}

@end
