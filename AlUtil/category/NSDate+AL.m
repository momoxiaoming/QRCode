//
//  NSDate+AL.m
//  Chatt
//
//  Created by 张小明 on 2017/10/19.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "NSDate+AL.h"

@implementation NSDate (AL)
+(NSString *)get1970Time{
    NSTimeInterval nowtime = [[NSDate date] timeIntervalSince1970];
    
    long long theTime = [[NSNumber numberWithDouble:nowtime] longLongValue]*1000;
    
    NSString *curTime = [NSString stringWithFormat:@"%llu",theTime];
    
    return curTime;
}


+ (NSString *)getDateFormateStr{
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:[NSDate date]];
    return destDateString;
}

+ (NSString *)getDateFormateStr:(NSString*)timeLong{
    long long timeL=[timeLong longLongValue];
    NSDate *date=[[NSDate alloc]initWithTimeIntervalSince1970:timeL];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}


@end
