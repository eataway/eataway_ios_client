//
//  OrderCommentViewController.m
//  EatAway
//
//  Created by apple on 2017/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "OrderCommentViewController.h"



#import "UploadImagesTableViewCell.h"
#import  <ELCImagePickerController.h>

#import <MBProgressHUD.h>
#import <UIImageView+WebCache.h>

@interface OrderCommentViewController ()<UITableViewDelegate,UITableViewDataSource,UploadImagesTableViewCellDelegate,UIActionSheetDelegate,ELCImagePickerControllerDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextViewDelegate>
{
    UITableView *_tableView;
    NSMutableArray *arrStars;
    NSInteger Level;
    
    NSMutableArray *arrImages;
    UploadImagesTableViewCell *uploadImageCell;
    
    UITextView *textViewContent;
    
    BOOL NoName;
    UIButton *btnNoName;
    
//    NSString *strOrderID;
//    NSString *strShopID;
    UIImageView *IVHead;
    UILabel *labelTitle;
    UIImageView *IVShop;
    
    MBProgressHUD *progress;
    
    
}

@property(nonatomic,retain)UIActionSheet *actionSheet;
@end

@implementation OrderCommentViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = ZEString(@"评价", @"Reviews");
    self.automaticallyAdjustsScrollViewInsets = NO;
    arrStars = [[NSMutableArray alloc]init];
    arrImages = [[NSMutableArray alloc]init];
    
    self.view.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    
    UIView *viewTopBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTopBG.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTopBG];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    [self tableViewInit];
    
    
    UIButton *btnReviews = [UIButton buttonWithType:UIButtonTypeCustom];
    btnReviews.frame = CGRectMake(20, WINDOWHEIGHT - 15 - 45, WINDOWWIDTH - 40, 45);
    btnReviews.backgroundColor = [UIColor orangeColor];
    [btnReviews setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnReviews setTitle:ZEString(@"发表评论", @"OK") forState:UIControlStateNormal];
    btnReviews.clipsToBounds = YES;
    btnReviews.layer.cornerRadius = 7;
    [btnReviews addTarget:self action:@selector(btnReviewsClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnReviews];
    
}
-(void)setContentWithHeadPhotoURL:(NSString *)strHeadPhotoURL shopName:(NSString *)strShopName ShopImageURL:(NSString *)strShopImageURL orderid:(NSString *)strOrderID shopID:(NSString *)strShopID
{
    self.strShopImageURL = strShopImageURL;
    self.strHeadPhotoURL = strHeadPhotoURL;
    
    self.strShopID = strShopID;
    self.strOrderID = strOrderID;
    self.strShopName = strShopName;
    
}

