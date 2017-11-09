//
//  FirstNavigationController.h
//  EatAway
//
//  Created by apple on 2017/6/10.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstNavigationController : UINavigationController

@property(retain,nonatomic)UIView *topBar;

@property(assign,nonatomic)id delegateObj;

@property(nonatomic,retain)UITextField *TFSearch;


@end

@protocol FirstNavigationControllerDelegate <NSObject>

@required

-(void)navgationTopBarLeftButtonClick:(UIButton *)btn;
-(void)navgationTopBarRightButtonClick:(UIButton *)btn;

@end
