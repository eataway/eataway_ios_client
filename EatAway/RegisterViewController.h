//
//  RegisterViewController.h
//  EatAway
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegisterViewController : UIViewController


@property(nonatomic,assign)id delegate;

@end

@protocol RegisterViewControllerDelegate <NSObject>

@optional

-(void)RegisterSucceedWithPhoneNum:(NSString *)strPhoneNum;

@end
