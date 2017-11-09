//
//  Header.h
//  EatAway
//
//  Created by BossWang on 17/7/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#ifndef Header_h
#define Header_h

//#define Server_Address @"http://192.168.0.111/index.php/home/"
#define Server_Address @"http://192.168.2.126/tp/index.php/home/"

/**
 * 我的订单列表
 */
#define Server_Orderlist [Server_Address stringByAppendingString:@"order/orderlist"]


/**
 * 修改用户名
 */
#define Server_EditUsername [Server_Address stringByAppendingString:@"user/edit_username"]

/**
 * 换绑手机号
 */
#define Server_Editmobile [Server_Address stringByAppendingString:@"user/editmobile"]

#endif /* Header_h */
