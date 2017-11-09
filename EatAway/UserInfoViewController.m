//
//  UserInfoViewController.m
//  EatAway
//
//  Created by BossWang on 17/7/4.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "UserInfoViewController.h"
#import "ChangeNameViewController.h"
#import "ChangeNumberViewController.h"

//第三方相册
#import "WHC_PhotoListCell.h"
#import "WHC_PictureListVC.h"
#import "WHC_CameraVC.h"

#import <MBProgressHUD.h>
#import <UIButton+WebCache.h>
#import <UIImageView+WebCache.h>

@interface UserInfoViewController ()<WHC_ChoicePictureVCDelegate,WHC_CameraVCDelegate,changeNameDelegate,changeNumberDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

//@property (nonatomic, strong) UIButton *btn1;
@property (nonatomic, strong) UIButton *btn2;
@property (nonatomic, strong) UIButton *btn3;
@property (nonatomic, strong) UIButton *quitBtn;

@property(nonatomic,strong) UIActionSheet *actionSheetForPicker;

@end

@implementation UserInfoViewController
{
    
    UIView *viewNCBarUnder;
    MBProgressHUD *progress;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    viewNCBarUnder = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewNCBarUnder.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewNCBarUnder];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    self.title = ZEString(@"用户信息", @"userInfo");
    self.view.backgroundColor = EWColor(240, 240, 240, 1);
    [self createUI];
}

- (void)createUI{
    
    UIView *whiteView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 74, WINDOWWIDTH, 50)];
    //view1
    whiteView1.backgroundColor = [UIColor whiteColor];
    UILabel *titleLab1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, (WINDOWWIDTH- 50)/2, 30)];
    titleLab1.textAlignment = NSTextAlignmentLeft;
    titleLab1.textColor = EWColor(102, 102, 102, 1);
    titleLab1.font = [UIFont systemFontOfSize:13];
    titleLab1.text = ZEString(@"修改头像", @"Modify avatar");
    [whiteView1 addSubview:titleLab1];
    
    self.btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn1.frame = CGRectMake(0, 0, WINDOWWIDTH, 50);
    [self.btn1 setImage:[UIImage imageNamed:@"4.1.0_icon_more1"] forState:UIControlStateNormal];
    self.btn1.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -WINDOWWIDTH + 40);
    [self.btn1 addTarget:self action:@selector(iconImgClick:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView1 addSubview:self.btn1];
    
    self.iconImg = [[UIImageView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 80, 5, 40, 40)];
    self.iconImg.layer.masksToBounds = YES;
    self.iconImg.layer.cornerRadius = 20;
    self.iconImg.contentMode = UIViewContentModeScaleAspectFill;
    [self.iconImg sd_setImageWithURL:[NSURL URLWithString:HEADPHOTO] placeholderImage:[UIImage imageNamed:@"2.1.2_icon_head.png"]];
    [whiteView1 addSubview:self.iconImg];
    
    [self.view addSubview:whiteView1];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteView1.frame), WINDOWWIDTH, 1)];
    [self.view addSubview:lineView1];
    
    //view2
    UIView *whiteView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView1.frame), WINDOWWIDTH, 50)];
    
    UILabel *titleLab2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 30)];
    titleLab2.textAlignment = NSTextAlignmentLeft;
    titleLab2.textColor = EWColor(102, 102, 102, 1);
    titleLab2.font = [UIFont systemFontOfSize:13];
    titleLab2.text = ZEString(@"修改用户名", @"Modify user name");
    [whiteView2 addSubview:titleLab2];
    
    whiteView2.backgroundColor = [UIColor whiteColor];
    
    self.nameLab = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, WINDOWWIDTH - 190, 30)];
