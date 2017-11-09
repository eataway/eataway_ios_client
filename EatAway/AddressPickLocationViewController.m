//
//  AddressPickLocationViewController.m
//  EatAway
//
//  Created by apple on 2017/6/27.
//  Copyright © 2017年 allen. All rights reserved.
//

#import "AddressPickLocationViewController.h"

#import "SelectViewController.h"

#import <GooglePlaces/GooglePlaces.h>
#import <GoogleMaps/GoogleMaps.h>

#import <MBProgressHUD.h>


@interface AddressPickLocationViewController ()<UITableViewDelegate,UITableViewDataSource,GMSMapViewDelegate,SelectViewControllerDelegate,GMSAutocompleteViewControllerDelegate>
{
    GMSPlacesClient *placeClient;
    GMSMapView *mapViewThis;
    UITableView *_tableView;
    
    NSArray *arrLocations;
    NSString *strLocation;
//    NSArray *arrLocations;
    BOOL isFirstTimeIn;
    
    MBProgressHUD *progress;
}

@end

@implementation AddressPickLocationViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    isFirstTimeIn = YES;
    
    UIView *viewTopMainColor = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WINDOWWIDTH, 64)];
    viewTopMainColor.backgroundColor = MAINCOLOR;
    [self.view addSubview:viewTopMainColor];
    
    
    __weak AddressPickLocationViewController *blockSelf = self;
    progress = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    placeClient = [GMSPlacesClient sharedClient];
    [placeClient currentPlaceWithCallback:^(GMSPlaceLikelihoodList *likelihoodList, NSError *error) {
        [progress hide:YES];
        if (error != nil)
        {
            NSLog(@"Current Place error %@", [error localizedDescription]);
            
            [TotalFunctionView alertContent:ZEString(@"定位失败，请检查是否授予定位权限", @"Locate failure, please check whether to grant location permissions") onViewController:blockSelf];
            
            return;
        }
        
        //        for (GMSPlaceLikelihood *likelihood in likelihoodList.likelihoods) {
        //            GMSPlace* place = likelihood.place;
        //            NSLog(@"Current Place name %@ at likelihood %g", place.name, likelihood.likelihood);
        //            NSLog(@"Current Place address %@", place.formattedAddress);
        //            NSLog(@"Current Place attributions %@", place.attributions);
        //            NSLog(@"Current PlaceID %@", place.placeID);
        //            place.coordinate.latitude
        //        }
        GMSPlaceLikelihood *likelihood = [likelihoodList.likelihoods firstObject];
        arrLocations = likelihoodList.likelihoods;
        [_tableView reloadData];
        
        GMSPlace *place = likelihood.place;
        CLLocationCoordinate2D loca = place.coordinate;
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:loca.latitude
                                                                longitude:loca.longitude
                                                                     zoom:15];
        mapViewThis = [GMSMapView mapWithFrame:CGRectZero camera:camera];
        mapViewThis.delegate = self;
        mapViewThis.myLocationEnabled = YES;
        
        mapViewThis.frame = CGRectMake(0, 64, WINDOWWIDTH , WINDOWWIDTH * 2/3);
        [self.view addSubview:mapViewThis];
        
        
    }];
    [self tableViewInit];
    
    //返回button
    UIButton * backButton = [UIButton buttonWithType:(UIButtonTypeCustom)];
    backButton.frame = CGRectMake(0, 0, 20, 20);
    [backButton addTarget:self action:@selector(backAction) forControlEvents:(UIControlEventTouchUpInside)];
    [backButton setImage:[UIImage imageNamed:@"2.2.0_icon_back"] forState:(UIControlStateNormal)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
    
    UIButton *btnTitle = [UIButton buttonWithType:UIButtonTypeCustom];
    btnTitle.frame = CGRectMake(0, 0, 100, 30);
    [btnTitle setTitle:ZEString(@"请选择城市",@"Select City") forState:UIControlStateNormal];
    [btnTitle addTarget:self action:@selector(btnTitleClick) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setTitleView:btnTitle];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sousuo.png"] style:UIBarButtonItemStylePlain target:self action:@selector(btnSearchPlaceClick)];
    self.navigationItem.rightBarButtonItem = item;

}
-(void)btnTitleClick
{
    SelectViewController *SVC = [[SelectViewController alloc]init];
    SVC.arrSelect = @[ZEString(@"阿德莱德", @"Adelaide")];
    SVC.delegate = self;
    [self.navigationController pushViewController:SVC animated:YES];
}
-(void)btnSearchPlaceClick
{
    GMSAutocompleteViewController *acController = [[GMSAutocompleteViewController alloc] init];
    acController.delegate = self;
    GMSAutocompleteFilter *filter = [[GMSAutocompleteFilter alloc]init];
    filter.country = @"AU";
    acController.autocompleteFilter = filter;
    [self presentViewController:acController animated:YES completion:nil];
}
- (void)viewController:(GMSAutocompleteViewController *)viewController
didAutocompleteWithPlace:(GMSPlace *)place {
    [self dismissViewControllerAnimated:YES completion:nil];
    // Do something with the selected place.
    NSLog(@"Place name %@", place.name);
    NSLog(@"Place address %@", place.formattedAddress);
    NSLog(@"Place attributions %@", place.attributions.string);
    strLocation = [NSString stringWithFormat:@"%f,%f",place.coordinate.longitude,place.coordinate.latitude];
    [self.delegate AddressPickLocationViewControllerSelectResult:place.formattedAddress location:strLocation];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

- (void)viewController:(GMSAutocompleteViewController *)viewController didFailAutocompleteWithError:(NSError *)error {
    [self dismissViewControllerAnimated:YES completion:nil];
    // TODO: handle the error.
    NSLog(@"Error: %@", [error description]);
}

// User canceled the operation.
- (void)wasCancelled:(GMSAutocompleteViewController *)viewController {
    [self dismissViewControllerAnimated:YES completion:nil];
}

// Turn the network activity indicator on and off again.
- (void)didRequestAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)didUpdateAutocompletePredictions:(GMSAutocompleteViewController *)viewController {
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}


