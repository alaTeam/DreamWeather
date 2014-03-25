//
//  MainViewCell.m
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "MainViewCell.h"

@implementation MainViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
        for (int i=0; i<2; i++) {
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
            label.center=CGPointMake(100+i*120, self.frame.size.height/3);
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            if (i==0) {
                self.dateLabel=label;
                [self addSubview:self.dateLabel];

                
            }else{
                self.tempLbel=label;
                [self addSubview:self.tempLbel];

            }
            
            
        }
        
        for (int i=0; i<2; i++) {
            
            UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
            label.center=CGPointMake(100+i*120, self.frame.size.height*2/3);
            label.textColor=[UIColor whiteColor];
            label.textAlignment=NSTextAlignmentCenter;
            label.backgroundColor=[UIColor clearColor];
            if (i==0) {
                self.wetherLabel=label;
                [self addSubview:self.wetherLabel];

                
            }else{
                self.windLabel=label;
                [self addSubview:self.windLabel];

            }
            
        }
        
        
        // Initialization code
    }
    
    return self;
}



/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
