//
//  ViewController.m
//  1
//
//  Created by Mac on 16/8/9.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "ViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
//#import "AMapSearchNeighbor.h"
#import <AMapSearchKit/AMapSearchKit.h>
#import "CustomAnnotationView.h"


@interface ViewController ()<MAMapViewDelegate,AMapSearchDelegate,CustomAnnotationDelegate>
{
    MAMapView * _mapView;
    AMapSearchAPI *_search;
}
@property(nonatomic,strong)AMapPOIAroundSearchRequest * request;

@property(nonatomic,strong)MAPointAnnotation * point1;
@property(nonatomic,strong)MAPointAnnotation * point2;
@property(nonatomic,strong)MAPointAnnotation * point3;
@property(nonatomic,strong)CustomAnnotationView * annotationView;

@property(nonatomic,strong)NSArray * allLocation;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;
    
    _search = [[AMapSearchAPI alloc] init];
    _search.delegate = self;


//    [self.view addSubview:_mapView];
    self.view = _mapView;
    
//地图永久设置
    [_mapView setShowsScale:NO];
    [_mapView setShowsCompass:NO];
    _mapView.minZoomLevel = 10;
    _mapView.maxZoomLevel = 19;

    

    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
// 雷达
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(width - 60, height-60, 55, 55)];
    searchBtn.backgroundColor = [UIColor blackColor];
    
    [searchBtn addTarget:self action:@selector(dosearch) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.view addSubview:searchBtn];
// 切换页面
    UIButton * backBtn =[[UIButton alloc]initWithFrame:CGRectMake(width - 60, 5, 55, 55)];
    backBtn.backgroundColor = [UIColor brownColor];
    [backBtn addTarget:self action:@selector(changeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    
    
    
//零状态
    [_mapView setCameraDegree:18];
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.90768703, 116.39752328);
    [_mapView setCenterCoordinate:center animated:YES];
    [_mapView setZoomLevel:16 animated:YES];
    
    
//标记
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = center;
    [_mapView addAnnotation:pointAnnotation];

    
    
    self.point1 = [[MAPointAnnotation alloc] init];
    self.point2 = [[MAPointAnnotation alloc] init];
    self.point3 = [[MAPointAnnotation alloc] init];


    

}

-(void)addAnnotation
{
    int n;
    n = arc4random() % self.allLocation.count;
    NSDictionary * pd = self.allLocation[n];
    NSString * name =[pd objectForKey:@"name"];
    NSString * types = [pd objectForKey:@"types"];
    AMapGeoPoint * point = [pd objectForKey:@"location"];
    
    self.point1.title = name;
    self.point1.subtitle = types;
    self.point1.coordinate = [self geopointToCoordinate:point];
    [_mapView addAnnotation:self.point1];
    
    n = arc4random() % self.allLocation.count;
    pd = self.allLocation[n];
    name =[pd objectForKey:@"name"];
    types = [pd objectForKey:@"types"];
    point = [pd objectForKey:@"location"];
    self.point2.title = name;
    self.point2.subtitle = types;
    self.point2.coordinate = [self geopointToCoordinate:point];
    [_mapView addAnnotation:self.point2];

    n = arc4random() % self.allLocation.count;
    pd = self.allLocation[n];
    name =[pd objectForKey:@"name"];
    types = [pd objectForKey:@"types"];
    point = [pd objectForKey:@"location"];
    self.point3.title = name;
    self.point3.subtitle = types;
    self.point3.coordinate = [self geopointToCoordinate:point];
    [_mapView addAnnotation:self.point3];


}
- (CLLocationCoordinate2D)geopointToCoordinate:(AMapGeoPoint *)coordnate
{
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(coordnate.latitude, coordnate.longitude);
    return location;
}


- (void)dosearch
{
    NSLog(@"cliclk");
    //多线程
    self.request = [[AMapPOIAroundSearchRequest alloc] init];
    self.request.offset = 50;
    self.request.sortrule = 0;

    
    self.request.location = [AMapGeoPoint locationWithLatitude:39.990459 longitude:116.481476];
    NSArray * arr = @[@"160100|",@"110102|",@"060100|",@"120300|",@"080601|",@"141204|",@"140500|",@"050100|",@"200300|",@"050200|",@"080501|",@"060500|",@"140100|",@"110101|",@"100000|",@"080304|",@"060400|",@"080601|",@"160105|",@"150200|",@"071100|",@"050501|",@"050302|"];

    
    NSString * types =[[arr[9] stringByAppendingString:arr[20]] stringByAppendingString:arr[5]];
    
    
    self.request.types = types;
    
    
    self.request.radius = 200;
    [_search AMapPOIAroundSearch: self.request];
    
    
    
//    [_mapView setCenterCoordinate:CLLocationCoordinate2DMake(39.990459, 116.481476) animated:YES];

    

}
- (void)changeView
{
    NSLog(@"time to change view");
//    [_mapView removeAnnotation:self.point1];

}



#pragma mark ***协议***
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        self.annotationView = (CustomAnnotationView * )[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        self.annotationView.delegate = self;
        if (self.annotationView == nil)
        {
            self.annotationView = [[CustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        NSString * title =  annotation.subtitle;
        //图片 与 有关
        self.annotationView.image = [UIImage imageNamed:@"poi_yellow"];

        return self.annotationView;
    }
    return nil;
}

//实现POI搜索对应的回调函数
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    //通过 AMapPOISearchResponse 对象处理搜索结果
    NSDictionary * dic = nil;
    NSMutableArray * arr = [NSMutableArray array];
    NSString * name = @"";
    NSString * type = @"";
    AMapGeoPoint * location = [[AMapGeoPoint alloc]init];
 
    for (AMapPOI * poi in response.pois) {
        name = poi.name;
        type = poi.type;
        location = poi.location;
        dic = @{@"name":name,@"types":type,@"location":location};
        [arr addObject:dic];
    }
    self.allLocation = arr;
    //    return arr;
    [self addAnnotation];
}

- (void)annotationDidSelect
{
    if (self.point1.title == nil) {
        [_mapView removeAnnotation:self.point1];
    }
    if (self.point2.title == nil) {
        [_mapView removeAnnotation:self.point2];
    }
    if (self.point3.title == nil) {
        [_mapView removeAnnotation:self.point3];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
