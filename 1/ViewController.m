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
@interface ViewController ()<MAMapViewDelegate>
{
    MAMapView *_mapView;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //配置用户Key
    [AMapServices sharedServices].apiKey = @"fd2c9e6b4f183f2fc81d814631b2c7ea";
    _mapView = [[MAMapView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds))];
    _mapView.delegate = self;

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
//    CLLocationCoordinate2DMake(39.989631, 116.481018);
    pointAnnotation.title = @"方恒国际";
    pointAnnotation.subtitle = @"阜通东大街6号";
//    pointAnnotation
    
    
    [_mapView addAnnotation:pointAnnotation];
//    [_mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
    MAPointAnnotation *pointAnnotation1 = [[MAPointAnnotation alloc] init];
    pointAnnotation1.coordinate = CLLocationCoordinate2DMake(39.90868801, 116.39852416);
    pointAnnotation1.title = @"方国";
    pointAnnotation1.subtitle = @"阜通东大街66号";
    [_mapView addAnnotation:pointAnnotation1];

    
}
- (void)dosearch
{
    NSLog(@"cliclk");
}
- (void)changeView
{
    NSLog(@"time to change view");
//    UIView * view =[[UIView alloc]init];
//    view.backgroundColor = [UIColor redColor];
//    self.view = view;
}





#pragma mark ***协议***
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAAnnotationView*annotationView = (MAAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.image = [UIImage imageNamed:@"poi_yellow"];
//        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO

        return annotationView;
    }
    return nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
