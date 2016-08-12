//
//  CustomAnnotationView.h
//  1
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
@protocol CustomAnnotationDelegate <NSObject>

-(void)annotationDidSelect;

@end
@interface CustomAnnotationView : MAAnnotationView
@property(nonatomic,weak)id<CustomAnnotationDelegate>delegate;
@end
