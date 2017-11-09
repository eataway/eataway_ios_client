//
//  SelectDelveryTimeViewController.m
//  EatAway
//
//  Created by apple on 2017/6/29.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "SelectDelveryTimeViewController.h"

@interface SelectDelveryTimeViewController ()<UIScrollViewDelegate>
{
    UIScrollView *SV1;
    UIScrollView *SV2;
    UIScrollView *SV3;
}
@end

@implementation SelectDelveryTimeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    btn.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
    [btn addTarget:self action:@selector(btnBGClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
    UIView *viewWhiteBG = [[UIView alloc]initWithFrame:CGRectMake((WINDOWWIDTH - 300)/2, (WINDOWHEIGHT - 250)/2, 300, 250)];
    viewWhiteBG.backgroundColor = [UIColor whiteColor];
    viewWhiteBG.clipsToBounds = YES;
    viewWhiteBG.layer.cornerRadius = 15;
    [self.view addSubview:viewWhiteBG];
    
    UILabel *labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 49)];
    labelTitle.text = ZEString(@"配送时间", @"Delivery time");
    labelTitle.font = [UIFont systemFontOfSize:13];
    [viewWhiteBG addSubview:labelTitle];
    labelTitle.textAlignment = NSTextAlignmentCenter;
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, 300, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWhiteBG addSubview:viewDown];
    
    
    SV1 = [[UIScrollView alloc]initWithFrame:CGRectMake(50, 50 + 25, 65, 105)];
//    SV1.pagingEnabled = YES;
    SV1.tag = 1;
    SV1.delegate = self;
    SV1.showsVerticalScrollIndicator = NO;
    [viewWhiteBG addSubview:SV1];
    
    NSArray *arr1 = @[@"",ZEString(@"上午", @"AM"),ZEString(@"下午",@"PM"),@""];
    SV1.contentSize = CGSizeMake(65, 35 * 4 + 1);
    for (int a = 0; a < 4 ; a ++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, a * 35, 65, 35)];
        label.text = arr1[a];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [SV1 addSubview:label];

    }
    
    
    
    SV2 = [[UIScrollView alloc]initWithFrame:CGRectMake(50 + 65, 50 + 25, 65, 105)];
//        SV2.pagingEnabled = YES;
    SV2.tag = 2;
    SV2.delegate = self;
    SV2.showsVerticalScrollIndicator = NO;
    [viewWhiteBG addSubview:SV2];
    
    NSArray *arr2 = @[@"",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@""];
    SV2.contentSize = CGSizeMake(65, 35 * 14 );
    for (int a = 0; a < 14 ; a ++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, a * 35, 65, 35)];
        label.text = arr2[a];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [SV2 addSubview:label];
        
    }

    SV3 = [[UIScrollView alloc]initWithFrame:CGRectMake(50 + 65 * 2, 50 + 25, 65, 105)];