-(void)tableViewInit
{

    
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64 - 30 - 45) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        return 150;
    }
    else if (indexPath.row == 1)
    {
        return 100;
    }
    else if (indexPath.row == 2)
    {
        return 130;
    }
    else
    {
        return 100;
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
            
            
            UIView *viewWhiteBG = [[UIView alloc]initWithFrame:CGRectMake(10, 10, WINDOWWIDTH - 20, 130)];
            viewWhiteBG.backgroundColor = [UIColor whiteColor];
            viewWhiteBG.clipsToBounds = YES;
            viewWhiteBG.layer.cornerRadius = 7;
            [cell addSubview:viewWhiteBG];
            
            IVHead = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 20, 20)];
            IVHead.clipsToBounds = YES;
            IVHead.layer.cornerRadius = 10;
            IVHead.clipsToBounds = YES;
            IVHead.contentMode = UIViewContentModeScaleAspectFill;
            
            IVShop = [[UIImageView alloc]initWithFrame:CGRectMake(10, 50 + 10, 90, 60)];
            IVShop.clipsToBounds = YES;
            IVShop.contentMode = UIViewContentModeScaleAspectFill;
            [viewWhiteBG addSubview:IVHead];
            [viewWhiteBG addSubview:IVShop];

            labelTitle = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 10, 15, WINDOWWIDTH - 40 - 10, 20)];
            labelTitle.font = [UIFont systemFontOfSize:13];
            labelTitle.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
            [viewWhiteBG addSubview:labelTitle];
            
            UIView *viewDown = [[UIView alloc]initWithFrame:CGRectMake(0, 49, WINDOWWIDTH, 1)];
            viewDown.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
            [viewWhiteBG addSubview:viewDown];
            
            
            UILabel *labelLevel = [[UILabel alloc]initWithFrame:CGRectMake(10 + 90 + 10, 50 + 10, WINDOWWIDTH - 10 - 50 - 10, 60)];
            labelLevel.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
            labelLevel.font = [UIFont systemFontOfSize:13];
            [viewWhiteBG addSubview:labelLevel];
            
            for (int a = 0; a < 5; a ++ )
            {
                UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame = CGRectMake(10 + 90 + 10 + 35 + 30 * a, 50 + 30, 25, 25);
                btn.tag = a;
                [btn setImage:[UIImage imageNamed:@"3.1.2_icon_star_nor.png"] forState:UIControlStateNormal];
                [btn addTarget:self action:@selector(btnStarClick:) forControlEvents:UIControlEventTouchUpInside];
                [viewWhiteBG addSubview:btn];
                [arrStars addObject:btn];
            }
            
        }
        labelTitle.text = self.strShopName;
        [IVShop sd_setImageWithURL:[NSURL URLWithString:self.strShopImageURL] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
        [IVHead sd_setImageWithURL:[NSURL URLWithString:self.strHeadPhotoURL] placeholderImage:[UIImage imageNamed:@"placehoder1.png"]];
        
        
    }
    else if (indexPath.row == 1)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell01"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell01"];
            UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(10, 0, WINDOWWIDTH - 20, 100)];
            viewBG.backgroundColor = [UIColor whiteColor];
            viewBG.clipsToBounds = YES;
            viewBG.layer.cornerRadius = 7;
            [cell addSubview:viewBG];
            
            UIView *view1 = [[UIView alloc]initWithFrame:CGRectMake(10, 90, 10, 10)];
            view1.backgroundColor = [UIColor whiteColor];
            [cell addSubview:view1];
            
            UIView *view2 = [[UIView alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 10 - 10, 90, 10, 10)];
            view2.backgroundColor = [UIColor whiteColor];
            [cell addSubview:view2];
            
            textViewContent = [[UITextView alloc]initWithFrame:CGRectMake(10 + 10, 10, WINDOWWIDTH - 40, 90)];
            textViewContent.delegate = self;
            textViewContent.textColor = [UIColor colorWithWhite:150/255.0 alpha:1];
            textViewContent.font = [UIFont systemFontOfSize:13];
            textViewContent.text = ZEString(@"味道如何？服务周到吗？分享一下吧！", @"How does it taste? Is the serive good? Share it!");
            [cell addSubview:textViewContent];
        }
        
    }
    else if (indexPath.row == 2)
    {
        uploadImageCell = [tableView dequeueReusableCellWithIdentifier:@"cell02"];
        
        if(!uploadImageCell)
        {
            
            uploadImageCell= [[UploadImagesTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell02"];
            
            uploadImageCell.delegate = self;
            uploadImageCell.maxImageNum = 2;
            cell = uploadImageCell;
        }
        

    }
    else if (indexPath.row == 3)
    {
        cell = [tableView dequeueReusableCellWithIdentifier:@"cell03"];
        if (!cell)
        {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell03"];
            btnNoName = [UIButton buttonWithType:UIButtonTypeCustom];
            btnNoName.frame = CGRectMake(10, 20, 20, 20);
            if (NoName)
            {
                [btnNoName setImage:[UIImage imageNamed:@"3.1.2_icon_marquee_sel.png"] forState:UIControlStateNormal];
            }
            else
            {
                [btnNoName setImage:[UIImage imageNamed:@"3.1.2_icon_marquee_nor.png"] forState:UIControlStateNormal];
            }
            [btnNoName addTarget:self action:@selector(btnNoNameClick) forControlEvents:UIControlEventTouchUpInside];
            [cell addSubview:btnNoName];
            
            UILabel *labelNoName = [[UILabel alloc]initWithFrame:CGRectMake(10 + 20 + 5, 20, WINDOWWIDTH - 45, 20)];
            
            labelNoName.text = ZEString(@"匿名", @"Anonymous");
            labelNoName.font = [UIFont systemFontOfSize:12];
            labelNoName.textColor = [UIColor colorWithWhite:140/255.0 alpha:1];
            [cell addSubview:labelNoName];
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
    cell.backgroundColor = [UIColor colorWithWhite:240/255.0 alpha:1];
    return cell;
}

-(void)btnStarClick:(UIButton *)btn
{
    NSInteger num = btn.tag;
    Level = btn.tag;
    for (UIButton *aBtn in arrStars)
    {
        if (aBtn.tag <= num)
        {
            [aBtn setImage:[UIImage imageNamed:@"3.1.2_icon_star_sel.png"] forState:UIControlStateNormal];
        }
        else
        {
            [aBtn setImage:[UIImage imageNamed:@"3.1.2_icon_star_nor.png"] forState:UIControlStateNormal];
        }
    }
    
    
    
}

-(void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"味道如何？服务周到吗？分享一下吧！"] || [textView.text isEqualToString:@"How does it taste? Is the serive good? Share it!" ])
    {
        textView.text = @"";
        textView.textColor = [UIColor blackColor];
    }
    
}
-(void)btnNoNameClick
{
    NoName = !NoName;
    
    if (NoName)
    {
        [btnNoName setImage:[UIImage imageNamed:@"3.1.2_icon_marquee_sel.png"] forState:UIControlStateNormal];
    }
    else
    {
        [btnNoName setImage:[UIImage imageNamed:@"3.1.2_icon_marquee_nor.png"] forState:UIControlStateNormal];
    }

}
//上传图片
-(void)tableViewUploadImageClick
{
    if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册选择", nil];
    }
    else
    {
        self.actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择图像" delegate:self cancelButtonTitle:@"取消"destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", nil];
    }
    self.actionSheet.tag = 1000;
    self.actionSheet.delegate = self;
    [self.actionSheet showInView:self.view];
    
}
-(void)tableViewDeleteImageWithTag:(NSInteger)imageTag
{
    [arrImages removeObjectAtIndex:imageTag];
    
}

