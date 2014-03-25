//
//  DEMOFirstViewController.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOFirstViewController.h"
#import "UIImageView+WebCache.m"
#import "UIImageView+LBBlurredImage.h"
#import "UIImageView+WebCache.h"
#import "MainViewCell.h"
#import "SZKApi.h"
@interface DEMOFirstViewController ()


@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) UIImageView *blurredImageView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) CGFloat screenHeight;

@end

@implementation DEMOFirstViewController
#define TEXTBGCOLOR [[UIColor orangeColor]colorWithAlphaComponent:0.2]

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:NO];
    self.navigationController.navigationBarHidden=YES;
}
- (void)viewDidLoad
{
    
    
    
    [super viewDidLoad];
    self.navigationController.navigationBar.translucent=YES;

    FWeatherDic=[NSDictionary dictionary];
    resaults=[NSArray array];

    
[[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.alpha=0.3;
    //    UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
//    imageView.contentMode = UIViewContentModeScaleAspectFill;
//    imageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
//    
//    imageView.image = [UIImage imageNamed:@"Balloon"];
//    [self.view addSubview:imageView];
    
    self.screenHeight = [UIScreen mainScreen].bounds.size.height;

    UIButton *button_left=[[UIButton alloc]initWithFrame:CGRectMake(-14, 0, 64, 44)];
    button_left.backgroundColor=[UIColor clearColor];
    [button_left addTarget:self action:@selector(showMenu) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView* imgv=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"burger.png"]];
    imgv.center=CGPointMake(10, 20);
    [button_left addSubview:imgv];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button_left];
    
    
    
    UIImage *background = [UIImage imageNamed:@"Mallbackgurand.png"];
    

    self.backgroundImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.backgroundImageView.frame=self.view.bounds;
    self.backgroundImageView.image=background;
   // [self.backgroundImageView setImageToBlur:background blurRadius:0.1 completionBlock:nil];
    self.backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:self.backgroundImageView];
    
    //
    _blurredImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    _blurredImageView.contentMode = UIViewContentModeScaleAspectFill;
    _blurredImageView.alpha = 0;
    [_blurredImageView setImageToBlur:background blurRadius:8 completionBlock:nil];
    [self.view addSubview:_blurredImageView];
    _blurredImageView.frame=self.view.bounds;
    
    //
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 320, self.view.frame.size.height)];
    self.tableView.backgroundColor = [UIColor clearColor];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorColor = [UIColor colorWithWhite:1 alpha:0.2];
   // self.tableView.pagingEnabled = YES;
    self.tableView.showsHorizontalScrollIndicator=NO;
    self.tableView.showsVerticalScrollIndicator=NO;
    [self.view addSubview:self.tableView];
    
    
    self.tableView.tableHeaderView = [self SectionView];
    //下拉刷新
    _slimeView = [[SRRefreshView alloc] init];
    _slimeView.delegate = self;
    _slimeView.upInset = 65;
    _slimeView.slimeMissWhenGoingBack = YES;
    _slimeView.slime.bodyColor = [[UIColor colorWithPatternImage:[UIImage imageNamed:@"Mallbackgurand.png"]] colorWithAlphaComponent:0.8];
    _slimeView.slime.skinColor = [UIColor clearColor];
    _slimeView.slime.lineWith = 1;
    _slimeView.slime.shadowBlur = 4;
    _slimeView.slime.shadowColor = [UIColor clearColor];
    
    [self.tableView addSubview:_slimeView];
    

    /**
     *  假的navigationbar
    
     */
    self.navigationController.navigationBarHidden=YES;
    navibar=[[ZkingNavigationView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
    navibar.centerlabel.text=@"数据加载中";
    navibar.delegate=self;
    [self.view addSubview:navibar];
    
    
    
    
    /**
     *  定位请求数据
     */
    [self setMyLocation];
    
    
}


#pragma mark-sectionheader
-(UIView *)SectionView{
    
    UIView *sectionview=[[UIView alloc]initWithFrame:self.view.bounds];
    
    
//    UIColor *color=[[UIColor blackColor]colorWithAlphaComponent:0.2];
//    UIView *viewheader=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 320, 64)];
//    viewheader.backgroundColor=color;
//    [sectionview addSubview:viewheader];
    
    _CenterTemLabel=[[UILabel alloc]initWithFrame:CGRectMake(90, self.view.frame.size.height-300, 140, 140)];
    _CenterTemLabel.backgroundColor=[UIColor clearColor];
    _CenterTemLabel.textColor=[UIColor whiteColor];
    _CenterTemLabel.textAlignment=NSTextAlignmentCenter;
    _CenterTemLabel.backgroundColor=TEXTBGCOLOR;
  //  _CenterTemLabel.font=[UIFont systemFontOfSize:30];
    _CenterTemLabel.font=[UIFont fontWithName:@"AmericanTypewriter-CondensedLight" size:40];
    [_CenterTemLabel.layer setMasksToBounds:YES];
    [_CenterTemLabel.layer setCornerRadius:70.f]; //设置矩形四个圆角半径
    //[_CenterTemLabel.layer setBorderWidth:0.1]; //边框宽度
    [sectionview addSubview:_CenterTemLabel];
    

    
    
    
    
    //3
    _dateLabel=[[UILabel alloc]initWithFrame:CGRectMake(180, 70, 120, 20)];
    _dateLabel.backgroundColor=[UIColor clearColor];
    _dateLabel.textAlignment=NSTextAlignmentCenter;
    _dateLabel.textColor=[UIColor whiteColor];
    _dateLabel.font=[UIFont systemFontOfSize:15];
    [_dateLabel.layer setMasksToBounds:YES];
    [_dateLabel.layer setCornerRadius:10.f];
    _dateLabel.backgroundColor=TEXTBGCOLOR;

    [sectionview addSubview:_dateLabel];
    //4
    
    _weatherLabel=[[UILabel alloc]initWithFrame:CGRectMake(170, 150, 80, 80)];
    _weatherLabel.backgroundColor=[UIColor clearColor];
    _weatherLabel.textColor=[UIColor whiteColor];
    
    _weatherLabel.font=[UIFont systemFontOfSize:15];
    [_weatherLabel.layer setMasksToBounds:YES];
    [_weatherLabel.layer setCornerRadius:40.f];
    _weatherLabel.backgroundColor=TEXTBGCOLOR;
    _weatherLabel.textAlignment=NSTextAlignmentCenter;
    
    [sectionview addSubview:_weatherLabel];
    
    //5
    
    
    _tempLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 150, 100, 100)];
    _tempLabel.backgroundColor=[UIColor clearColor];
    _tempLabel.textColor=[UIColor whiteColor];
    _tempLabel.font=[UIFont systemFontOfSize:15];
    [_tempLabel.layer setMasksToBounds:YES];
    [_tempLabel.layer setCornerRadius:50.f];
    _tempLabel.backgroundColor=TEXTBGCOLOR;
    _tempLabel.textAlignment=NSTextAlignmentCenter;
    [sectionview addSubview:_tempLabel];
    
    //6
    
    _suggestLabel=[[UILabel alloc]initWithFrame:CGRectMake(20, 350, 80, 80)];
    _suggestLabel.font=[UIFont systemFontOfSize:15];
    [_suggestLabel.layer setMasksToBounds:YES];
    [_suggestLabel.layer setCornerRadius:40.f];
    _suggestLabel.backgroundColor=TEXTBGCOLOR;
    _suggestLabel.textColor=[UIColor whiteColor];
    _suggestLabel.text=[SZKApi mycurrenttimeofweek];
    _suggestLabel.textAlignment=NSTextAlignmentCenter;
    [sectionview addSubview:_suggestLabel];
    
    
    
    _windlabel=[[UILabel alloc]initWithFrame:CGRectMake(200, 350, 80, 80)];
    _windlabel.font=[UIFont systemFontOfSize:15];
    [_windlabel.layer setMasksToBounds:YES];
    [_windlabel.layer setCornerRadius:40.f];
    _windlabel.backgroundColor=TEXTBGCOLOR;
    _windlabel.textColor=[UIColor whiteColor];
    _windlabel.textAlignment=NSTextAlignmentCenter;
    [sectionview addSubview:_windlabel];
    
    for (int i=0; i<2; i++) {
        UILabel *label_two=[[UILabel alloc]initWithFrame:CGRectMake(30, 230+40*i, 180, 20)];
        label_two.backgroundColor=[UIColor clearColor];
        label_two.tag=5000+i;
        label_two.textColor=[UIColor whiteColor];
        label_two.textAlignment=NSTextAlignmentLeft;
        [sectionview addSubview:label_two];
        
        
    }
    
    //7
    
    
    _weatherImgV=[[UIImageView alloc]initWithFrame:CGRectMake(150, 200, 42/2, 30/2)];
    _weatherImgV.center=CGPointMake(150, 246);
  //  [sectionview addSubview:_weatherImgV];
    _weatherImgV.alpha=0.8;
    _weatherImgV.backgroundColor=[UIColor clearColor];
    
    
    return sectionview;
}

