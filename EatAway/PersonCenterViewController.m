//
//  PersonCenterViewController.m
//  EatAway
//
//  Created by BossWang on 17/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "PersonCenterViewController.h"
#import "MerchantSettledViewController.h"
#import "PersonalInfoViewController.h"
#import "FeedbackViewController.h"
#import "AboutUsViewController.h"
#import "UserInfoViewController.h"
#import "MyordersViewController.h"
#import "ChangeNumberViewController.h"
#import "popupView.h"

#import "MyOrderListViewController.h"
#import "AddressViewController.h"

#import <UIButton+WebCache.h>
#import <ShareSDK/ShareSDK.h>

@interface PersonCenterViewController ()<UINavigationControllerDelegate,popupViewDelegate>

@property (nonatomic, strong) UIButton *iconBtn;
@property (nonatomic, strong) popupView *popopSubView;
@property (nonatomic, strong) UIView *grayView;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, retain) UILabel *nameLabel;
@property (nonatomic, retain) UIButton *phoneButton;

@end

@implementation PersonCenterViewController
{
    NSMutableArray *arrBtns;
    
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    
    
    
    
    
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if ([ObjectForUser checkLogin])
    {
        __weak PersonCenterViewController *blockSelf = self;
        [[ObjectForRequest shareObject] requestWithURL:@"index.php/home/user/personal_center" parameter:@{@"userid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            if (resultDic == nil)
            {

            }
            else if([resultDic[@"status"] isEqual:@(1)])
            {
                NSDictionary *dic = resultDic[@"msg"];;
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"username"] forKey:@"nickname"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"mobile"] forKey:@"phonenumber"];
                [[NSUserDefaults standardUserDefaults] setObject:dic[@"head_photo"] forKey:@"headphoto"];
                
                [blockSelf.iconBtn sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"2.1.2_icon_head.png"]];
                blockSelf.nameLabel.text = NICKNAME;
                if (PHONENUMBER != nil && ![PHONENUMBER isEqualToString:@""])
                {
                    [self.phoneButton setTitle:[NSString stringWithFormat:@"%@ >",PHONENUMBER] forState:UIControlStateNormal];
                }
                else
                {
                    [self.phoneButton setTitle:@"" forState:UIControlStateNormal];
                }

            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
        }];
        
    }
    else
    {
        ALERTNOTLOGINANDPOP
    }
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    [self createHeaderView];
    [self createTable];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeLanguage) name:@"changeLanguage" object:nil];
    
    arrBtns = [[NSMutableArray alloc]init];
}

- (void)createHeaderView{
    
    UIImageView *backgroundImg = [[UIImageView alloc]init];
    backgroundImg.frame = CGRectMake(0, -22, WINDOWWIDTH, 200);
    backgroundImg.image = [UIImage imageNamed:@"4.1.0_pic_bg"];
    [self.view addSubview:backgroundImg];
    

    
    UIButton *iconBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.iconBtn = iconBtn;
    iconBtn.frame = CGRectMake(25, 60, 75, 75);
    iconBtn.clipsToBounds = YES;
    iconBtn.layer.cornerRadius = 37.5;
    [iconBtn sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"2.1.2_icon_head.png"]];
//    [iconBtn setImage:[UIImage imageNamed:@"4.1.0_pic_head"] forState:UIControlStateNormal];
    [iconBtn addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:iconBtn];
    
    UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(114, 70, WINDOWWIDTH - 130, 30)];
    nameLab.text = NICKNAME;
    self.nameLabel = nameLab;
    nameLab.font = [UIFont systemFontOfSize:16];
    nameLab.textColor = [UIColor whiteColor];
    nameLab.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:nameLab];
    
//    NSString *phoneTitle = @"13722223333";
//    NSString *tel = [phoneTitle stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    UIButton *phoneBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.phoneButton = phoneBtn;
    phoneBtn.frame = CGRectMake(114, CGRectGetMaxY(nameLab.frame), 120, 30);
    phoneBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [phoneBtn setTitle:[NSString stringWithFormat:@"%@ >",PHONENUMBER] forState:UIControlStateNormal];
    phoneBtn.titleLabel.font = [UIFont systemFontOfSize:12];
