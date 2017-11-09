//
//  ChangeNumberViewController.h
//  EatAway
//
//  Created by BossWang on 17/7/5.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeNumberDelegate <NSObject>

- (void)changeNumber:(NSString *)numberStr;

@end

@interface ChangeNumberViewController : UIViewController

@property (nonatomic, strong)id<changeNumberDelegate>changeNumberDelegate;
@property (nonatomic, strong) UITextField *phoneField;
@property (nonatomic, strong) UITextField *TFCheckBox;

@end
