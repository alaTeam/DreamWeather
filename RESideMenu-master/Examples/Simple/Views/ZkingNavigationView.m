//
//  ZkingNavigationView.m
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-18.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "ZkingNavigationView.h"

@implementation ZkingNavigationView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
      //1
        
        UIColor *color_black=[[UIColor grayColor]colorWithAlphaComponent:0.4];
        self.backgroundColor=color_black;
        
        //2
        UIButton *button_left=[[UIButton alloc]initWithFrame:CGRectMake(10, 20, 64, 44)];
        button_left.backgroundColor=[UIColor clearColor];
        [button_left addTarget:self action:@selector(dobutton:) forControlEvents:UIControlEventTouchUpInside];
        
        UIImageView* imgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"burger.png"]];
        imgv.center=CGPointMake(imgv.image.size.width/2, 22);
        [button_left addSubview:imgv];
        button_left.tag=100;
        self.leftbutton=button_left;
        
        [self addSubview:self.leftbutton];
        //3
        UILabel *labelcenter=[[UILabel alloc]initWithFrame:CGRectMake(100, 20, 120, 44)];
        labelcenter.textAlignment=NSTextAlignmentCenter;
        labelcenter.textColor=[UIColor whiteColor];
        labelcenter.font=[UIFont systemFontOfSize:18];
        self.centerlabel=labelcenter;
        [self addSubview:self.centerlabel];
        
    }
    return self;
}



-(void)dobutton:(UIButton *)sender{
    
    [self.delegate NavigationbuttonWithtag:(int)sender.tag];
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
