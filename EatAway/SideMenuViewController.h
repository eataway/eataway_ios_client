//
//  SideMenuViewController.h
//  EatAway
//
//  Created by apple on 2017/6/10.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuViewController : UIViewController

@property(retain,nonatomic)UIButton *btnQuit;
@property(nonatomic,assign)id delegate;
@property(nonatomic,retain)UILabel *labelNickname;
@property(nonatomic,retain)UILabel *labelPhoneNum;

@property(nonatomic,retain)UIImageView *IVHead;

-(void)quitLoginViewChange;

@end
@protocol  SideMenuViewControllerDelegate<NSObject>

@required

-(void)sideMenuQuitClick;
-(void)sideMenuListButtonClickWithIndex:(NSInteger)btnIndex;
-(void)sideMenuHeadImageAreaClick;

@end
