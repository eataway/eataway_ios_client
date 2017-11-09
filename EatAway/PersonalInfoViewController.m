//
//  PersonalInfoViewController.m
//  EatAway
//
//  Created by apple on 2017/6/16.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "PersonalInfoViewController.h"

#import <UIImageView+WebCache.h>

@interface PersonalInfoViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
    UIImageView *IVHead;
}
@end

@implementation PersonalInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
    self.title = ZEString(@"个人信息", @"User");
    
    
    
    [self tableViewInit];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    

    
}
-(void)tableViewInit
{
    IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 70, 5, 40, 40)];
    IVHead.clipsToBounds = YES;
    IVHead.backgroundColor = [UIColor blueColor];
    IVHead.layer.cornerRadius = 20;
    [IVHead sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] placeholderImage:[UIImage imageNamed:@"2.1.2_icon_head.png"]];
    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 6;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 10;
    }
    else if (indexPath.row == 5)
    {
        return 85;
    }
    else
    {
        return 50;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
            cell.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
        }
        
    }
    else if (indexPath.row == 1 || indexPath.row == 2 || indexPath.row == 3|| indexPath.row == 4)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell1234"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell1234"];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
            [cell addSubview:viewDown];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            
        }
        NSArray *arrTitles = @[ZEString(@"修改头像", @"Replace portrait"),ZEString(@"修改用户名", @"Replace nickname"),ZEString(@"绑定手机号", @"Binding phone number"),ZEString(@"修改密码", @"change password")];
        cell.textLabel.text = arrTitles[indexPath.row - 1];
        
        if (indexPath.row == 2)
        {
            cell.detailTextLabel.text = NICKNAME;
        }
        else if (indexPath.row == 3)
        {
            cell.detailTextLabel.text = PHONENUMBER;
        }
        [IVHead removeFromSuperview];
        if (indexPath.row == 1)
        {
            [cell addSubview:IVHead];
        }
        
        
    }
    else if (indexPath.row == 5)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell05"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell05"];
            cell.backgroundColor = [UIColor colorWithWhite:243/255.0 alpha:1];
            
            UIButton *btnQuit = [UIButton buttonWithType:UIButtonTypeCustom];
            btnQuit.frame = CGRectMake(20, 20, WINDOWWIDTH - 40, 45);
            btnQuit.clipsToBounds = YES;
            btnQuit.layer.cornerRadius = 7;
            btnQuit.backgroundColor = [UIColor whiteColor];
            [btnQuit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
            [btnQuit setTitle:ZEString(@"退出登录", @"Logout") forState:UIControlStateNormal];
            [cell addSubview:btnQuit];
            
        }
        
        
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        cell.textLabel.text = [NSString stringWithFormat:@"%ld",indexPath.row];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
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
