//
//  NSDate+AL.h
//  Chatt
//
//  Created by 张小明 on 2017/10/19.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (AL)

/**
 返回毫秒秒数时间戳


 */
+(NSString *)get1970Time;

/**
 获取当前时间戳字符串格式   yyyy-MM-dd HH:mm:ss

 
 */
+ (NSString *)getDateFormateStr;


/**
 将毫秒转为日期字符串

 @param timeLong 毫秒
 @return 返回yyyy-MM-dd HH:mm:ss 格式
 */
+ (NSString *)getDateFormateStr:(NSString*)timeLong;
@end
