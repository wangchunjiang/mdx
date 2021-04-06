//
//  HSSearchPlaceVC.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/2/2.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSSearchPlaceVC.h"
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>

#import "HSSearchNavView.h"
@interface HSSearchPlaceVC ()<AMapSearchDelegate,UITableViewDataSource, UITableViewDelegate>

@property(nonatomic,strong)HSSearchNavView * navView;

@property (nonatomic, strong) NSMutableArray *tips;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation HSSearchPlaceVC

-(void)viewWillAppear:(BOOL)animated{
    
    [self hiddenCustomNavBar];
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self showCustomNavBar];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    [self.view addSubview:self.navView];
    
     self.tips = [NSMutableArray array];
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
     [self initTableView];
    MJWeakSelf
    [[self.navView.backBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
       
        [weakSelf.navigationController popViewControllerAnimated:YES];
    }];
    
    
    [[self.navView.searchField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
       
        NSLog(@"searchText===%@",x);
          [weakSelf searchTipsWithKey:x];
    }];
    
    
    
}

- (void)initTableView
{
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, Navi_heightAll, Screen_width, Screen_height-Navi_heightAll) style:UITableViewStylePlain];
    
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;

    
    [self.view addSubview:self.tableView];
}

#pragma mark - Utility

/* 输入提示 搜索.*/
- (void)searchTipsWithKey:(NSString *)key
{
    if (key.length == 0)
    {
        return;
    }
    
    AMapInputTipsSearchRequest *tips = [[AMapInputTipsSearchRequest alloc] init];
    tips.keywords = key;
    tips.city     = self.currentCity;
    tips.cityLimit = YES;
    
    [self.search AMapInputTipsSearch:tips];
}

- (void)searchPOIWithTip:(AMapTip *)tip
{
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    request.cityLimit = YES;
    request.keywords         = tip.name;
    request.city             = self.currentCity;
    request.requireExtension = YES;
    [self.search AMapPOIKeywordsSearch:request];
}

#pragma mark - MAMapViewDelegate

//- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
//{
//    if ([annotation isKindOfClass:[POIAnnotation class]] || [annotation isKindOfClass:[AMapTipAnnotation class]])
//    {
//        static NSString *tipIdentifier = @"poiIdentifier";
//
//        MAPinAnnotationView *poiAnnotationView = (MAPinAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:tipIdentifier];
//        if (poiAnnotationView == nil)
//        {
//            poiAnnotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:tipIdentifier];
//        }
//
//        poiAnnotationView.canShowCallout = YES;
//
//        return poiAnnotationView;
//    }
//    return nil;
//}

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:overlay];

        polylineRenderer.lineWidth   = 4.f;
        polylineRenderer.strokeColor = [UIColor magentaColor];

        return polylineRenderer;
    }

    return nil;
}

#pragma mark - AMapSearchDelegate

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error
{
    NSLog(@"Error: %@", error);
}

/* 输入提示回调. */
- (void)onInputTipsSearchDone:(AMapInputTipsSearchRequest *)request response:(AMapInputTipsSearchResponse *)response
{
    if (response.count == 0)
    {
        return;
    }
    
    [self.tips setArray:response.tips];
  
    
    
    [self.tableView reloadData];
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    NSLog(@"self.tips.count===%d",self.tips.count);
    return self.tips.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *tipCellIdentifier = @"tipCellIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tipCellIdentifier];
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:tipCellIdentifier];
    }
    
    AMapTip *tip = self.tips[indexPath.row];

    cell.textLabel.text = tip.name;
    cell.detailTextLabel.text = tip.address;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [self.mapView removeAnnotations:self.mapView.annotations];
    
    AMapTip *tip = self.tips[indexPath.row];
    
    if (tip.uid != nil && tip.location != nil) /* 可以直接在地图打点  */
    {
        AMapTipAnnotation *annotation = [[AMapTipAnnotation alloc] initWithMapTip:tip];
        NSLog(@"AMapTipAnnotation====%@",annotation.title);
        
        if ([self.delegate respondsToSelector:@selector(selectPlace:)]) {
            [self.delegate selectPlace:annotation];
        }
        
        [self.navigationController popViewControllerAnimated:YES];

    }
    else
    {
        [self searchPOIWithTip:tip];
    }
    

}

-(HSSearchNavView*)navView{
    if (!_navView) {
        _navView = [[HSSearchNavView alloc]initWithFrame:CGRectMake(0, 0, Screen_width, Navi_heightAll)];
    }
    
    return _navView;
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
