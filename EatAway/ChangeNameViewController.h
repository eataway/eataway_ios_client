//
//  ChangeNameViewController.h
//  EatAway
//
//  Created by BossWang on 17/7/5.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol changeNameDelegate <NSObject>

- (void)changeNameStr:(NSString *)name;

@end

@interface ChangeNameViewController : UIViewController

@property (nonatomic, retain) UITextField *nameField;
@property (nonatomic, assign) id<changeNameDelegate>changeNameDelegate;

@end
