//
//  HSSelectCityVC.m
//  ManduoXingUser
//
//  Created by 王春江 on 2021/1/29.
//  Copyright © 2021 wkym. All rights reserved.
//

#import "HSSelectCityVC.h"
#import <CoreLocation/CoreLocation.h>
#import "HSCityView.h"
#import "HSSearchCityResultView.h"
#import "HSCityTopSearchView.h"
@interface HSSelectCityVC ()<CLLocationManagerDelegate>{
    
      BOOL _isLocationed; // 是否已经获得定位信息
}
@property (nonatomic, strong) CLLocationManager* locationManager;
@property (nonatomic, strong) HSCityView * cityView;
@property (nonatomic, strong) HSSearchCityResultView * searchResultView;
@property (nonatomic, strong) HSCityTopSearchView * searchView;
@property (nonatomic,strong)NSMutableArray *searchArray;//用于搜索的数组
@property (nonatomic,strong)NSMutableArray *pinYinArray; // 地区名字转化为拼音的数组
@property (nonatomic,strong)NSDictionary *bigDic; // 读取本地plist文件的字典



@end

@implementation HSSelectCityVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"选择城市";
    
    [self startLocation];
    [self.view addSubview:self.searchView];
    [self.view addSubview:self.cityView];
    [self.view addSubview:self.searchResultView];
    
    [self loadData];
    
//    [self.cityView.headerView.searchField addTarget:self action:@selector(searchFieldChanged:) forControlEvents:(UIControlEventValueChanged)];
    MJWeakSelf
//    [[self.cityView.headerView.searchField rac_textSignal]subscribeNext:^(NSString * _Nullable x) {
//
//        NSLog(@"x===%@",x);
//        [weakSelf searchString:x];
//    }];

    [[self.searchView.cancleBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(__kindof UIControl * _Nullable x) {
    
        weakSelf.searchView.searchField.text = @"";
        [weakSelf.searchView.searchField endEditing:YES];
        weakSelf.searchResultView.hidden = YES;
    }];
    
}

-(void)loadData{
    
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"citydict.plist" ofType:nil];
    self.bigDic =  [[NSDictionary alloc] initWithContentsOfFile:path];
    NSMutableArray * dataArray = @[].mutableCopy;
    NSMutableArray * sectionTitlesArray = @[].mutableCopy;
    
    NSArray * allKeys = [self.bigDic allKeys];
    
    [sectionTitlesArray addObjectsFromArray:[allKeys sortedArrayUsingSelector:@selector(compare:)]];
    [sectionTitlesArray enumerateObjectsUsingBlock:^(NSString *zimu, NSUInteger idx, BOOL * _Nonnull stop) {
             NSArray *smallArray = self.bigDic[zimu];
             [dataArray addObject:smallArray];
             [self.searchArray addObject:smallArray];
    }];
      
    [self.cityView updateDataArray:dataArray :@[@"上海市",@"杭州市",@"北京市",@"广州市"].mutableCopy :sectionTitlesArray :sectionTitlesArray];
}
-(void)startLocation{
    
    if([CLLocationManager locationServicesEnabled]){
      
        if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
            [self.locationManager requestWhenInUseAuthorization];
        }
        //开始定位，不断调用其代理方法
        [self.locationManager startUpdatingLocation];
      
    }
    else{
        NSLog(@"定位服务未开启");
    }
    
    
}

// 当定位到地理位置，回调的方法
- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray *)locations
{
    // 此判断的目的：避免多次定位的处理
    if(!_isLocationed){
        // 1.获取用户位置的对象
        CLLocation *location = [locations lastObject];
        CLLocationCoordinate2D coordinate = location.coordinate;
        NSLog(@"纬度:%f 经度:%f", coordinate.latitude, coordinate.longitude);
        
        // 逆地理编码得到当前定位城市
        [self reGeoCodeLocation:coordinate];
        
        _isLocationed = YES;
    }
    
    // 2.停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if (error.code == kCLErrorDenied) {
        // 提示用户出错原因，可按住Option键点击 KCLErrorDenied的查看更多出错信息，可打印error.code值查找原因所在
        NSLog(@"Error : %@", error);
    }
}

