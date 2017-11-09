//
//  SubmitOrderSelectPayViewController.m
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SubmitOrderSelectPayViewController.h"

#import "SelectPaymentTableViewCell.h"

@interface SubmitOrderSelectPayViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *_tableView;
}
@end

@implementation SubmitOrderSelectPayViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [self tableViewInit];
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
    
    // tableView 偏移20/64适配
    if (@available(iOS 11.0, *)) {
        _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;//UIScrollView也适用
//        _tableView.estimatedRowHeight = 0;

    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //---//
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SelectPaymentTableViewCell *cell;
    if (indexPath.row == 0)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell00"];
        if (!cell)
        {
            cell = [[SelectPaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell00"];
            
            UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 15 - 40, 15 + 15, 40, 30)];
            label.font = [UIFont systemFontOfSize:13];
            label.text = ZEString(@"更多>", @"More");
            label.textColor = [UIColor colorWithWhite:204/255.0 alpha:1];
            [cell addSubview:label];
            
            UIImageView *IV1 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 15 - 40 - 10 - 30, 15 + 20, 30, 20)];
            IV1.image = [UIImage imageNamed:@"2.2.9_icon_05.png"];
            [cell addSubview:IV1];
            
            UIImageView *IV2 = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 15 - 40 - 10 - 30 - 10 - 30, 15 + 20, 30, 20)];
            IV2.image = [UIImage imageNamed:@"2.2.9_icon_06.png"];
            [cell addSubview:IV2];
            
        }
        [cell setcontentWithImage:[UIImage imageNamed:@"2.2.9_icon_01.png"] title:ZEString(@"银行卡支付", @"Bank card")];
        
    }
    else
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (!cell)
        {
            cell = [[SelectPaymentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        }
        NSArray *arrImageName = @[@"2.2.9_icon_03.png",@"2.2.9_icon_04.png"];
        NSArray *arrTitle = @[ZEString(@"微信支付", @"WeChat"),ZEString(@"支付宝支付",@"Alipay")];
        [cell setcontentWithImage:[UIImage imageNamed:arrImageName[indexPath.row - 1]] title:arrTitle[indexPath.row - 1]];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strResult;
    switch (indexPath.row)
    {
        case 0:
            strResult = ZEString(@"银行卡支付/Paypal", @"Bank card/Paypal");
            break;
        case 1:
            strResult = ZEString(@"微信支付", @"WeChat");
            break;
        case 2:
            strResult = ZEString(@"支付宝支付",@"Alipay");
            break;
        default:
            strResult = @"";
            break;
    }
    [self.delegate SubmitOrderSelectPayViewControllerSelectResult:strResult];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)backAction
{
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
