//
//  AlUtil.h
//  Chatt
//
//  Created by 张小明 on 2017/10/20.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AlUtil : NSObject

/**
 获取一个唯一值

 */
+ (NSString *)getuuid;


/**
 获取uuid类型的chainID,目的是区分设备唯一性,不随应用卸载而改变
 */
+(NSString *)reqChainId;



//删除沙盒文件
+(bool) deleteDistoryFile:(NSString*)filePath;
@end