//    self.nameLab.backgroundColor = [UIColor redColor];
    self.nameLab.textAlignment = NSTextAlignmentRight;
    self.nameLab.text = NICKNAME;
    self.nameLab.textColor = EWColor(153, 153, 153, 1);
    self.nameLab.font = [UIFont systemFontOfSize:14];
    [whiteView2 addSubview:self.nameLab];
    [self.view addSubview:whiteView2];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(whiteView2.frame), WINDOWWIDTH, 1)];
    
    self.btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn2.frame = CGRectMake(0, 0, WINDOWWIDTH, 50);
    [self.btn2 setImage:[UIImage imageNamed:@"4.1.0_icon_more1"] forState:UIControlStateNormal];
    self.btn2.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, - WINDOWWIDTH + 40);
    [self.btn2 addTarget:self action:@selector(changeName:) forControlEvents:UIControlEventTouchUpInside];
    [whiteView2 addSubview:self.btn2];
    [self.view addSubview:whiteView1];
    
    lineView2.backgroundColor = EWColor(240, 240, 240, 1);
    [self.view addSubview:lineView2];
    
    //view3
    UIView *whiteView3 = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineView2.frame), WINDOWWIDTH, 50)];
    whiteView3.backgroundColor = [UIColor whiteColor];
    
    UILabel *titleLab3 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 150, 30)];
    titleLab3.textAlignment = NSTextAlignmentLeft;
    titleLab3.textColor = EWColor(102, 102, 102, 1);
    titleLab3.font = [UIFont systemFontOfSize:13];
    titleLab3.text = ZEString(@"换绑手机号", @"Modify phone number");
    [whiteView3 addSubview:titleLab3];
    
    self.phoneLab = [[UILabel alloc]initWithFrame:CGRectMake(160, 10, WINDOWWIDTH - 190, 30)];
    self.phoneLab.textAlignment = NSTextAlignmentRight;
    self.phoneLab.text = PHONENUMBER;
    self.phoneLab.textColor = EWColor(153, 153, 153, 1);
    self.phoneLab.font = [UIFont systemFontOfSize:14];
    [whiteView3 addSubview:self.phoneLab];
    
    self.btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    self.btn3.frame = CGRectMake(0, 0, WINDOWWIDTH, 50);
    [self.btn3 setImage:[UIImage imageNamed:@"4.1.0_icon_more1"] forState:UIControlStateNormal];
    self.btn3.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -WINDOWWIDTH + 40);
    [self.btn3 addTarget:self action:@selector(phoneClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [whiteView3 addSubview:self.btn3];
    
    [self.view addSubview:whiteView3];
    
    self.quitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.quitBtn.frame = CGRectMake(30, CGRectGetMaxY(whiteView3.frame) + 20, WINDOWWIDTH - 60, 40);
    self.quitBtn.clipsToBounds = YES;
    self.quitBtn.layer.cornerRadius = 5;
    self.quitBtn.backgroundColor = [UIColor whiteColor];
    self.quitBtn.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.quitBtn setTitle:ZEString(@"退出登录", @"logout") forState:UIControlStateNormal];
    [self.quitBtn setTitleColor:EWColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.quitBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.quitBtn addTarget:self action:@selector(btnQuitLogin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.quitBtn];
    
}
//退出登录
-(void)btnQuitLogin
{
    [ObjectForUser clearLogin];
    [self.navigationController popToRootViewControllerAnimated:YES];
}


#pragma mark - 换绑手机号的点击事件
- (void)phoneClick:(UIButton *)sender{
    
    ChangeNumberViewController *numberVC = [[ChangeNumberViewController alloc]init];
    numberVC.changeNumberDelegate = self;
    [self.navigationController pushViewController:numberVC animated:YES];
}
#pragma mark - 修改手机号的方法
- (void)changeNumber:(NSString *)numberStr{
    
    self.phoneLab.text = numberStr;
}
#pragma mark - 修改昵称的点击事件
- (void)changeName:(UIButton *)sender{
    
    ChangeNameViewController *changeNameVC = [[ChangeNameViewController alloc]init];
    changeNameVC.changeNameDelegate = self;
    [self.navigationController pushViewController:changeNameVC animated:YES];
}

#pragma mark - 修改昵称的方法
- (void)changeNameStr:(NSString *)name{
    
    self.nameLab.text = name;
}

#pragma mark - 修改头像的点击事件
- (void)iconImgClick:(UIButton *)sender{
    
//    [self HuoQUTuPian];
    [self selectHeadImage];
}

-(void)selectHeadImage
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        self.actionSheetForPicker = [[UIActionSheet alloc]initWithTitle:ZEString(@"修改头像", @"Change HeadImage") delegate:self cancelButtonTitle:ZEString(@"取消",@"Cancel") destructiveButtonTitle:nil otherButtonTitles:ZEString(@"拍照",@"Take a photo"),ZEString(@"从相册选择",@"Select for photo library"), nil];
    }
    else
    {
        self.actionSheetForPicker = [[UIActionSheet alloc]initWithTitle:@"修改头像" delegate:self cancelButtonTitle:ZEString(@"取消",@"Cancel") destructiveButtonTitle:nil otherButtonTitles:ZEString(@"从相册选择",@"Select for photo library"),nil];
        
    }
    
    [self.actionSheetForPicker showInView:self.view];
}
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    [actionSheet removeFromSuperview];
        NSInteger sourceType = 100;
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch (buttonIndex)
            {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                default:
                    break;
            }
            
        }
        else
        {
            switch (buttonIndex)
            {
                case 0:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                default:
                    break;
            }
        }
        
        
    if (sourceType != 100 )
    {
        UIImagePickerController *IVPicker = [[UIImagePickerController alloc]init];
        IVPicker.delegate = self;
        IVPicker.allowsEditing = YES;
        IVPicker.sourceType = sourceType;
        
        [self presentViewController:IVPicker animated:YES completion:^{
            nil;
        }];

    }


    
    
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{
        nil;
    }];
    UIImage *imageHead = [info objectForKey:UIImagePickerControllerEditedImage];
    
    
    if ([ObjectForUser checkLogin])
    {
        
        __weak UserInfoViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestToUploadHeadImageWithURLString:@"index.php/home/user/set_photo" image:@[imageHead] Parameters:@{@"userid":USERID,@"token":TOKEN} resultBlock:^(NSDictionary *resultDic) {
            [progress hide:YES];
            if(resultDic == nil)
            {
                [TotalFunctionView alertContent:ZEString(@"上传失败，请检查网络连接", @"Upload failure, please check the network connection") onViewController:blockSelf];
            }
            else if ([resultDic[@"status"] isEqual:@(9)])
            {
                ALERTCLEARLOGINBLOCK
            }
            else if ([resultDic[@"status"] isEqual:@(1)])
            {
                _iconImg.image = imageHead;
                
            }
            else
            {
                [TotalFunctionView alertContent:ZEString(@"上传失败，请检查网络连接", @"Upload failure, please check the network connection") onViewController:blockSelf];
            }
            
        }];
        
    }
    else
    {
        ALERTNOTLOGIN
    }
    
    
}



