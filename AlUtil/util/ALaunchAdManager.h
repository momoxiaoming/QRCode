//
//  ALaunchAdManager.h
//  CaiYiCai
//
//  Created by 张小明 on 2018/1/11.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef NS_ENUM(NSInteger,SkipType)
{
    SkipTypeNone = 0,       /** 无跳过 */
    SkipTypeDefault,        /** 跳过+倒计时*/
    SkipTypeAnimation,      /** 动画跳过 ⭕️ */
    
};

typedef void(^AdClickBlock)(NSString *url);






/**
 展示管理器
 */
@interface ALaunchAdManager : NSObject

DECLARE_SYNTHESIZE_SINGLETON_FOR_CLASS(ALaunchAdManager);




//缓存图片
-(void)cacheAdImage;
-(void)showAd:(AdClickBlock)block;


@end




