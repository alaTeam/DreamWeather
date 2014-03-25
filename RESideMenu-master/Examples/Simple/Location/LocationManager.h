//
//  LocationManager.h
//  WeatherReportProject
//
//  Created by Will on 13-2-23.
//  Copyright (c) 2013年 Will. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LocationManager;

@protocol LocationManagerDelegate <NSObject>
@optional

//定位成功并反编为地理位置信息时，调用此方法
-(void)locationManager:(LocationManager *)manager didLocatedWithCityName:(NSString *)cityName;
-(void)locationManager:(LocationManager *)manager didLocatedWithlngandlt:(NSString *)string_lngand;
@end


@interface LocationManager : NSObject{
    int ifirst;
}
@property (nonatomic,weak)id<LocationManagerDelegate>delegate;

+(LocationManager *)defaultManager;
-(void)startUpdatingLocation;

@end
