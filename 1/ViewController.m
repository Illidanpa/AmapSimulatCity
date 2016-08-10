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
//    _mapView.delegate = self;
    
    [self.view addSubview:_mapView];
    [_mapView setShowsScale:NO];
    [_mapView setShowsCompass:NO];
    _mapView.minZoomLevel = 10;
    _mapView.maxZoomLevel = 19;

    
    
    CGFloat width = self.view.bounds.size.width;
    CGFloat height = self.view.bounds.size.height;
    
    UIButton * searchBtn = [[UIButton alloc]initWithFrame:CGRectMake(width - 60, height-60, 55, 55)];
    searchBtn.backgroundColor = [UIColor blackColor];
    
    [searchBtn addTarget:self action:@selector(dosearch) forControlEvents:(UIControlEventTouchUpInside)];
    
    
    [self.view addSubview:searchBtn];
    
    UIButton * backBtn =[[UIButton alloc]initWithFrame:CGRectMake(width - 60, 5, 55, 55)];
    backBtn.backgroundColor = [UIColor brownColor];
    [backBtn addTarget:self action:@selector(changeView) forControlEvents:(UIControlEventTouchUpInside)];
    [self.view addSubview:backBtn];
    
    
    
    
//
    [_mapView setCameraDegree:18];
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(39.90923, 116.397428);
    [_mapView setCenterCoordinate:center animated:YES];
    [_mapView setZoomLevel:16 animated:YES];
    
    
//
    
    
    
}
- (void)dosearch
{
    NSLog(@"cliclk");
}
- (void)changeView
{
    
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
