//
//  PayManager.h
//  CaiYiCai
//
//  Created by 张小明 on 2018/3/19.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IAPManager.h"
#define resultCode @"resultCode"
@interface PayManager : NSObject<IApRequestResultsDelegate>
@property (nonatomic, copy)  void(^block) (NSDictionary*); // 结果回调
+(instancetype)defult;
-(void)IpaPay:(NSString*)payId orderid:(NSString *)orderid block:(void(^)(NSDictionary *)) blcok;
@end
