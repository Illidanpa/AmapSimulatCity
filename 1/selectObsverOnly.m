//
//  selectObsverOnly.m
//  1
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "selectObsverOnly.h"

@implementation selectObsverOnly
static selectObsverOnly * obsver = nil;
+(instancetype)shareSelectObsver
{

//    static dispatch_once_t predicate;
//    dispatch_once(&predicate, ^{
//        obsver = [[self alloc]init];
//    });
    @synchronized(self) {
        if(obsver == nil) {
            obsver = [[self alloc] init]; //
        }
    }
    return obsver;
}

-(void)setTitle:(NSString *)title
{
    _title = title;
    if (_title) {
        [self.delegate annotationDidSelectWithTitle:_title];
    }
    NSLog(@"");
}

@end