//    [phoneBtn addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneBtn];
    
    UIButton *btnHeadView = [UIButton buttonWithType:UIButtonTypeCustom];
    btnHeadView.frame = CGRectMake(0, 44, WINDOWWIDTH, 200 - 66);
   // btnHeadView.backgroundColor = [UIColor redColor];
    [btnHeadView addTarget:self action:@selector(iconClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnHeadView];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    backBtn.frame = CGRectMake(8, 30, 25, 25);
    [backBtn setImage:[UIImage imageNamed:@"Login_back_white1"] forState:UIControlStateNormal];
    backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [backBtn addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
    
    
    
    
}
- (void)createTable{
    CGFloat btnHeight = 60;
    
    CGFloat viewX = 182;
    
    NSArray *arrBtnTitle = @[ZEString(@"收货地址", @"Delivery address"),ZEString(@"我的订单",@"My orders"),ZEString(@"商家入驻",@"Create a business account"),ZEString(@"意见反馈",@"Feedback")];
    NSArray *arrBtnTitle2 = @[ZEString(@"分享", @"Share"),ZEString(@"关于我们", @"About us")];
    for (int i = 0 ; i < 4 ; i ++)
    {
        
        UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(0, viewX + i *(btnHeight + 1), WINDOWWIDTH, btnHeight)];
        whiteView.backgroundColor = [UIColor whiteColor];
        UIButton *mainBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        mainBtn.frame = CGRectMake(0, 0, WINDOWWIDTH, btnHeight);
        mainBtn.tag = 50 + i;
        [mainBtn addTarget:self action:@selector(jumpClick:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView addSubview:mainBtn];
        
        UIImageView *IVBtn = [[UIImageView alloc]initWithFrame:CGRectMake(20,20, btnHeight/3, btnHeight/3)];
        IVBtn.image = [UIImage imageNamed:[NSString stringWithFormat:@"4.1.0_icon_0%d",i + 1]];
        [whiteView addSubview:IVBtn];

        UILabel *labelBtnTitle = [[UILabel alloc]initWithFrame:CGRectMake(20 + btnHeight/3 + 15, 20, WINDOWWIDTH - (20 + btnHeight/3 + 15 + 50), btnHeight/3)];
        labelBtnTitle.text = arrBtnTitle[i];
        labelBtnTitle.textColor = [UIColor colorWithWhite:75/255.0 alpha:1];
        labelBtnTitle.font = [UIFont systemFontOfSize:15];
        [whiteView addSubview:labelBtnTitle];
        [self.view addSubview:whiteView];
        
        UIImageView *IVNext = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 30, 23, 8, 14)];
        IVNext.image = [UIImage imageNamed:@"4.1.0_icon_more1.png"];
        [whiteView addSubview:IVNext];
        
    }
    
    for (int i = 0; i<2; i++) {
        UIView *whiteView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 437+ i *(btnHeight + 1), WINDOWWIDTH, btnHeight)];
        whiteView2.backgroundColor = [UIColor whiteColor];
        UIButton *mainBtn2 = [UIButton buttonWithType:UIButtonTypeCustom];
        mainBtn2.frame = CGRectMake(0, 0, WINDOWWIDTH, btnHeight);
        
        [whiteView2 addSubview:mainBtn2];
        mainBtn2.tag = 100 + i;
        [mainBtn2 addTarget:self action:@selector(jumpClick2:) forControlEvents:UIControlEventTouchUpInside];
        [whiteView2 addSubview:mainBtn2];
        UIImageView *IVBtn2 = [[UIImageView alloc]initWithFrame:CGRectMake(20,20, btnHeight/3, btnHeight/3)];
        IVBtn2.image = [UIImage imageNamed:[NSString stringWithFormat:@"4.1.0_icon_01%d",i + 1]];
        [whiteView2 addSubview:IVBtn2];
        
        UILabel *labelBtnTitle2 = [[UILabel alloc]initWithFrame:CGRectMake(20 + btnHeight/3 + 15, 20, 150, btnHeight/3)];
        labelBtnTitle2.text = arrBtnTitle2[i];
        labelBtnTitle2.textColor = [UIColor colorWithWhite:75/255.0 alpha:1];
        labelBtnTitle2.font = [UIFont systemFontOfSize:15];
        [whiteView2 addSubview:labelBtnTitle2];
        [self.view addSubview:whiteView2];
        
        UIImageView *IVNext = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 30, 23, 8, 14)];
        IVNext.image = [UIImage imageNamed:@"4.1.0_icon_more1.png"];
        [whiteView2 addSubview:IVNext];
    }
    
    
}

