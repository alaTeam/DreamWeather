//
//  SZKApi.m
//  RESideMenuExample
//
//  Created by 史忠坤 on 14-3-17.
//  Copyright (c) 2014年 Roman Efimov. All rights reserved.
//

#import "SZKApi.h"

@implementation SZKApi
+(NSString *)GiveMeString:(NSString*)str{
    
    //周一(今天, 实时：17℃)
//    str=@"周一(今天, 实时：25℃)";
    if (str.length>5) {
        
        
        
        str=[str substringFromIndex:str.length-4];
        NSLog(@"str1=%@",str);
           str = [str stringByReplacingOccurrencesOfString:@"：" withString:@""];
        
        NSLog(@"str2=%@",str);

        str= [str substringToIndex:str.length-1];
        NSLog(@"str3=%@",str);

    }
    
    
    return str;
}
#pragma mark-获取当前时间

+(NSString *)mycurrenttimeofweek{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *now;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
    NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    now=[NSDate date];
    comps = [calendar components:unitFlags fromDate:now];
    NSInteger    week = [comps weekday];
    
    
    
    
    NSString *strweek;
    switch (week) {
        case 1:
            strweek=@"星期日";
            break;
        case 2:
            strweek=@"星期一";
            break;
        case 3:
            strweek=@"星期二";
            break;
            
        case 4:
            strweek=@"星期三";
            break;
            
        case 5:
            strweek=@"星期四";
            break;
        case 6:
            strweek=@"星期五";
            break;
        case 7:
            strweek=@"星期六";
            break;
            
            
    }
    return strweek;
    
}
@end
