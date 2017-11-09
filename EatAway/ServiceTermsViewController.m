//
//  ServiceTermsViewController.m
//  EatAway
//
//  Created by apple on 2017/8/14.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "ServiceTermsViewController.h"
#import "ServiceTerms1TableViewCell.h"
#import "ServiceTerm2TableViewCell.h"

#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight  [UIScreen mainScreen].bounds.size.height

@interface ServiceTermsViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    NSString *detailStr;
}

@property(strong,nonatomic) UITableView *tableView;

@property(strong,nonatomic) NSMutableArray *titleArray;

@property(strong,nonatomic) NSMutableArray *contentArray;
@end

@implementation ServiceTermsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
    self.titleArray = @[@"1.Information",@"2.Restaurant Creation Services",@"3.RESTAURANT APPLICATION PAGE AND EATAWAY SERVICES",@"4.SERVICE CHARGES",@"5.PRICES AND PAYMENT",@"6.Temporary or Permanent Suspension of Restaurants",@"7.Our Obligations",@"8.Liability",@"9.Intellectual Property Rights",@"10.CONFIDENTIALITY",@"11.Termination",@"12.SEVERABILITY",@"13.ADDITIONAL TERMS"].mutableCopy;
    
    
    self.contentArray = @[@"1.1. EatAway Pty Ltd (ACN 619 553 356) via our Mobile EatAway Applications (“App”) makes it convenient for consumers to find the online information of Partner Restaurants (“Restaurants”) including but not limited to the phone number, restaurant address, contact numbers and photo, and to order food, drinks and other items (“Products”) from the Restaurant (the “Service”).\n\n1.2. The parties (EatAway and the Partner Restaurant) agree to co-operate in receiving orders placed through the Apps, except when EatAway agrees to let the Restaurant opt-out of receiving orders from part of the service.",@"2.1. The Restaurant agrees that EatAway will create a page on App and may choose to create a website page to promote the restaurant.\n\n2.2. The Restaurant agrees to give full access to their marketing, branding and menu assets to be used by EatAway.\n\n2.3. The Restaurant agrees to provide a logo to EatAway to be used to promote their restaurant. If the logo does not match are requirement of quality and format, EatAway may reproduce the logo to be used on the Website.\n\n2.4. All user interfaces, photographs, trademarks, graphics, artwork and menu translations including the layout, design and expression of the content contained on the EatAway Mobile Applications and Website are owned, controlled or licensed to EatAway, and are protected by trademark, copyright and patent laws, and shall at all times remain the property of EatAway.\n\n2.5. The Restaurant agrees that EatAway may promote The Restaurant on social media platforms (including WeChat, Facebook, Instagram and Weibo). EatAway can not be held responsible for any loss to business that comes from reviews, comments and/or Restaurant mismanagement of these services. EatAway will give the Restaurant full rights to access these services. EatAway is not responsible for customer reviews posted to the Restaurant (including but not limited to on our App and Website).\n\n2.6. The Restaurant will be alerted to all comments and reviews that it receives and will be granted full rights to respond to reviews and comments.",@"3.1. The Restaurant agrees to receive, process, prepare and deliver Customer orders received via the EatAway Mobile Application, practicing due care and diligence in accordance with The Restaurant’s Industry best practice. The Restaurant undertakes to prepare items listed in the order without error, and to contact the customer directly if The Restaurant needs to makes changes to the order. It is the Restaurants Responsibility to provide an official receipt to the customer if requested.\n\n3.2. The Restaurant can opt out of receiving orders placed through the EatAway Service by emailing contact@eataway.com.au or calling us the number listed under “about us” on our Website and Mobile Application.\n\n3.3. When the Restaurant delivers the order, The Restaurant must check with the customer to confirm the correct recipient receives the order.\n\n3.4. The Restaurant agrees to check daily that daily that the prices and other information contained in menus and advertising material provided to EatAway is correct and in accordance with all applicable law. Any errors in the information provided to EatAway should be reported immediately to us so we can make the appropriate changes in accordance with all applicable law. The Restaurant understands that they are solely responsible for the information contained on the EatAway App that relates to their business, including menus, pricing, logos and the Restaurant profile.\n\n3.5. Allergy information: The Restaurant must constantly update EatAway with details of any allergy information in relation to the dishes prepared and sold by the Restaurant (including but not limited to dishes that contain nuts). To the full extent permitted by Australian law, EatAway accepts no liability in the food preparation and delivery undertaken by the Restaurant accepting the order, therefore The Restaurant shall always be responsible for the accuracy of the allergy information.\n\n3.6. EatAway will regularly update the information about the website, and will guarantee to make updates within 5 working days of receiving and email to contact@eataway.com.au from the restaurant to make changes to information such as menu items and prices. The Restaurant agrees that the menu price must be the same price on the Website as they are in hard copy versions used by the Restaurant.\n\n3.7. The Restaurant agrees at all times to be responsible for maintaining necessary regulations and consents to comply with applicable laws. The restaurant agrees to indemnify EatAway and all applicable affiliates, employees and directors against liability against any demands, proceedings, losses and damages of every kind of nature, known and unknown, including legal fees on the indemnity basis, made by any third party or resulting from your breach of these Terms and Conditions and policies it incorporates by reference, or your violation of any law or the rights of a third party.\n\n3.8. The Restaurant shall at all times comply with EatAway’s terms and conditions that are available on the website eataway.com.au, and comply with all security obligations relating to customer data.\n\n3.9.The Restaurant agrees to refer positively to EatAway in relation to any publicity regarding the Service and in accordance with the guidelines provided by EatAway.\n\n3.10. EatAway will work with the Restaurant to set up the Restaurant’s profile, menu and logo on the application within 10 working days of the two parties agreeing to work together.",@"4.1. Unless otherwise agreed upon via a written agreement (including email) EatAway will charge the Restaurant a commission fee of 10% of the total gross order value of each order from a consumer using the Service. The Commission rate may differ from 10% when agreed by EatAway and the Partner Restaurant.\n\n4.2. Commission is chargeable on all orders placed by a consumer using the EatAway Mobile Application.\n\n4.3. The Gross Order Value of each order placed on the EatAway Mobile Application is the total sum charged to the consumer placing the order (Including any additional transaction fees that the Restaurant chooses to pass onto the Consumer).\n\n4.4. EatAway reserves the right to change the Commission rates and fees for the services by giving the Restaurant a one month’s advance notice.",@"5.1. Twice per month EatAway shall provide a statement of all accounts between the Partner Restaurant and the EatAway Mobile Application (“Twice Monthly Statement”). This statement will include records of all online payments received by EatAway for orders.\n\n5.2. Any payment under this Restaurant Agreement shall be due and payable within 7 days of the date of invoice, whichever of the parties is invoiced.\n\n5.3. In the case of any overdue payments the parties are entitled to a written agreement to set off the outstanding accounts until the next Twice Monthly Statement.\n\n5.4. In the case that the Restaurant disagrees with the Twice Monthly Statement issued by EatAway, the Restaurant must notify EatAway via email to contact@eataway.com.au of the disagreement within 14 days of receiving the statement, after 14 days the Twice Monthly",@"6.1. If in the opinion of EatAway the Partner Restaurant does not meet the relevant and applicable laws and regulations outlined in this Restaurant Agreement and/or in the terms and conditions found on our website (eataway.com.au) EatAway shall be entitled to remove the Restaurant’s logo, menu’s and all affiliated material from our Service without liability to the Restaurant. Further reasons for suspension include breaching industry standard guidelines including:\n\n6.1.1 consistently being impolite to customers who have made orders\n\n6.1.2. providing incorrect meals and drinks to customers on a regular basis\n\n6.1.3. providing late and/or poor food delivery services on a regular basis\n\n6.1.4. using dishonest means to encourage orders on our application (such as writing fake reviews, leaving fake ratings, cancelling online orders that are subsequently fulfilled).\n\n6.2 EatAway reserves the right to inspect the Partner Restaurant’s premises on 24 notices.",@"7.1. We intend to and will make our best efforts to keep our Mobile Application available and functional 24/7, however we are under no liability to do so. Therefore EatAway shall not be liable for any lack of availability of the Mobile EatAway Application or the Website caused by unforeseen conditions (including but not limited to bad weather and technical problems).\n\n7.2. EatAway is entitled to halt access to our Service at any time and without notice in order to maintain and update our application.\n\n7.3. It is our intention that our Mobile EatAway Application and Website comply with all applicable laws and regulations at any given time.\n\n7.4. Where EatAway, in our sole discretion agrees to grant a full or partial refund to a customer who has paid for an order on the Restaurants application page using any of the available payment methods, the Restaurant agrees to allow EatAway to apply the refund on their behalf and thereby agrees to receive no payment from EatAway for the refunded portion of the order.",@"8.1. To the full extent applicable under Australian Law, under no circumstances will EatAway be liable to the Restaurant for any losses or damage, whether in contract, tort, breach of statutory duty or otherwise, even foreseeable damages arising from the use of the service including any loss of damage (including any indirect or consequential loss of revenue or profits, loss of business opportunity, loss or corruption of data) arising from or in connection to our Service.\n\n8.2. If a customers payment is withheld due to misuse of the payment account, or due to faults of the Restaurant’s delivery, the Restaurant is not entitled to payment from EatAway. Thereby, any withheld payment already made to the restaurant before being reversed by Paypal or the card provider will be deducted from a subsequent invoice to the restaurant.\n\n8.3. The Restaurant agrees to indemnify EatAway and all applicable affiliates, employees and directors against liability against any demands, proceedings, losses and damages of every kind of nature, known and unknown, including legal fees on the indemnity basis, made by any third party or resulting from your breach of these Terms and Conditions and policies it incorporates by reference, or your violation of any law or the rights of a third party.\n\n8.4. This clause 8 shall survive termination of the Restaurant Agreement.",@"9.1. All user interfaces, photographs, trademarks, graphics, artwork and menu translations including the layout, design and expression of the content contained on the EatAway Mobile Applications and Website are owned, controlled or licensed to EatAway, and are protected by trademark, copyright and patent laws.\n\n9.2. The Restaurant confirms to EatAway that the Restaurant’s menu, logo, name and other material does not violate with Intellectual Property Rights of any third party.",@"10.1. The content of this Restaurant Agreement and any information concerning the other party is to be treated as confidential and shall not be disclosed unless such information is generally accessible to the public. However, EatAway is entitled to use the Restaurant’s name as a reference.",@"We may revoke or suspend your right to use the Service immediately by notifying you via written mail or email if we believe that you have breached our terms and conditions.",@"If any Terms become illegal, unlawful or unenforceable it shall be modified to the minimum extent necessary to make it valid, legal and enforceable. Any modification and or deletion of a provision or part-provision will not affect the remaining terms, conditions and provisions that will continue to be valid to the fullest extend permitted by law.",@"NO WAIVER: NO FAILURE OR DELAY BY YOU OR US TO EXERCISE ANY PROVISION OF THESE TERMS SHALL CONSTITUTE A WAIVER OF YOUR OR OUR RIGHTS OR REMEDIES.\n\nSEVERABILITY: IF ANY TERMS BECOME ILLEGAL, UNLAWFUL OR UNENFORCEABLE IT SHALL BE MODIFIED TO THE MINIMUM EXTENT NECESSARY TO MAKE IT VALID, LEGAL AND ENFORCEABLE. ANY MODIFICATION AND OR DELETION OF A PROVISION OR PART-PROVISION WILL NOT AFFECT THE REMAINING TERMS, CONDITIONS AND PROVISIONS THAT WILL CONTINUE TO BE VALID TO THE FULLEST EXTEND PERMITTED BY LAW.\n\nTHESE TERMS AND CONDITIONS SHALL BE GOVERNED IN ACCORDANCE WITH THE LAWS OF THE STATE OF SOUTH AUSTRALIA AND THE COMMONWEALTH OF AUSTRALIA. IF YOU ACCESS OUR WEBSITE OR MOBILE APPLICATIONS FROM OUTSIDE AUSTRALIA, YOU DO SO KNOWING THAT YOU ARE RESPONSIBLE FOR ENSURING COMPLIANCE WITH ALL LAWS IN THE PLACE THAT YOU ARE LOCATED."].mutableCopy;
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"服务条款";
    
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight - 64) style:UITableViewStyleGrouped];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = 0;
    self.tableView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceTerms1TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServiceTerms1TableViewCell_Identify];
    [self.tableView registerNib:[UINib nibWithNibName:@"ServiceTerm2TableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:ServiceTerm2TableViewCell_Identify];
    
}



-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        return 147;
    }
    
    CGSize titleHeight = [self sizeOfTitleString:self.titleArray[indexPath.section - 1]];
    
    CGSize detailHeight = [self sizeOfString:self.contentArray[indexPath.section - 1]];
    
    return titleHeight.height + detailHeight.height + 16;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.titleArray.count + 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section == 0) {
        ServiceTerms1TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceTerms1TableViewCell_Identify];
        
        cell.selectionStyle = 0;
        
        return cell;
    }
    else
    {
        ServiceTerm2TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ServiceTerm2TableViewCell_Identify];
        
        cell.selectionStyle = 0;
        
        cell.titleLabel.text = self.titleArray[indexPath.section - 1];
        
        cell.contentLabel.text = self.contentArray[indexPath.section - 1];
        
        return cell;
    }
}

-(CGSize)sizeOfString:(NSString *)str
{
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:17], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(WINDOWWIDTH - 16, 9999) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return labelSize;
}

-(CGSize)sizeOfTitleString:(NSString *)str{
    
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:21], NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    CGSize labelSize = [str boundingRectWithSize:CGSizeMake(WINDOWWIDTH - 16, 10000) options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
    
    return labelSize;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
