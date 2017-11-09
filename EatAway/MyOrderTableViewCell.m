//
//  MyOrderTableViewCell.m
//  EatAway
//
//  Created by BossWang on 17/7/4.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "MyOrderTableViewCell.h"
#import "MyOrderModel.h"

@interface MyOrderTableViewCell()

@property (nonatomic, strong) UIImageView *imageVC;
@property (nonatomic, retain) UIImageView *openOrNoImg;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *timeLab;
@property (nonatomic, strong) UILabel *statusLab;
@property (nonatomic, strong) UIButton *ReceivingBtn;
@property (nonatomic, strong) UIButton *againOrderBtn;
@property (nonatomic, strong) UILabel *TotalLab;
@property (nonatomic, strong) UILabel *priceLab;
@property (nonatomic, strong) UIButton *contactSeller;
@property (nonatomic, strong) UIButton *evaluationBtn;
@property (nonatomic, retain) UILabel *contactLab;
@property (nonatomic, retain) UIButton *contactBtn;
@property (nonatomic, retain) UIButton *EvaluateBtn;

@end
@implementation MyOrderTableViewCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self setUp];
        self.backgroundColor = EWColor(240, 240, 240, 1);
    }
    return self;
}

- (void)setUp{
    UIView *whiteView = [[UIView alloc]initWithFrame:CGRectMake(10, 20, WINDOWWIDTH - 20, 160)];
    whiteView.backgroundColor = [UIColor whiteColor];
    whiteView.clipsToBounds = YES;
    whiteView.layer.cornerRadius = 5;
    [self addSubview:whiteView];
    
    self.imageVC = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 80, 60)];
    self.imageVC.image = [UIImage imageNamed:@""];
//    self.imageVC.backgroundColor = [UIColor redColor];
    [whiteView addSubview:self.imageVC];
    
    self.openOrNoImg = [[UIImageView alloc]initWithFrame:CGRectMake(whiteView.frame.size.width - 40, 0, 40, 40)];
    self.openOrNoImg.image = [UIImage imageNamed:@"3.1.0_tag_01"];
    [whiteView addSubview:self.openOrNoImg];
    self.titleLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageVC.frame) + 10, 10, WINDOWWIDTH - 130, 30)];
    self.titleLab.textColor = EWColor(51, 51, 51, 1);
    self.titleLab.textAlignment = NSTextAlignmentLeft;
//    self.titleLab.backgroundColor = [UIColor redColor];
    self.titleLab.text = @"迷彩衣清爽夏日新款";
    [whiteView addSubview:self.titleLab];
    
    self.timeLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.imageVC.frame) + 10, CGRectGetMaxY(self.titleLab.frame), WINDOWWIDTH - 130, 20)];
    self.timeLab.textAlignment = NSTextAlignmentLeft;
    self.timeLab.font = [UIFont systemFontOfSize:12];
    self.timeLab.text = @"下单时间: 2017-07-10";
    self.timeLab.textColor = EWColor(102, 102, 102, 1);
    [whiteView addSubview:self.timeLab];
    
    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageVC.frame) + 20, WINDOWWIDTH - 20, 1)];
    lineView.backgroundColor = EWColor(240, 240, 240, 1);
    [whiteView addSubview:lineView];
    
    self.statusLab = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineView.frame) + 10, WINDOWWIDTH / 2, 30)];
    self.statusLab.textColor = [UIColor colorWithRed:0.97f green:0.69f blue:0.37f alpha:1.00f];
    self.statusLab.font = [UIFont systemFontOfSize:15];
    self.statusLab.textAlignment = NSTextAlignmentLeft;
    self.statusLab.text = @"卖家已接单";
    self.statusLab.hidden = YES;
    [whiteView addSubview:self.statusLab];
    
    self.ReceivingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.ReceivingBtn.frame = CGRectMake(14, CGRectGetMaxY(lineView.frame) + 20, 100, 30);
    self.ReceivingBtn.backgroundColor = [UIColor orangeColor];
    self.ReceivingBtn.clipsToBounds = YES;
    self.ReceivingBtn.layer.cornerRadius = 5;
    [self.ReceivingBtn setTitle:@"确认送达" forState:UIControlStateNormal];
    self.ReceivingBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.ReceivingBtn addTarget:self action:@selector(receivingClick) forControlEvents:UIControlEventTouchUpInside];
    self.ReceivingBtn.hidden = YES;
    [whiteView addSubview:self.ReceivingBtn];
    
    self.againOrderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.againOrderBtn.frame = CGRectMake(14, CGRectGetMaxY(lineView.frame) + 20, 100, 30);
    self.againOrderBtn.layer.borderWidth = 1;
    self.againOrderBtn.layer.borderColor = [UIColor colorWithRed:0.96f green:0.62f blue:0.20f alpha:1.00f].CGColor;
    self.againOrderBtn.clipsToBounds = YES;
    self.againOrderBtn.layer.cornerRadius = 5;
    [self.againOrderBtn setTitle:@"再来一单" forState:UIControlStateNormal];
    [self.againOrderBtn setTitleColor:[UIColor colorWithRed:0.96f green:0.62f blue:0.20f alpha:1.00f] forState:UIControlStateNormal];
    self.againOrderBtn.titleLabel.font = [UIFont systemFontOfSize:15];
    [self.againOrderBtn addTarget:self action:@selector(againOrderClick) forControlEvents:UIControlEventTouchUpInside];
    self.againOrderBtn.hidden = YES;
    [whiteView addSubview:self.againOrderBtn];
    
    self.TotalLab = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 120, CGRectGetMaxY(lineView.frame) + 15, 40, 30)];
    self.TotalLab.textColor = EWColor(51, 51, 51, 1);
    self.TotalLab.text = @"总计";
    self.TotalLab.textAlignment = NSTextAlignmentLeft;
    [whiteView addSubview:self.TotalLab];
    
    self.priceLab = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.TotalLab.frame), CGRectGetMaxY(lineView.frame) + 10, 40, 40)];
    self.priceLab.textAlignment = NSTextAlignmentRight;
    self.priceLab.textColor = [UIColor redColor];
    self.priceLab.font = [UIFont systemFontOfSize:14];
    self.priceLab.text = @"¥66";
    [whiteView addSubview:self.priceLab];
    
    self.contactLab = [[UILabel alloc]initWithFrame:CGRectMake(WINDOWWIDTH - 160, CGRectGetMaxY(self.TotalLab.frame), 80, 20)];
    self.contactLab.font = [UIFont systemFontOfSize:12];