//获取图片
-(void)HuoQUTuPian
{
    __weak typeof(self) weakSelf = self;
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WHC_CameraVC * vc = [WHC_CameraVC new];
        vc.delegate = self;
        [self presentViewController:vc animated:YES completion:nil];
    }];
    UIAlertAction *cancelAction1 = [UIAlertAction actionWithTitle:@"从相册选择" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        WHC_PictureListVC  * vc = [WHC_PictureListVC new];
        vc.delegate = self;
        vc.maxChoiceImageNumberumber = 1;
        [weakSelf presentViewController:[[UINavigationController alloc]initWithRootViewController:vc] animated:YES completion:nil];
    }];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alert addAction:cancelAction];
    [alert addAction:cancelAction1];
    [alert addAction:okAction];
    [cancelAction setValue:[UIColor colorWithRed:0.13 green:0.13 blue:0.10 alpha:1] forKey:@"_titleTextColor"];
    [cancelAction1 setValue:[UIColor colorWithRed:0.13 green:0.13 blue:0.10 alpha:1] forKey:@"_titleTextColor"];
    [okAction setValue:[UIColor colorWithRed:0.13 green:0.13 blue:0.10 alpha:1] forKey:@"_titleTextColor"];
    //titleTextColor 变成_titleTextColor也可以
    
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 图片三方
- (void)WHCChoicePictureVC:(WHC_ChoicePictureVC *)choicePictureVC didSelectedPhotoArr:(NSArray *)photoArr{
    for (UIView * subView in self.view.subviews) {
        if([subView isKindOfClass:[UIImageView class]]){
            [subView removeFromSuperview];
        }
    }
//    UIImage *imageUpload = [photoArr firstObject];
    
    
    
    
    
    
    for (NSInteger i = 0; i < photoArr.count; i++) {
        
        NSDate * senddate=[NSDate date];
        NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
        [dateformatter setDateFormat:@"YYYYMMddHHmmSSSS"];
        NSString * filename =[dateformatter stringFromDate:senddate];
        NSString * fName = [NSString stringWithFormat:@"%@.jpg",filename];
        
        
//        _iconImg.image = [APGlobalMethod fixOrientation:_iconImg.image];
        
        //    *	图片上传接口，若不指定baseurl，可传完整的url
        //    *
        //    *	@param image			图片对象
        //    *	@param url				上传图片的接口路径，如/path/images/
        //    *	@param filename		给图片起一个名字，默认为当前日期时间,格式为"yyyyMMddHHmmss"，后缀为`jpg`
        //    *	@param name				与指定的图片相关联的名称，这是由后端写接口的人指定的，如imagefiles
        //    *	@param mimeType		默认为image/jpeg
        //    *	@param parameters	参数
        //    *	@param progress		上传进度
        //    *	@param success		上传成功回调
        //    *	@param fail				上传失败回调
        //     MBProgressHUD * hud  = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
//        [HYBNetworking uploadWithImage:_HeadImg.image url:Server_Upload filename:fName name:@"file" mimeType:@"image/jpg" parameters:nil progress:nil success:^(id response) {
//            NSString *imgStr = [[NSString alloc] initWithData:response  encoding:NSUTF8StringEncoding];
//            NSArray * arrImg = [imgStr componentsSeparatedByString:@"\""];
//            if(imgStr!=nil)
//            {
//                NSMutableDictionary *params = [NSMutableDictionary dictionary];
//                params[@"userId"] = [SMFTGpersonnews getbackstageid];
//                params[@"img"] = arrImg[1];
//                [HWHttpTool postWithHUD:self.view WithUrl:Server_UpdataImg params:params success:^(id json) {
//                    [SVProgressHUD showInfoWithStatus:@"头像设置成功"];
//                } failure:^(NSError *error) {
//                    
//                }];
//            }
//        } fail:^(NSError *error) {
//            [SMGlobalMethod showMessage:@"图片上传失败"];
//        }];
//        
    }
}
#pragma mark - 相机三方
- (void)WHCCameraVC:(WHC_CameraVC *)cameraVC didSelectedPhoto:(UIImage *)photo{
    
    [self WHCChoicePictureVC:nil didSelectedPhotoArr:@[photo]];
    
}


- (void)backAction{
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
