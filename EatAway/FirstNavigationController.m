//
//  FirstNavigationController.m
//  EatAway
//
//  Created by apple on 2017/6/10.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FirstNavigationController.h"

@interface FirstNavigationController ()
{
    
}
@end

@implementation FirstNavigationController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationBar.hidden = YES;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    
    self.topBar = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    self.topBar.backgroundColor = MAINCOLOR;
    [self.view addSubview:self.topBar];
    
    UIButton *btnMenu = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMenu.frame = CGRectMake(10, 20 + 10 , 25, 25);
    [btnMenu setImage:[UIImage imageNamed:@"2.1.0_icon_list.png"] forState:UIControlStateNormal];
    [btnMenu addTarget:self action:@selector(btnItemLeftClick:) forControlEvents:UIControlEventTouchUpInside];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName: [UIColor clearColor]} forState:UIControlStateNormal];
    [self.topBar addSubview:btnMenu];
    
    UIView *viewTitleSearch = [[UIView alloc]initWithFrame:CGRectMake(50, 20 + 7, WINDOWWIDTH - 100, 30)];
    viewTitleSearch.backgroundColor = [UIColor whiteColor];
    viewTitleSearch.clipsToBounds = YES;
    viewTitleSearch.layer.cornerRadius = 15;
    
    UIImageView *IVSearch = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"2.1.0_icon_search.png"]];
    IVSearch.frame = CGRectMake(8, 3, 24, 24);
    [viewTitleSearch addSubview:IVSearch];
    
    self.TFSearch = [[UITextField alloc]initWithFrame:CGRectMake(40, 0, WINDOWWIDTH - 100 - 40 - 40, 30)];
    self.TFSearch.placeholder = ZEString(@"搜索栏", @"Search bar");
    self.TFSearch.font = [UIFont systemFontOfSize:12];
//    TFSearch.textAlignment = NSTextAlignmentCenter;
    [viewTitleSearch addSubview:self.TFSearch];
    self.TFSearch.returnKeyType = UIReturnKeySearch;
    [self.topBar addSubview:viewTitleSearch];
    
    UIButton *btnAddress = [UIButton buttonWithType:UIButtonTypeCustom];
    btnAddress.frame = CGRectMake(WINDOWWIDTH - 10 - 25, 20 + 10 , 25, 25);
    [btnAddress setImage:[UIImage imageNamed:@"2.1.0_icon_location.png"] forState:UIControlStateNormal];
    [btnAddress addTarget:self action:@selector(btnAddressClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.topBar addSubview:btnAddress];
    

    
    
    
}
-(void)changeLanguage
{
    self.TFSearch.placeholder = ZEString(@"搜索栏", @"Search bar");

}
-(void)btnItemLeftClick:(UIButton *)item
{
    [self.delegateObj navgationTopBarLeftButtonClick:item];
}
-(void)btnAddressClick:(UIButton *)item
{
    [self.delegateObj navgationTopBarRightButtonClick:item];
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
