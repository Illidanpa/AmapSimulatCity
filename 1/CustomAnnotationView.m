//
//  CustomAnnotationView.m
//  1
//
//  Created by Mac on 16/8/12.
//  Copyright © 2016年 Mac. All rights reserved.
//

#import "CustomAnnotationView.h"

@implementation CustomAnnotationView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    if (self.selected == selected)
    {
        return;
    }
    
    if (selected)
    {
        if (1)
        {
            //信息页面
            //
            NSLog(@"select");
            [self.delegate annotationDidSelect];
            
        }
            
    }
    else
    {
        
    }
    
    [super setSelected:selected animated:animated];
}
@end
