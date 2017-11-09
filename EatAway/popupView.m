//
//  popupView.m
//  EatAway
//
//  Created by BossWang on 17/7/8.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "popupView.h"

@interface popupView()

@end

@implementation popupView

- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
//        self.frame = CGRectMake(30, WINDOWHEIGHT/2 - 150, WINDOWWIDTH - 60, 300);
        self.layer.cornerRadius = 8;
        [self createUI];
    }
    return self;
}

- (void)createUI{
    
    self.shareLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, self.frame.size.width, 30)];
    self.shareLab.text = ZEString(@"分享到", @"Share");
    self.shareLab.textColor = EWColor(102, 102, 102, 1);
    self.shareLab.font = [UIFont systemFontOfSize:15];
    self.shareLab.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.shareLab];
    
    UIView *lineView1 = [[UIView alloc]initWithFrame:CGRectMake(0, 50, self.frame.size.width, 1)];
    lineView1.backgroundColor = EWColor(240, 240, 240, 1);
    [self addSubview:lineView1];
    
//    NSArray *titleArr = @[@"微信好友",@"朋友圈"];
    
//    for (int i = 0; i < 2; i++) {
//        self.WeChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        self.WeChatBtn.frame = CGRectMake(i * (self.frame.size.width/2 - 25) + 50, 75,  50, 50);
////        self.WeChatBtn.backgroundColor = [UIColor redColor];
//        [self.WeChatBtn setImage:[UIImage imageNamed:[NSString stringWithFormat:@"icon_share_0%d",i]] forState:UIControlStateNormal];
//        [self addSubview:self.WeChatBtn];
//        
//        UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(i *(self.frame.size.width/2 - 18) + 50, CGRectGetMaxY(self.WeChatBtn.frame), 70, 30)];
//        titleLab.textAlignment = NSTextAlignmentLeft;
//        titleLab.font = [UIFont systemFontOfSize:12];
//        titleLab.textColor = EWColor(102, 102, 102, 1);
//        titleLab.text = titleArr[i];
//        [self addSubview:titleLab];
//
//    }
    
    self.WeChatBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.WeChatBtn.frame = CGRectMake((self.frame.size.width - 100)/4, 70, 50, 50);
    [self.WeChatBtn setImage:[UIImage imageNamed:@"icon_share_00"] forState:UIControlStateNormal];
    [self.WeChatBtn addTarget:self action:@selector(WeChatClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.WeChatBtn];
    UILabel *titleLab = [[UILabel alloc]initWithFrame:CGRectMake(0, 70 + 50 , self.frame.size.width/2, 30)];
    titleLab.textAlignment = NSTextAlignmentCenter;
    titleLab.font = [UIFont systemFontOfSize:12];
    titleLab.textColor = EWColor(102, 102, 102, 1);
    titleLab.text = ZEString(@"微信好友", @"Wechat friends");
    [self addSubview:titleLab];
    
    self.LoopBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.LoopBtn.frame = CGRectMake((self.frame.size.width - 100) *3/4 + 50, 70, 50, 50);
    [self.LoopBtn setImage:[UIImage imageNamed:@"icon_share_01"] forState:UIControlStateNormal];
    [self.LoopBtn addTarget:self action:@selector(loopClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.LoopBtn];
    
    UILabel *loopLab = [[UILabel alloc]initWithFrame:CGRectMake(self.frame.size.width/2, 70 + 50 , self.frame.size.width/2, 30)];
    loopLab.textAlignment = NSTextAlignmentCenter;
    loopLab.font = [UIFont systemFontOfSize:12];
    loopLab.textColor = EWColor(102, 102, 102, 1);
    loopLab.text = ZEString(@"朋友圈", @"Moments");
    [self addSubview:loopLab];
    
    UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake(0, 151, self.frame.size.width, 1)];
    lineView2.backgroundColor = EWColor(240, 240, 240, 1);
    [self addSubview:lineView2];
    
    self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.cancelBtn.frame = CGRectMake(0, 152, self.frame.size.width, 50);
    self.cancelBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.cancelBtn setTitle:ZEString(@"取消", @"Cancel") forState:UIControlStateNormal];
    [self.cancelBtn setTitleColor:EWColor(102, 102, 102, 1) forState:UIControlStateNormal];
    self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.cancelBtn addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:self.cancelBtn];
}

- (void)WeChatClick{
    
    if ([self.popupDelegate respondsToSelector:@selector(WeChatShare)]) {
        [self.popupDelegate WeChatShare];
    }
}

- (void)loopClick{
    
    if ([self.popupDelegate respondsToSelector:@selector(LoopShare)]) {
        [self.popupDelegate LoopShare];
    }
    
}

- (void)cancelClick{
    
    if ([self.popupDelegate respondsToSelector:@selector(CancleShare)]) {
        [self.popupDelegate CancleShare];
    }
    
}

@end
