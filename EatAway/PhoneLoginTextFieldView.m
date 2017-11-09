//
//  PhoneLoginTextFieldView.m
//  EatAway
//
//  Created by apple on 2017/6/13.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "PhoneLoginTextFieldView.h"

@implementation PhoneLoginTextFieldView



-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        UIView *viewBG = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width,frame.size.height)];
        viewBG.backgroundColor = [UIColor colorWithWhite:247/255.0 alpha:1];
        viewBG.clipsToBounds = YES;
        viewBG.layer.cornerRadius = 7;
        viewBG.layer.borderWidth = 1;
        viewBG.layer.borderColor = [UIColor colorWithWhite:230/255.0 alpha:1].CGColor;
        [self addSubview:viewBG];
        
        _imageV = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 25, 25)];
        [self addSubview:_imageV];
        
        _textField = [[UITextField alloc]initWithFrame:CGRectMake(10 + 25 + 10, 10, frame.size.width - (10 + 25 + 10 + 10), 25)];
        _textField.font = [UIFont systemFontOfSize:13];
        [self addSubview:_textField];
        
    }
    return self;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
