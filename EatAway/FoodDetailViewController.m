//
//  FoodDetailViewController.m
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "FoodDetailViewController.h"

@interface FoodDetailViewController ()
{
    UIButton *btnJian;
    UIButton *btnJia;
    
    UILabel *labelTitle;
    UILabel *labelPrice;
    
    NSString *_strFoodID;
    NSString *_strImageURL;
    
    UILabel *labelDetail;
}
@end

@implementation FoodDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    btnJian = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJian.frame = CGRectMake(WINDOWWIDTH - 10 - 20 - 25 - 20, (80 - 20)/2 + 20, 20, 20);
    [btnJian setImage:[UIImage imageNamed:@"2.2.0_icon_reduce.png"] forState:UIControlStateNormal];
    btnJian.adjustsImageWhenHighlighted = NO;
    btnJian.tag = 1;
    [btnJian addTarget:self action:@selector(btnChangeNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJian];
    btnJian.hidden = YES;
    
    _labelNum = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 20 - 25, (80 - 20)/2 + 20, 25, 20)];
    _labelNum.text = @"0";
    _labelNum.font = [UIFont systemFontOfSize:15];
    _labelNum.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labelNum];
    
    btnJia = [UIButton buttonWithType:UIButtonTypeCustom];
    btnJia.frame = CGRectMake(WINDOWWIDTH - 10 - 20, (80 - 20)/2 + 20, 20, 20);
    [btnJia setImage:[UIImage imageNamed:@"2.2.0_icon_plus.png"] forState:UIControlStateNormal];
    btnJia.adjustsImageWhenHighlighted = NO;
    btnJia.tag = 2;
    [btnJia addTarget:self action:@selector(btnChangeNumClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnJia];
    
    labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 10, 8, WINDOWWIDTH - (10 + 10 + 5), 30)];
//    labelTitle.backgroundColor = [UIColor redColor];
    labelTitle.font = [UIFont systemFontOfSize:12];
    labelTitle.numberOfLines = 2;
    [self.view addSubview:labelTitle];
    
    labelPrice = [[UILabel alloc]initWithFrame:CGRectMake(10 + 10, 10 + 40, WINDOWWIDTH - (10  + 10 + 75 + 5), 20)];
    labelPrice.font = [UIFont systemFontOfSize:13];
    labelPrice.textColor = MAINCOLOR;
    [self.view addSubview:labelPrice];
    
    UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 10 + 40 + 20 + 9, WINDOWWIDTH, 1)];
    viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:viewDown];
    
    labelDetail = [[UILabel alloc]initWithFrame:CGRectMake(10 + 10, 10 + 40 + 20 + 10 +10, WINDOWWIDTH - 40, 20)];
    labelDetail.font = [UIFont systemFontOfSize:13];
    labelDetail.numberOfLines = 0;
    labelDetail.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
    [self.view addSubview:labelDetail];
    
    
    
}
-(void)setContentWithTitle:(NSString *)strTitle image:(NSString *)strImageURL num:(NSString *)strNum price:(NSString *)strPrice foodID:(NSString *)strFoodID foodDetails:(NSString *)strFoodDetails
{
    labelTitle.text = strTitle;
    labelTitle.numberOfLines = 2;
    _labelNum.text = strNum;
    NSInteger num = [strNum integerValue];
    if (num <= 0)
    {
        btnJian.hidden = YES;
    }
    else
    {
        btnJian.hidden = NO;
    }
    labelPrice.text = [NSString stringWithFormat:ZEString(@"$%@/份", @"$%@"),strPrice];
    
    _strFoodID = strFoodID;
    _strImageURL = strImageURL;
    
    labelDetail.text = strFoodDetails;
    CGSize sizeOfLabelDetail = [self sizeOfString:strFoodDetails fontSize:13];
    labelDetail.frame = CGRectMake(20, 90, WINDOWWIDTH - 40, sizeOfLabelDetail.height);
    
   
}

-(void)btnChangeNumClick:(UIButton *)btn
{
    NSString *strNum = _labelNum.text;
    NSInteger num = [strNum integerValue];
    if (btn.tag == 1 && num >0)
    {
        num = num - 1;
    }
    else if(btn.tag == 2)
    {
        num = num + 1;
    }
    if (num <= 0)
    {
        btnJian.hidden = YES;
    }
    else
    {
        btnJian.hidden = NO;
    }
    NSString *strNumChanged = [NSString stringWithFormat:@"%ld",(long)num];
    _labelNum.text = strNumChanged;
    
    
    NSArray *arr1 = [labelPrice.text componentsSeparatedByString:@"/"];
    NSString *str1 = [arr1 firstObject];
    NSArray *arr2 = [str1 componentsSeparatedByString:@"$"];
    NSString *str2 = [arr2 lastObject];
    
    [self.delegate FoodDetailViewControllerChangeFoodNumber:num foodID:_strFoodID foodName:labelTitle.text foodPrice:str2 imageURL:_strImageURL];
}
-(CGSize)sizeOfString:(NSString *)string fontSize:(NSInteger)fontSize
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:fontSize], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [string boundingRectWithSize:CGSizeMake(WINDOWWIDTH - 40,200) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    return labelSize;
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