-(void)selectViewControllerResult:(NSString *)selectResult identifier:(NSInteger)identifier
{
    if ([selectResult isEqualToString:@"阿德莱德"] || [selectResult isEqualToString:@"Adelaide"])
    {
        UIButton *btn = (UIButton *) self.navigationItem.titleView;
        [btn setTitle:selectResult forState:UIControlStateNormal];
        
        GMSCameraPosition *camera = [GMSCameraPosition cameraWithLatitude:-34.92725
                                                                longitude:138.60013
                                                                     zoom:15];
        [mapViewThis moveCamera:[GMSCameraUpdate setCamera:camera]];
    }
}
-(void)tableViewInit
{
    _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64 + WINDOWWIDTH * 2/3, WINDOWWIDTH, WINDOWHEIGHT - 64 - WINDOWWIDTH * 2/3) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (isFirstTimeIn)
    {
        return arrLocations.count;
    }
    else
    {
        return arrLocations.count;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.numberOfLines = 4;
        cell.textLabel.font = [UIFont systemFontOfSize:13];
        cell.textLabel.backgroundColor = [UIColor redColor];
        cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
    }
    if ([[arrLocations[indexPath.row] class] isSubclassOfClass:[GMSPlaceLikelihood class] ])
    {
        GMSPlaceLikelihood *likelihood = arrLocations[indexPath.row];
        GMSPlace *place = likelihood.place;
        NSString *strStreetNum;
        NSString *strStreet;
        NSString *strRoute;
        for (GMSAddressComponent *aTN in place.addressComponents) {
            if ([aTN.type isEqualToString:@"street_number"])
            {
                strStreetNum = aTN.name;

            }
            else if ([aTN.type isEqualToString:@"route"])
            {
                strStreet = aTN.name;


            }
            else if ([aTN.type isEqualToString:@"administrative_area_level_2"])
            {
                strRoute = aTN.name;


            }
        }
        NSString *strResult = [NSString stringWithFormat:@"%@\n%@ %@ %@",place.name,strStreetNum,strStreet,strRoute];
//        NSLog(@"placename%@,%@",place.name,strStreetNum);
        cell.textLabel.text = [strResult stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
        
    }
    else
    {
        NSDictionary *dic = arrLocations[indexPath.row];
        cell.textLabel.text = [NSString stringWithFormat:@"%@\n%@",dic[@"name"],dic[@"vicinity"]];
    }
 
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[arrLocations[indexPath.row] class] isSubclassOfClass:[GMSPlaceLikelihood class] ])
    {
        GMSPlaceLikelihood *likelihood = arrLocations[indexPath.row];
        GMSPlace *place = likelihood.place;
        strLocation = [NSString stringWithFormat:@"%f,%f",place.coordinate.longitude,place.coordinate.latitude];

    }
    else
    {
        NSDictionary *dic = arrLocations[indexPath.row];
        NSDictionary *dic2 = dic[@"geometry"];
        NSDictionary *dic3 = dic2[@"location"];
        strLocation = [NSString stringWithFormat:@"%@,%@",dic3[@"lng"],dic3[@"lat"]];
        
    }

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *str = cell.textLabel.text;
//    NSArray *arr = [str componentsSeparatedByString:@"\n"];
    [self.delegate AddressPickLocationViewControllerSelectResult:str location:strLocation];
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    

}

- (void)mapView:(GMSMapView *)mapView willMove:(BOOL)gesture {
    [mapView clear];
}

- (void)mapView:(GMSMapView *)mapView
idleAtCameraPosition:(GMSCameraPosition *)cameraPosition
{
    if (isFirstTimeIn)
    {
        isFirstTimeIn = NO;
    }
    else
    {
        NSString *strLanguage;
        if (ISCHINESE)
        {
            strLanguage = @"zh-CN";
        }
        else
        {
            strLanguage = @"en-AU";
        }
        NSString *strFullURL = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/nearbysearch/json?key=AIzaSyALGaiTt9yKrhN0QRCtANnwsLYbWFxJDmM&language=%@&location=%f,%f&radius=1000",strLanguage,cameraPosition.target.latitude,cameraPosition.target.longitude];
        NSLog(@"=====%@",strFullURL);
        [[ObjectForRequest shareObject] requestGetWithFullURL:strFullURL resultBlock:^(NSDictionary *resultDic)
         {
             arrLocations = resultDic[@"results"];
             [_tableView reloadData];
         }];
        

    }
    
    
}

- (void)backAction{
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning
{
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
