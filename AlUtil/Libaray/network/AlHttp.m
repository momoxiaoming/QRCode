//
//  AlNetWork.m
//  CaiYiCai
//
//  Created by 张小明 on 2018/1/11.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "AlHttp.h"

@implementation AlHttp
+(instancetype)instance{
    static AlHttp* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [self manager];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html",@"application/json",@"text/plain",@"image/jpeg",@"image/png",@"application/octet-stream",nil];
        manager.securityPolicy.allowInvalidCertificates =YES;
//        manager 
    });
    return manager;
}
@end
