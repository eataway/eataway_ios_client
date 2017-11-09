//
//  GoogleOnlyMapViewController.m
//  EatAway
//
//  Created by apple on 2017/8/7.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "GoogleOnlyMapViewController.h"

@import GoogleMaps;

@interface GoogleOnlyMapViewController ()

@end

@implementation GoogleOnlyMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    topView.backgroundColor = MAINCOLOR;
    [self.view addSubview:topView];
    
    self.title = ZEString(@"地址", @"Address");
    
    NSArray *arr = [self.strLocation componentsSeparatedByString:@","];
    CGFloat lng = [[arr firstObject] floatValue];
    CGFloat lat = [[arr lastObject] floatValue];
    GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:lat
                                                            longitude:lng
                                                                 zoom:15];
    GMSMapView *mapView = [GMSMapView mapWithFrame:CGRectZero camera:camera];
    mapView.frame = CGRectMake(0, 64, WINDOWWIDTH, WINDOWHEIGHT - 64);
////    CLLocation *myLocation =  [[CLLocation alloc] initWithLatitude:lat longitude:lng];
////    mapView  = myLocation;
//    mapView.myLocationEnabled = YES;
//    mapView.accessibilityElementsHidden = NO;
    [self.view addSubview:mapView];
    
    CLLocationCoordinate2D position = CLLocationCoordinate2DMake(lat, lng);
    GMSMarker *marker = [GMSMarker markerWithPosition:position];
//    marker.title = @"Hello World";
    marker.map = mapView;
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