#pragma mark-tableviewdelegateanddatesource

#pragma mark-tablviewdatesourceAndDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return resaults.count>2?resaults.count-1:0;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"CellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (! cell) {
        /**
         *   "date": "周二",
         "dayPictureUrl": "http://api.map.baidu.com/images/weather/day/qing.png",
         "nightPictureUrl": "http://api.map.baidu.com/images/weather/night/yin.png",
         "temperature": "15 ~ 6℃",
         "weather": "晴转阴",
         "wind": "微风"
         */
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier];
    }
    for (UIView *aview in cell.contentView.subviews) {
        [aview removeFromSuperview];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
   NSArray *arraykey=[NSArray arrayWithObjects:@"date",@"temperature",@"weather",@"wind" ,nil];
//
//    for (int i=0; i<2; i++) {
//     
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
//        label.center=CGPointMake(100+i*120, cell.contentView.frame.size.height/3);
//        label.textColor=[UIColor whiteColor];
//        label.textAlignment=NSTextAlignmentCenter;
//        label.text=[[resaults objectAtIndex:indexPath.row+1] objectForKey:[arraykey objectAtIndex:i]];
//        [cell.contentView addSubview:label];
//        
//    }
//    
//    for (int i=0; i<2; i++) {
//        
//        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 110, 20)];
//        label.center=CGPointMake(100+i*120, cell.contentView.frame.size.height*2/3);
//        label.textColor=[UIColor whiteColor];
//        label.textAlignment=NSTextAlignmentCenter;
//        label.text=[[resaults objectAtIndex:indexPath.row+1] objectForKey:[arraykey objectAtIndex:i+2]];
//        [cell.contentView addSubview:label];
//        
//    }
    
    
    MainViewCell *cellview=[[MainViewCell alloc]initWithFrame:CGRectMake(0, 0,320, (self.view.frame.size.height)/(resaults.count-1))];
    cellview.dateLabel.text=[[resaults objectAtIndex:indexPath.row+1] objectForKey:[arraykey objectAtIndex:0]];
    cellview.tempLbel.text=[[resaults objectAtIndex:indexPath.row+1] objectForKey:[arraykey objectAtIndex:1]];
    cellview.wetherLabel.text=[[resaults objectAtIndex:indexPath.row+1] objectForKey:[arraykey objectAtIndex:2]];
    cellview.windLabel.text=[[resaults objectAtIndex:indexPath.row+1] objectForKey:[arraykey objectAtIndex:3]];

   [cell.contentView addSubview:cellview];


    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	NSInteger cellCount = [self tableView:tableView numberOfRowsInSection:indexPath.section];
    return (self.view.frame.size.height) / (CGFloat)cellCount;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat height = scrollView.bounds.size.height;
    CGFloat position = MAX(scrollView.contentOffset.y, 0.0);
    CGFloat percent = MIN(position / height, 1.0);
    self.blurredImageView.alpha = percent;
    [_slimeView scrollViewDidScroll];
    
    if (scrollView.contentOffset.y<0) {
        scrollView.pagingEnabled=NO;
        
    }else{
        scrollView.pagingEnabled=YES;
    }
        

    
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [_slimeView scrollViewDidEndDraging];
}

