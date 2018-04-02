//
//  PayManager.m
//  CaiYiCai
//
//  Created by 张小明 on 2018/3/19.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "PayManager.h"


@implementation PayManager
+(instancetype)defult{
    static PayManager *manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager=[[PayManager alloc]init];
        [IAPManager sharedInstance].delegate = manager;

    });
    
    return manager;
}

-(void)IpaPay:(NSString*)payId orderid:(NSString *)orderid block:(void(^)(NSDictionary *)) blcok{
    self.block = blcok;
    //开始苹果支付
    [[IAPManager sharedInstance] requestProductWithId:payId orderId:orderid];
}
//内购回调
#pragma mark IApRequestResultsDelegate
- (void)filedWithErrorCode:(NSInteger)errorCode andError:(NSString *)error {
    
    NSLog(@"信息回调--%lu",errorCode);
    
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:[NSString stringWithFormat:@"%lu",errorCode] forKey:resultCode];
    
    if(_block){
        self.block(dir);

    }
    
    
}


@end
