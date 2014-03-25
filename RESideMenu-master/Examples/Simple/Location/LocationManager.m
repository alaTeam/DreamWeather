//
//  LocationManager.m
//  WeatherReportProject
//
//  Created by Will on 13-2-23.
//  Copyright (c) 2013年 Will. All rights reserved.
//

#import "LocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface LocationManager()  <CLLocationManagerDelegate>
@property (nonatomic, strong)CLLocationManager *locationManager;
@end



@implementation LocationManager
@synthesize locationManager = _locationManager, delegate = _delegate;

+(LocationManager *)defaultManager{
    
    static LocationManager *defaultManager;
    
    if (!defaultManager) {
        defaultManager = [[LocationManager alloc]init];
    
    }
    
    return defaultManager;
}



-(void)startUpdatingLocation{
    
    [self.locationManager startUpdatingLocation];
}

-(CLLocationManager *)locationManager
{
  
    if (!_locationManager) {
        
        if ([CLLocationManager locationServicesEnabled]) {
            _locationManager = [[CLLocationManager alloc]init];
            _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            _locationManager.delegate = self;
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"错误" message:@"定位服务不可用，请在设置中打开定位服务并允许本程序定位" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            [alert show];
        }
    }

    return _locationManager;
}


#pragma mark CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager
	didUpdateToLocation:(CLLocation *)newLocation
		   fromLocation:(CLLocation *)oldLocation{
    
    [manager stopUpdatingLocation];
    
    NSLog(@"%f,%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude);
    
    NSLog(@"xxxxx===%d",ifirst);
    ifirst++;
    
    if ([self.delegate respondsToSelector:@selector(locationManager:didLocatedWithlngandlt:)]) {
        
        
        
        
        
        
        [self.delegate locationManager:self didLocatedWithlngandlt:[NSString stringWithFormat:@"%f,%f",newLocation.coordinate.longitude,newLocation.coordinate.latitude]];
    }
    
    CLGeocoder *geocoder = [[CLGeocoder alloc]init];
    
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        CLPlacemark *placeMark = [placemarks objectAtIndex:0];

        NSString *cityString;
        if (placeMark.subLocality) {
            cityString = placeMark.subLocality;
        }else{
            cityString = placeMark.locality;
        }
        
  
        NSLog(@"%s%@",__FUNCTION__,cityString);
        
        
        NSRange range = [cityString rangeOfString:@"市"];
        if (range.length>0) {
            cityString = [cityString substringWithRange:NSMakeRange(0, cityString.length-1)];
        }
        range = [cityString rangeOfString:@"区"];
        if (range.length>0) {
            cityString = [cityString substringWithRange:NSMakeRange(0, cityString.length-1)];
        }
//
        
        if ([self.delegate respondsToSelector:@selector(locationManager:didLocatedWithCityName:)]) {
            [self.delegate locationManager:self didLocatedWithCityName:cityString];
        }
    }];
    
    
    
}


@end