//        SV3.pagingEnabled = YES;
    SV3.tag = 2;
    SV3.delegate = self;
    SV3.showsVerticalScrollIndicator = NO;
    [viewWhiteBG addSubview:SV3];
    
    NSArray *arr3 = @[@"",@"00",@"10",@"20",@"30",@"40",@"50",@""];
    SV3.contentSize = CGSizeMake(65, 35 * 8 );
    for (int a = 0; a < 8 ; a ++)
    {
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, a * 35, 65, 35)];
        label.text = arr3[a];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        [SV3 addSubview:label];
        
    }

    
    
    UIView *viewLine1 = [[UIView alloc]initWithFrame:CGRectMake(50, 50 + 25 + 33, 200, 2)];
    viewLine1.backgroundColor = MAINCOLOR;
    [viewWhiteBG addSubview:viewLine1];
    
    UIView *viewLine2 = [[UIView alloc]initWithFrame:CGRectMake(50,50 + 25 + 35 + 33, 200, 2)];
    viewLine2.backgroundColor = MAINCOLOR;
    [viewWhiteBG addSubview:viewLine2];
    

    
    UIView *viewDown2 = [[UIView alloc]initWithFrame:CGRectMake(0, 50 + 149, 300, 1)];
    viewDown2.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWhiteBG addSubview:viewDown2];
    
    UIButton *btnCancel = [UIButton buttonWithType:UIButtonTypeCustom];
    btnCancel.frame = CGRectMake(0, 50 + 150, 149, 50);
    [btnCancel setTitle:ZEString(@"取消", @"Cancel") forState:UIControlStateNormal];
    btnCancel.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnCancel setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnCancel addTarget:self action:@selector(btnBGClick) forControlEvents:UIControlEventTouchUpInside];
    [viewWhiteBG addSubview:btnCancel];
    
    UIView *viewDown3 = [[UIView alloc]initWithFrame:CGRectMake(149, 200, 1, 50)];
    viewDown3.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [viewWhiteBG addSubview:viewDown3];
    
    UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
    btnDone.frame = CGRectMake(150, 50 + 150, 149, 50);
    [btnDone setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    [btnDone setTitle:ZEString(@"确定", @"Confirm") forState:UIControlStateNormal];
    btnDone.titleLabel.font = [UIFont systemFontOfSize:13];
    [btnDone addTarget:self action:@selector(btnDoneSelectTimeClick) forControlEvents:UIControlEventTouchUpInside];
    [viewWhiteBG addSubview:btnDone];
    
    
    
    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (scrollView.tag == 1)
    {
        if (scrollView.contentOffset.y <= 18)
        {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            [scrollView setContentOffset:CGPointMake(0, 35) animated:YES];
        }
    }
    else
    {
        if (scrollView.contentOffset.y <= 18)
        {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            NSInteger yushu = (int)scrollView.contentOffset.y % 35;
            NSInteger result = (int)scrollView.contentOffset.y / 35;
            if (yushu >= 18)
            {
                [scrollView setContentOffset:CGPointMake(0, (result + 1) * 35) animated:YES];
            }
            else
            {
                [scrollView setContentOffset:CGPointMake(0, result * 35) animated:YES];
            }
            
            
        }
    }

}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (scrollView.tag == 1)
    {
        if (scrollView.contentOffset.y <= 18)
        {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            [scrollView setContentOffset:CGPointMake(0, 35) animated:YES];
        }
    }
    else
    {
        if (scrollView.contentOffset.y <= 18)
        {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
        }
        else
        {
            NSInteger yushu = (int)scrollView.contentOffset.y % 35;
            NSInteger result = (int)scrollView.contentOffset.y / 35;
            if (yushu >= 18)
            {
                [scrollView setContentOffset:CGPointMake(0, (result + 1) * 35) animated:YES];
            }
            else
            {
                [scrollView setContentOffset:CGPointMake(0, result * 35) animated:YES];
            }
            
            
        }
    }
}
-(void)btnBGClick
{
    [self.view removeFromSuperview];
}
-(void)btnDoneSelectTimeClick
{
    
    NSMutableString *strTime = [[NSMutableString alloc]init];
    
    NSInteger yushu1 = (int)SV1.contentOffset.y % 35;
    NSInteger result1 = (int)SV1.contentOffset.y / 35;
    NSArray *arr = @[ZEString(@"上午", @"AM"),ZEString(@"下午",@"PM")];
    if (yushu1 >= 18)
    {
        [strTime appendString:arr[result1 + 1]];
    }
    else
    {
        [strTime appendString:arr[result1]];
    }
    [strTime appendString:@" "];
    
    NSInteger yushu2 = (int)SV2.contentOffset.y % 35;
    NSInteger result2 = (int)SV2.contentOffset.y / 35;
    NSArray *arr2 = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@""];

    if (yushu2 >= 18)
    {
        [strTime appendString:arr2[result2 + 1]];
    }
    else
    {
        [strTime appendString:arr2[result2]];
    }
    [strTime appendString:@":"];

    NSInteger yushu3 = (int)SV3.contentOffset.y % 35;
    NSInteger result3 = (int)SV3.contentOffset.y / 35;
    NSArray *arr3 = @[@"00",@"10",@"20",@"30",@"40",@"50",@""];

    if (yushu3 >= 18)
    {
        [strTime appendString:arr3[result3 + 1]];
    }
    else
    {
        [strTime appendString:arr3[result3]];
    }
    
    [self.delegate SelectDelveryTimeViewControllerResultTime:strTime];

    [self.view removeFromSuperview];

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
