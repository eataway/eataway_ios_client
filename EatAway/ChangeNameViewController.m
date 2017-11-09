//
//  ChangeNameViewController.m
//  EatAway
//
//  Created by BossWang on 17/7/5.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ChangeNameViewController.h"

#import <MBProgressHUD.h>

@interface ChangeNameViewController ()
{
    MBProgressHUD *progress;
}
@end

@implementation ChangeNameViewController
{
    UIView *viewNCBarUnder;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    self.title = @"修改用户名";
    [self.view addSubview:viewNCBarUnder];
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    [self createUI];
}


- (void)createUI{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(20, 100, WINDOWWIDTH - 40, 50)];
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 5;
    whiteView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:whiteView];
    
    UILabel *changeName = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 90, 30)];
    changeName.textColor = EWColor(51, 51, 51, 1);
    changeName.textAlignment = NSTextAlignmentLeft;
    changeName.font = [UIFont systemFontOfSize:15];
    changeName.text = @"修改用户名";
    [whiteView addSubview:changeName];
    
    self.nameField = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(changeName.frame), 10, WINDOWWIDTH - 150, 30)];
    self.nameField.placeholder = @"请输入用户名";
    self.nameField.textColor = EWColor(102, 102, 102, 1);
    self.nameField.font = [UIFont systemFontOfSize:15];
    [whiteView addSubview:self.nameField];
    
    UIButton *saveBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    saveBtn.frame = CGRectMake(WINDOWWIDTH / 2 - 35, CGRectGetMaxY(whiteView.frame) + 100, 70, 50);
    [saveBtn setTitle:@"保存" forState:UIControlStateNormal];
    [saveBtn setTitleColor:EWColor(102, 102, 102, 1) forState:UIControlStateNormal];
    saveBtn.clipsToBounds = YES;
    saveBtn.layer.cornerRadius = 5;
        saveBtn.backgroundColor = [UIColor whiteColor];
    [saveBtn addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:saveBtn];
    
}

- (void)saveClick:(UIButton *)sender{
    
//    [self.navigationController popViewControllerAnimated:YES];
    
//    
//    NSMutableDictionary *params = [NSMutableDictionary dictionary];
//    params[@"userid"] = USERID;
//    params[@"username"] = self.nameField.text;
//    params[@"token"] = TOKEN;
//    
//   [HWHttpTool post:Server_EditUsername params:params success:^(id json) {
//       
//            
//           [SVProgressHUD showInfoWithStatus:@"修改成功"];
//           [self.navigationController popViewControllerAnimated:YES];
//           if ([self.changeNameDelegate respondsToSelector:@selector(changeNameStr:)]) {
//               [self.changeNameDelegate changeNameStr:self.nameField.text];
//         
//       }
//   } failure:^(NSError *error) {
//       
//   }];
//    
//    NSLog(@"保存按钮的点击事件");
    
    
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else if (self.nameField.text.length<=0)
    {
        [TotalFunctionView alertContent:ZEString(@"请输入新的用户名", @"Please enter a new username") onViewController:self];
    }
    else
    {
        __weak ChangeNameViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/edit_username" parameter:@{@"userid":USERID,@"token":TOKEN,@"username":self.nameField.text} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if (resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                [[NSUserDefaults standardUserDefaults] setObject:self.nameField.text forKey:@"nickname"];
                if ([blockSelf.changeNameDelegate respondsToSelector:@selector(changeNameStr:)])
                {
                    [blockSelf.changeNameDelegate changeNameStr:self.nameField.text];
                }
                [blockSelf.navigationController popViewControllerAnimated:YES];
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"修改失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
            }
        }];
    }
    
    

}

- (void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}


@end