#pragma mark - imagePickerController 代理
- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    for (NSDictionary *dict in info)
    {
        if ([dict objectForKey:UIImagePickerControllerOriginalImage])
        {
            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
            
            // 压缩图片
            [uploadImageCell addImage:image];
            [arrImages addObject:image];
        }
    }
    
    
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [uploadImageCell addImage:image];
    [arrImages addObject:image];
    
//    for (NSDictionary *dict in info)
//    {
//        if ([dict objectForKey:UIImagePickerControllerMediaType])
//        {
//            UIImage *image = [dict objectForKey:UIImagePickerControllerOriginalImage];
//            
//            // 压缩图片
//            [uploadImageCell addImage:image];
//            [arrImages addObject:image];
//        }
//    }

}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:nil];

}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1000)
    {
        
        //        NSUInteger sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        // 判断是否支持相机
        
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
        {
            switch(buttonIndex)
            {
                    
                case 0:
                    
                    //来源:相机
                    
                {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = self;
                    
                    //imagePickerController.allowsEditing = YES;
                    
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    
                    [self presentViewController:imagePickerController animated:YES completion:^{
                     }];
                    
                    break;
                    
                }
                    
                case 1:
                    
                    //来源:相册
                    
                {
                    
                    ELCImagePickerController *ELCIP = [[ELCImagePickerController alloc] init];
                    ELCIP.maximumImagesCount = 2 - arrImages.count
                    ;
                    ELCIP.imagePickerDelegate = self;
                    [ self presentViewController:ELCIP animated:YES completion:nil];
                    
                    break
                    ;
                    
                }
                    
                case 2:
                    
                    return;
            }
        }
        
        else
            
        {
            
            if (buttonIndex == 1)
            {
                return;
            }
            
            else
                
            {
                {
                    
                    ELCImagePickerController *ELCIP = [[ELCImagePickerController alloc] init];
                    ELCIP.maximumImagesCount = 2 - arrImages.count;
                    
                    ELCIP.imagePickerDelegate = self;
                    
                    [self presentViewController:ELCIP animated:YES completion:nil];
                }}
        }
        
    }
}
-(void)btnReviewsClick
{
    if (![ObjectForUser checkLogin])
    {
        ALERTNOTLOGIN
    }
    else if([textViewContent.text isEqualToString:@"味道如何？服务周到吗？分享一下吧！"] ||[textViewContent.text isEqualToString:@"How does it taste? Is the serive good? Share it!"]||[textViewContent.text isEqualToString:@""] )
    {
        [TotalFunctionView alertContent:ZEString(@"请输入评价信息", @"Please enter evaluation") onViewController:self];
    }
    else
    {
        NSString *strNiMing;
        if (NoName)
        {
            strNiMing = @"1";
        }
        else
        {
            strNiMing = @"2";
        }
        NSString *strLevel = [NSString stringWithFormat:@"%ld",Level + 1];
        __weak OrderCommentViewController *blockSelf = self;
        progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [[ObjectForRequest shareObject] requestWithURLString:@"index.php/home/evaluate/addpingjia" images:arrImages Parameters:@{@"userid":USERID,@"token":TOKEN,@"shopid":_strShopID,@"state":strNiMing,@"orderid":_strOrderID,@"pingjia":strLevel,@"content":textViewContent.text} resultBlock:^(NSDictionary *resultDic)
         {
             [progress hide:YES];
             if (resultDic == nil)
             {
                 [TotalFunctionView alertContent:ZEString(@"评价失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
             }
             else if([resultDic[@"status"] isEqual:@(9)])
             {
                 ALERTCLEARLOGINBLOCK
             }
             else if ([resultDic[@"status"] isEqual:@(1)])
             {
                 [blockSelf.delegate orderCommentViewControllerSucceed];
                 [TotalFunctionView alertAndDoneWithContent:ZEString(@"评价成功", @"Succeed") onViewController:blockSelf];
             }
             else
             {
                 [TotalFunctionView alertContent:ZEString(@"评价失败，请检查网络连接", @"Operation failed, please check the network connection") onViewController:blockSelf];
             }
        }];
    }

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