#pragma mark - slimeRefresh delegate

- (void)slimeRefreshStartRefresh:(SRRefreshView *)refreshView
{
    [_slimeView performSelector:@selector(endRefresh)
                     withObject:nil afterDelay:3
                        inModes:[NSArray arrayWithObject:NSRunLoopCommonModes]];
    [self setMyLocation];
}


#pragma mark----定位

-(void)setMyLocation{
    
    LocationManager *manager = [LocationManager defaultManager];
    manager.delegate = self;
    
    [manager startUpdatingLocation];
    
}

-(void)locationManager:(LocationManager *)manager didLocatedWithCityName:(NSString *)cityName{
    
    
    
    
//    NSLog(@"%@",cityName);
//    model=[[MainModel alloc]init];
//    
//    model.delegate=self;
//    [model WeatherStartloaddataWithUrl:[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=Q7tOT8rUBZ8PBx1TiSG7Qe0v",[cityName stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
//    
//    NSLog(@"tt=%@",[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=Q7tOT8rUBZ8PBx1TiSG7Qe0v",cityName]);
    
    
}
-(void)locationManager:(LocationManager *)manager didLocatedWithlngandlt:(NSString *)string_lngand{
        model=[[MainModel alloc]init];

    model.delegate=self;
    [model WeatherStartloaddataWithUrl:[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ",string_lngand]];
    
    NSLog(@"tt=%@",[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ",string_lngand]);
}
#pragma mark-MainModeDelagete
-(void)MainModeldifinishWithDictionary:(NSDictionary *)WeatherDic{
    /**
     *  {
     "date": "2014-03-17",
     "error": 0,
     "results": [
     {
     "currentCity": "北京市",
     "weather_data": [
     {
     "date": "周一(今天, 实时：17℃)",
     "dayPictureUrl": "http://api.map.baidu.com/images/weather/day/qing.png",
     "nightPictureUrl": "http://api.map.baidu.com/images/weather/night/qing.png",
     "temperature": "5℃",
     "weather": "晴",
     "wind": "北风4-5级"
     },
     {
     "date": "周二",
     "dayPictureUrl": "http://api.map.baidu.com/images/weather/day/qing.png",
     "nightPictureUrl": "http://api.map.baidu.com/images/weather/night/yin.png",
     "temperature": "15 ~ 6℃",
     "weather": "晴转阴",
     "wind": "微风"
     },
     {
     "date": "周三",
     "dayPictureUrl": "http://api.map.baidu.com/images/weather/day/yin.png",
     "nightPictureUrl": "http://api.map.baidu.com/images/weather/night/qing.png",
     "temperature": "14 ~ 5℃",
     "weather": "阴转晴",
     "wind": "北风5-6级"
     },
     {
     "date": "周四",
     "dayPictureUrl": "http://api.map.baidu.com/images/weather/day/qing.png",
     "nightPictureUrl": "http://api.map.baidu.com/images/weather/night/qing.png",
     "temperature": "15 ~ 3℃",
     "weather": "晴",
     "wind": "微风"
     }
     ]
     }
     ],
     "status": "success"
     }
     */
    
    FWeatherDic=WeatherDic;
  //  NSLog(@"dic===%@",FWeatherDic);
    
    @try {
        NSArray * testarray=[FWeatherDic objectForKey:@"results"];
        
        
        navibar.centerlabel.text=[NSString stringWithFormat:@"%@",[[testarray objectAtIndex:0] objectForKey:@"currentCity"]];

        resaults=[[testarray objectAtIndex:0] objectForKey:@"weather_data"];
        NSLog(@"resaults===%@",resaults);
        _dateLabel.text=[FWeatherDic objectForKey:@"date"];
        
        [_weatherImgV setImageWithURL:[NSURL URLWithString:[[resaults objectAtIndex:0] objectForKey:@"dayPictureUrl"]] placeholderImage:nil];
        _weatherLabel.text=[[resaults objectAtIndex:0]objectForKey:@"weather"];
        _tempLabel.text=[NSString stringWithFormat:@"%@",[[resaults objectAtIndex:0]objectForKey:@"temperature"]];
        _CenterTemLabel.text=[SZKApi GiveMeString:[[resaults objectAtIndex:0] objectForKey:@"date"]];
        _windlabel.text=[NSString stringWithFormat:@"%@",[[resaults objectAtIndex:0]objectForKey:@"wind"]];

        

    }
    @catch (NSException *exception) {
        
        NSLog(@"catchabug");
    }
    @finally {
        [self.tableView reloadData];

    }
 
    
    

}

#pragma mark-自定义导航栏的代理
-(void)NavigationbuttonWithtag:(int)tag{
    [self showMenu];
}
#pragma mark-根据tableview的滚动方向做一些处理
float lastContentOffset=0;

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    lastContentOffset = scrollView.contentOffset.y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView{
    if (lastContentOffset < scrollView.contentOffset.y) {
        NSLog(@"向上滚动");
        [UIView animateWithDuration:0.3 animations:^{
            //动画内容
            navibar.hidden=YES;
         //   scrollView.pagingEnabled=YES;
            
            
        }completion:^(BOOL finished)
         
         {
             
             
         }];
        

    }else if(lastContentOffset > scrollView.contentOffset.y){
        NSLog(@"向下滚动");
        [UIView animateWithDuration:0.3 animations:^{
            //动画内容
            navibar.hidden=NO;

          //  scrollView.pagingEnabled=NO;

        }completion:^(BOOL finished)
         
         {
             
             
             
         }];

    }

    
}
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"======%f",scrollView.contentOffset.y);
}
- (void)showMenu
{
    [self.sideMenuViewController presentMenuViewController];
}

-(void)dealloc{
    [model stopload];
    model.delegate=nil;
    model=nil;

    
}


@end