//    self.contactLab.backgroundColor = [UIColor redColor];
    self.contactLab.text = ZEString(@"如需退单 请先", @"Return from please ");
    self.contactLab.hidden = YES;
    [whiteView addSubview:self.contactLab];
    
    
    self.contactBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.contactBtn.frame = CGRectMake(CGRectGetMaxX(self.contactLab.frame), CGRectGetMaxY(self.TotalLab.frame), 100, 20);
    self.contactBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.contactBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    NSMutableAttributedString *title2 = [[NSMutableAttributedString alloc] initWithString:ZEString(@"联系卖家", @"Contact ther seller")];
    NSRange titleRange2 = {0,[title2 length]};
    [title2 addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange2];
    [title2 addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange2];
    [self.contactBtn setAttributedTitle:title2 forState:UIControlStateNormal];
    self.contactBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.contactBtn addTarget:self action:@selector(ContactMerchantClick) forControlEvents:UIControlEventTouchUpInside];
    self.contactBtn.hidden = YES;
    [whiteView addSubview:self.contactBtn];
    
    self.EvaluateBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.EvaluateBtn.frame = CGRectMake(CGRectGetMaxX(self.contactLab.frame), CGRectGetMaxY(self.TotalLab.frame), 100, 20);
    self.EvaluateBtn.titleLabel.font = [UIFont systemFontOfSize:12];
    [self.EvaluateBtn setTitleColor:MAINCOLOR forState:UIControlStateNormal];
    NSMutableAttributedString *EvaluateTitle = [[NSMutableAttributedString alloc] initWithString:ZEString(@"去评价", @"To evaluate")];
    NSRange titleRange3 = {0,[EvaluateTitle length]};
    [EvaluateTitle addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:titleRange3];
    [EvaluateTitle addAttribute:NSForegroundColorAttributeName value:MAINCOLOR range:titleRange3];
    [self.EvaluateBtn setAttributedTitle:EvaluateTitle forState:UIControlStateNormal];
    self.EvaluateBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self.EvaluateBtn addTarget:self action:@selector(EvaluateBtnClick) forControlEvents:UIControlEventTouchUpInside];
    self.EvaluateBtn.hidden = YES;
    [whiteView addSubview:self.EvaluateBtn];
    
}

- (void)EvaluateBtnClick{ //去评价的点击事件
    
    
}
//联系卖家的点击事件
- (void)ContactMerchantClick{
    
    
}
//确认收获的点击事件
- (void)receivingClick{
    
    if ([self.myOrderDelegate respondsToSelector:@selector(affineTransform)]) {
        [self.myOrderDelegate affirmReceiving];
    }
}
//再来一单的点击事件
- (void)againOrderClick{
    if ([self.myOrderDelegate respondsToSelector:@selector(againOrder)]) {
        [self.myOrderDelegate againOrder];
    }
    
}

- (void)setOrderModel:(MyOrderModel *)orderModel{
    [self.imageVC sd_setImageWithURL:[NSURL URLWithString:orderModel.shopphoto] placeholderImage:[UIImage imageNamed:@"placehoder2.png"]];
    self.titleLab.text = orderModel.shopname;
    self.timeLab.text = [NSString stringWithFormat:@"下单时间:%@",orderModel.addtime];
    self.priceLab.text = [NSString stringWithFormat:@"¥%@",orderModel.allprice];
    
    if ([orderModel.statu intValue] == 1)
    {
        self.statusLab.text = ZEString(@"退单中", @"Refunding");
        self.statusLab.hidden = NO;
        self.statusLab.textColor = [UIColor colorWithRed:0.93f green:0.24f blue:0.23f alpha:1.00f];
    }
    else if ([orderModel.statu intValue] == 3)
    {
        self.statusLab.text = ZEString(@"已退单", @"Refunded");
        self.statusLab.hidden = NO;
        self.statusLab.textColor = [UIColor colorWithRed:0.93f green:0.24f blue:0.23f alpha:1.00f];
    }
    else
    {
    if ([orderModel.state intValue] == 1) {
        self.statusLab.text = @"等待卖家接单";
        self.statusLab.textColor = [UIColor colorWithRed:0.93f green:0.24f blue:0.23f alpha:1.00f];
        self.statusLab.hidden = NO;
        self.openOrNoImg.image = [UIImage imageNamed:@"3.1.0_tag_01"];
    }else if ([orderModel.state intValue] == 2){
        
        self.statusLab.hidden = NO;
        self.openOrNoImg.image = [UIImage imageNamed:@"3.1.0_tag_02"];
    }else if ([orderModel.state intValue] == 3){
        
        self.ReceivingBtn.hidden = NO;
        self.openOrNoImg.image = [UIImage imageNamed:@"3.1.0_tag_03"];
        
    }else{
        
        self.againOrderBtn.hidden = NO;
        self.openOrNoImg.image = [UIImage imageNamed:@"3.1.0_tag_04"];
    }
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
