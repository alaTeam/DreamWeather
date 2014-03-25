//
//  MainModel.m
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-17.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "MainModel.h"
#import "GDataXMLNode.h"
@implementation MainModel
@synthesize delegate;
-(void)WeatherStartloaddataWithUrl:(NSString *)str_url{
   // str_url=@"http://weather.yahooapis.com/forecastrss?w=2151330&u=c";
    //@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ",string_lngand
    requestimg = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",str_url]]];
    
    //   NSLog(@"=--==%@",[NSString stringWithFormat:@"http://api.map.baidu.com/telematics/v3/weather?location=%@&output=json&ak=5slgyqGDENN7Sy7pw29IUvrZ",string_lngand]);
    
    requestimg.tag=2014;
    //        __weak ASIHTTPRequest * _requset = request;
    
    //        __weak typeof(request) weakRequest = request;
    
    
    requestimg.delegate = self;
    
    [requestimg setCompletionBlock:^{
        NSString *stringtest=requestimg.responseString;

        
        NSLog(@"djfjkllkjkl;kl;kl;l;klk====%@",stringtest);
        NSDictionary * dic = [requestimg.responseData objectFromJSONData];
        
   
        
        [self.delegate MainModeldifinishWithDictionary:dic];
    }];
    
    
    [requestimg setFailedBlock:^{
        
        
        
        
        [self stopload];
        
    }];
    
    [requestimg startAsynchronous];
}

-(void)stopload{
    [requestimg cancel];
 //   requestimg.delegate=nil;
    
}


@end
