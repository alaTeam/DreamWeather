//
//  MainModel.h
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-17.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "JSONKit.h"
@class MainModel;
@protocol MainModelDelegate <NSObject>

-(void)MainModeldifinishWithDictionary:(NSDictionary *)WeatherDic;

@end
@interface MainModel : NSObject<ASIHTTPRequestDelegate>{
    __weak ASIHTTPRequest * requestimg;

}
@property(assign,nonatomic)id<MainModelDelegate>delegate;
-(void)WeatherStartloaddataWithUrl:(NSString *)str_url;
-(void)stopload;
@end
