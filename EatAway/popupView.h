//
//  popupView.h
//  EatAway
//
//  Created by BossWang on 17/7/8.
//  Copyright © 2017年 allen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol popupViewDelegate <NSObject>

- (void)WeChatShare;
- (void)LoopShare;
- (void)CancleShare;

@end

@interface popupView : UIView

@property (nonatomic, retain) UILabel *shareLab;
@property (nonatomic, retain) UIButton * WeChatBtn;
@property (nonatomic, retain) UIButton * LoopBtn;
@property (nonatomic, retain) UIButton *cancelBtn;
@property (nonatomic, assign)id<popupViewDelegate>popupDelegate;

@end
