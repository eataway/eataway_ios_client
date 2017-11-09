//
//  SubmitOrderSelectPayViewController.h
//  EatAway
//
//  Created by apple on 2017/6/30.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubmitOrderSelectPayViewController : UIViewController

@property(nonatomic,assign)id delegate;

@end

@protocol SubmitOrderSelectPayViewControllerDelegate <NSObject>

@required
-(void)SubmitOrderSelectPayViewControllerSelectResult:(NSString *)strResult;

@end
