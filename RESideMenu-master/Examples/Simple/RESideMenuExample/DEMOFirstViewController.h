//
//  DEMOFirstViewController.h
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "LocationManager.h"
#import "MainModel.h"
#import "ZkingNavigationView.h"
#import "SRRefreshView.h"
@interface DEMOFirstViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,LocationManagerDelegate,MainModelDelegate,ZkingNavigationViewDelegate,SRRefreshDelegate>{
    NSDictionary *FWeatherDic;
    NSArray *resaults;
    SRRefreshView   *_slimeView;

    ZkingNavigationView *navibar;
    MainModel *model;
    BOOL _reloading;//第三刷新类的，不知道啥用
    BOOL isloadsuccess;//只有刷新加载过程完成了才能进行下一次加载


}
@property(nonatomic,strong)UIImageView *imageView;
@property(retain,nonatomic)NSString *intString;
@property (nonatomic ,retain) UILabel *cityLabel;
@property (nonatomic ,retain) UILabel *dateLabel;
@property (nonatomic ,retain) UILabel *weekLabel;
@property (nonatomic ,retain) UILabel *CenterTemLabel;
@property (nonatomic ,retain) UILabel *tempLabel;
@property (nonatomic ,retain) UILabel *weatherLabel;
@property (nonatomic ,retain) UILabel *suggestLabel;
@property (nonatomic ,retain) UILabel *windlabel;

@property (nonatomic ,retain) UIImageView *weatherImgV;
@end
