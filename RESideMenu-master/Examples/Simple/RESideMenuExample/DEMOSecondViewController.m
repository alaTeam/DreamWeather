//
//  DEMOSecondViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOSecondViewController.h"
#define IPHONE5_HEIGHT 568
#define IPHONE4_HEIGHT 480
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation DEMOSecondViewController
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad
{
  
    
    UIImage *background   =[UIImage imageNamed:IS_IPHONE_5?@"Mallbackgurand.png":@"Mallbackgurand.png"];
  UIImageView *  _blurredImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    _blurredImageView.alpha = 1;
    // [_blurredImageView setImageToBlur:background blurRadius:8 completionBlock:nil];
    _blurredImageView.image=background;
    [self.view addSubview:_blurredImageView];
    _blurredImageView.frame=self.view.bounds;
    
    UILabel *label_=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 300, 200)];
    label_.text=@"我不去想是否能够成功\n既然选择了远方\n便只顾风雨兼程\n____ala2014";
    label_.numberOfLines=0;
    label_.textAlignment=NSTextAlignmentRight;
    label_.center=CGPointMake(160, self.view.frame.size.height-100);
    label_.backgroundColor=[UIColor clearColor];
    label_.textColor=[UIColor whiteColor];
    label_.font=[UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:20];

    [_blurredImageView addSubview:label_];
    
    navibar=[[ZkingNavigationView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navibar.centerlabel.text=@"关于我们";
    navibar.delegate=self;
    [self.view addSubview:navibar];
    
}
#pragma mark-自定义导航栏的代理
-(void)NavigationbuttonWithtag:(int)tag{
    [self showMenu];
}
- (void)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

@end
