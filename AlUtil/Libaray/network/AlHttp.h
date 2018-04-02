//
//  AlNetWork.h
//  CaiYiCai
//
//  Created by 张小明 on 2018/1/11.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFHTTPSessionManager.h>

#define AlNet [AlHttp instance]

@interface AlHttp : AFHTTPSessionManager
+(_Nonnull instancetype)instance;


@end