#pragma mark - Apple原生逆地理编码

-(void)reGeoCodeLocation:(CLLocationCoordinate2D)coordinate
{
    // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    CLLocation * location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
    [geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
            
             //获取城市
             NSString *city = placemark.locality;
             if (!city) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 city = placemark.administrativeArea;
             }
    
             NSLog(@"city = %@", city);
             
             self.cityView.headerView.placeLbl.text = city;
        
             
          
             
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error)
         {
          
             [XSObject showMassage:error.localizedDescription];
         }
     }];
}

-(void)searchFieldChanged:(UITextField*)field{
    

    [self searchString:field.text];
}
-(void)searchString:(NSString *)string
{
    
  // ”^[A-Za-z]+$”
     NSMutableArray *resultArray  =  [NSMutableArray array];
    if([self isZimuWithstring:string])
    {
        //证明输入的是字母
        self.pinYinArray = [NSMutableArray array]; //和输入的拼音首字母相同的地区的拼音
        NSString *upperCaseString2 = string.uppercaseString;
        NSString *firstString = [upperCaseString2 substringToIndex:1];
        NSArray *array = [self.bigDic objectForKey:firstString];
        [array enumerateObjectsUsingBlock:^(NSString *cityName, NSUInteger idx, BOOL * _Nonnull stop) {
             HSCityModel  *model = [[HSCityModel alloc] init];
            NSString *pinYin = [self Charactor:cityName getFirstCharactor:NO];
            model.name = cityName;
            model.pinYinName = pinYin;
            [self.pinYinArray addObject:model];
        }];
        NSPredicate *pred = [NSPredicate predicateWithFormat:@"pinYinName BEGINSWITH[c] %@",string];
        NSArray *smallArray = [self.pinYinArray filteredArrayUsingPredicate:pred];
        [smallArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                    HSCityModel *model = obj;
                    [resultArray addObject:model.name];
        }];
    }
    else
    {
        //证明输入的是汉字
        [self.searchArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            NSArray *sectionArray  = obj;
            NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF BEGINSWITH[c] %@",string];
            NSArray *array = [sectionArray filteredArrayUsingPredicate:pred];
            [resultArray addObjectsFromArray:array];
        }];
    }
   
    
    NSLog(@"搜索结果====%@",resultArray);
    
    self.searchResultView.hidden = NO;
    self.searchResultView.reslutArray =resultArray;
    
    
}

- (NSString *)Charactor:(NSString *)aString getFirstCharactor:(BOOL)isGetFirst
{
    //转成了可变字符串
    NSMutableString *str = [NSMutableString stringWithString:aString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    //转化为大写拼音
    if(isGetFirst)
    {
        //获取并返回首字母
        return [pinYin substringToIndex:1];
    }
    else
    {
        return pinYin;
    }
}
-(BOOL)isZimuWithstring:(NSString *)string
{
    NSString* number=@"^[A-Za-z]+$";
    NSPredicate *numberPre = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",number];
    return  [numberPre evaluateWithObject:string];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(CLLocationManager *)locationManager
{
    if(!_locationManager){
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    }
    return _locationManager;
}

-(HSCityView*)cityView{
    if (!_cityView) {
        _cityView = [[HSCityView alloc]initWithFrame:CGRectMake(0,self.searchView.bottom, Screen_width, Screen_height-Navi_heightAll-Tabbar_heightMargen)];
//
    }
    return _cityView;
}


-(HSSearchCityResultView*)searchResultView{
    if (!_searchResultView) {
        _searchResultView = [[HSSearchCityResultView alloc]initWithFrame:CGRectMake(0, self.searchView.bottom, Screen_width, Screen_height-Navi_heightAll-Tabbar_heightMargen)];
        _searchResultView.hidden = YES;
    }
    return _searchResultView;
}

-(HSCityTopSearchView*)searchView{
    if (!_searchView) {
        _searchView = [[HSCityTopSearchView alloc]initWithFrame:CGRectMake(0, Navi_heightAll,Screen_width, 61)];
        [_searchView.searchField addTarget:self action:@selector(searchFieldChanged:) forControlEvents:(UIControlEventEditingChanged)];
       
    }
    return _searchView;
}
@end
