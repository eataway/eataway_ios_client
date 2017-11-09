//
//  BraintreeViewController.m
//  EatAway
//
//  Created by apple on 2017/7/3.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "BraintreeViewController.h"

#import <Braintree/Braintree.h>
#import <MBProgressHUD.h>


@interface BraintreeViewController ()<BTDropInViewControllerDelegate>
{
    MBProgressHUD *progress;

}
@property (nonatomic, strong) Braintree *braintree;


@end

@implementation BraintreeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [[ObjectForRequest shareObject] requestGetWithFullURL:[NSString stringWithFormat:@"%@/%@",HTTPHOST,@"index.php/home/order/brtoken"] resultBlock:^(NSDictionary *resultDic) {
        [progress hide:YES];
        if (resultDic!= nil)
        {
            [[NSUserDefaults standardUserDefaults] setObject:resultDic[@"token"] forKey:@"braintreetoken"];
            self.braintree = [Braintree braintreeWithClientToken:BRAINTREETOKEN];

            BTDropInViewController *dropInViewController = [self.braintree dropInViewControllerWithDelegate:self];
            // This is where you might want to customize your Drop in. (See below.)
            
            // The way you present your BTDropInViewController instance is up to you.
            // In this example, we wrap it in a new, modally presented navigation controller:
            dropInViewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                                                  target:self
                                                                                                                  action:@selector(userDidCancelPayment)];
            
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:dropInViewController];
            [self presentViewController:navigationController animated:YES completion:nil];
            
            
        }
        else
        {
            [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"braintreetoken"];
        }
    }];
    
}
-(void)viewDidAppear:(BOOL)animated
{
    
}
- (void)dropInViewController:(__unused BTDropInViewController *)viewController didSucceedWithPaymentMethod:(BTPaymentMethod *)paymentMethod
{
    NSLog(@"PostContent = %@",paymentMethod.nonce);
    
//    [self postNonceToServer:paymentMethod.nonce]; // Send payment method nonce to your server
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)dropInViewControllerDidCancel:(__unused BTDropInViewController *)viewController
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)userDidCancelPayment
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
