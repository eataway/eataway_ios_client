//
//  MerchantCartViewController.m
//  EatAway
//
//  Created by apple on 2017/6/26.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MerchantCartViewController.h"

#import "MerchantCartTableViewCell.h"

@interface MerchantCartViewController ()<UITableViewDelegate,UITableViewDataSource,MerchantCartTableViewCellDelegate>
{
    UIButton *btnDismiss;
    UIView *viewWhiteBG;
    UITableView *_tableView;
    
    NSString *_strFoodID;

}
@end

@implementation MerchantCartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.dicList = [[NSMutableDictionary alloc]init];
    
    self.view.backgroundColor = [UIColor clearColor];
    btnDismiss = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDismiss.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    btnDismiss.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT - 50);
    [btnDismiss addTarget:self action:@selector(btnDismissClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDismiss];
    
//    UIView *viewBottom = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 45 - 30, WINDOWWIDTH, 30)];
//    viewBottom.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
//    [self.view addSubview:viewBottom];
//    
//    viewWhiteBG = [[UIView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 45 - 30 - 50 - 30, WINDOWWIDTH, 30 + 50)];
//    viewWhiteBG.backgroundColor = [UIColor whiteColor];
//    viewWhiteBG.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
//    [self.view addSubview:viewWhiteBG];
    
    
    [self tableViewInit];
    
}

-(void)tableViewInit
{
    CGFloat height = 60 + 50 * self.dicList.allKeys.count;

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, WINDOWHEIGHT - 60 - 45 - 50 * self.dicList.allKeys.count, WINDOWWIDTH, height) style:UITableViewStyleGrouped];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.bounces = NO;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dicList.allKeys.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MerchantCartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[MerchantCartTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    NSString *strFoodID = self.dicList.allKeys[indexPath.row];
    NSDictionary *dic = self.dicList[strFoodID];
    [cell setContentWithTitle:dic[@"name"] num:dic[@"count"] price:dic[@"price"] foodID:strFoodID image:dic[@"image"]];
    return cell;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    return view;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *view = [[UIView alloc]init];
    view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    return view;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30;
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 30;
}
-(void)refreshListWithCartDic:(NSMutableDictionary *)dic  all:(BOOL)allPage
{
//    [self.dicList removeAllObjects];
    self.dicList = dic;
    [_tableView reloadData];
    CGFloat height = 60 + 50 * self.dicList.allKeys.count;
    CGFloat Y = WINDOWHEIGHT - 60 - 45 - 50 * dic.allKeys.count;
    

    
    if (!allPage)
    {
        btnDismiss.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT - 50);
        
    }
    else
    {
        btnDismiss.frame = CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64 - 50);
    }

    if (!allPage)
    {
        if (Y < 0)
        {
            Y = 0;
            height = WINDOWHEIGHT - 45;
        }
    }
    else
    {
        if (Y < 64)
        {
            Y = 64;
            height = WINDOWHEIGHT - 45 - 64;

        }
    }
    _tableView.frame = CGRectMake(0,Y , WINDOWWIDTH,height);
    
    [_tableView reloadData];
    
}
-(void)MerchantCartTableViewCellChangeFoodNumber:(NSInteger)strNum foodID:(NSString *)strFoodID foodName:(NSString *)strFoodName foodPrice:(NSString *)strFoodPrice imageURL:(NSString *)strImageURL
{
    NSString *strCount = [NSString stringWithFormat:@"%ld",strNum];
    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    
    [dic setValue:strCount forKey:@"count"];
    [dic setValue:strFoodName forKey:@"name"];
    [dic setValue:strFoodPrice forKey:@"price"];
    [dic setValue:strImageURL forKey:@"image"];
    
    if ([strCount isEqualToString:@"0"])
    {
        if ([self.dicList.allKeys containsObject:strFoodID])
        {
            [self.dicList removeObjectForKey:strFoodID];
        }
    }
    else
    {
        [self.dicList setValue:dic forKey:strFoodID];
    }

    
    [self.delegate MerchantCartViewControllerChangeDictonary:self.dicList];
}
-(void)btnDismissClick
{
    self.view.hidden = YES;
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