- (void)jumpClick:(UIButton *)sender{
    
    if (sender.tag == 50)
    {
        AddressViewController *AVC = [[AddressViewController alloc]init];
        AVC.strTitle = ZEString(@"收货地址", @"Address");
        AVC.isSelectAddress = NO;
        [self.navigationController pushViewController:AVC animated:YES];
    }
    else if (sender.tag == 51)
    {
        
        MyOrderListViewController *orderVC = [[MyOrderListViewController alloc]init];
        [self.navigationController pushViewController:orderVC animated:YES];
        
    }else if (sender.tag == 52){
        
        MerchantSettledViewController *vc = [[MerchantSettledViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
        
        
    }else{
        
        FeedbackViewController *feedVC = [[FeedbackViewController alloc]init];
        [self.navigationController pushViewController:feedVC animated:YES];
    }
}

- (void)phoneClick:(UIButton *)sender{//换绑手机号的点击事件
    ChangeNumberViewController *changeNumVC = [[ChangeNumberViewController alloc]init];
    [self.navigationController pushViewController:changeNumVC animated:YES];
   
    
}
- (void)jumpClick2:(UIButton *)sender{
    
    if (sender.tag == 100) {//分享的点击事件
        
        
        self.grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT)];
        self.grayView.backgroundColor = EWColor(0, 0, 0, 0.5);
        [self.view addSubview:self.grayView];
        
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn.frame = CGRectMake(0, 0, WINDOWWIDTH, WINDOWHEIGHT);
//        self.cancelBtn.backgroundColor = [UIColor redColor];
        [self.cancelBtn addTarget:self action:@selector(cancelMethod) forControlEvents:UIControlEventTouchUpInside];
        [self.grayView addSubview:self.cancelBtn];
        
        self.popopSubView = [[popupView alloc]initWithFrame:CGRectMake(30, WINDOWHEIGHT/ 2 - 101, WINDOWWIDTH - 60, 202)];
        self.popopSubView.popupDelegate = self;
        self.popopSubView.backgroundColor = [UIColor whiteColor];
        [self.grayView addSubview:self.popopSubView];
    }else{  //关于我们的点击事件
        
        AboutUsViewController *aboutUsVC = [[AboutUsViewController alloc]init];
        [self.navigationController pushViewController:aboutUsVC animated:YES];
    }
}

- (void)changeLanguage{
    
    NSArray *arrBtnTitle = @[ZEString(@"收货地址", @"Restaurant"),ZEString(@"我的订单",@"Order"),ZEString(@"商家入驻",@"Person Center"),ZEString(@"意见反馈",@"Customer Service")];
    for (int a = 0; a < 4; a ++)
    {
        UILabel *label = arrBtns[a];
        label.text = arrBtnTitle[a];
        
    }
    
}

- (void)WeChatShare
{//分享给微信好友
    self.grayView.hidden = YES;
    [self shareToPlatform:SSDKPlatformSubTypeWechatSession];
}
- (void)LoopShare
{//分享朋友圈
    self.grayView.hidden = YES;
    [self shareToPlatform:SSDKPlatformSubTypeWechatTimeline];
}
-(void)shareToPlatform:(SSDKPlatformType)platform
{
    NSArray *arrImages = @[[UIImage imageNamed:@"logo_1024px.png"]];
    //创建分享参数
    NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
    [shareParams SSDKSetupShareParamsByText:@"EatAway，让生活更美味"
                                     images:arrImages //传入要分享的图片
                                        url:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/eataway/id1259761185?mt=8"]
                                      title:@"EatAway"
                                       type:SSDKContentTypeAuto];
    
    //进行分享
    [ShareSDK share:platform //传入分享的平台类型
         parameters:shareParams
     onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
         // 回调处理....
     }];

}
- (void)CancleShare{//取消分享
    
    self.grayView.hidden = YES;
}

- (void)cancelMethod{//灰色背景的取消分享
    
    self.grayView.hidden = YES;
    
}
- (void)backClick{//返回按钮的点击事件
    
//    self.navigationController.navigationBar.hidden = NO;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)iconClick{
    
    UserInfoViewController *userInfoVC = [[UserInfoViewController alloc]init];
    [self.navigationController pushViewController:userInfoVC animated:YES];
    
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
