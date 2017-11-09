//
//  MyOrderModel.h
//  EatAway
//
//  Created by BossWang on 17/7/6.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "JSONModel.h"

@interface MyOrderModel : JSONModel

@property (nonatomic, copy)NSString <Optional> * shopname;
@property (nonatomic, copy)NSString <Optional> * addtime;
@property (nonatomic, copy)NSString <Optional> * allprice;
@property (nonatomic, copy)NSString <Optional> * shopphoto;
@property (nonatomic, copy)NSString <Optional> * state;
@property (nonatomic, copy)NSString <Optional> * statu;

//msg =     (
//           {
//               address = 123123;
//               addtime = "2017-07-05 17:19:34";
//               allprice = "48.00";
//               beizhu = 124231;
//               bkm = "";
//               cometime = "<null>";
//               content = "";
//               coordinate = "12312,1231213";
//               "detailed_address" = "";
//               endtime = "<null>";
//               gotime = " ";
//               lkm = "";
//               long = "";
//               maxlong = "";
//               maxprice = "";
//               mobile = 134132141;
//               money = "12.00";
//               name = "";
//               orderid = 1499246374;
//               phone = "";
//               sex = 0;
//               shophead = "uploads/d26954546bc972b28038d40ef6ba1fa6.png";
//               shopid = 1;
//               shopname = dasdfafd;
//               shopphoto = "uploads/d26954546bc972b28038d40ef6ba1fa6.png";
//               state = 1;
//               uid = 16;
//           },
@end
