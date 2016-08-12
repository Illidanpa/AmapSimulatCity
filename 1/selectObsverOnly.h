//
//  selectObsverOnly.h
//  1
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol selectedDelegate <NSObject>

-(void)annotationDidSelectWithTitle:(NSString * )title;

@end


@interface selectObsverOnly : NSObject
@property(nonatomic,strong)NSString * title;
@property(nonatomic,weak)id<selectedDelegate>delegate;

+(instancetype)shareSelectObsver;


@end
