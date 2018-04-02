//
//  SDWebImage.h
//  Chatt
//
//  Created by 张小明 on 2017/9/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SDWebImage : NSObject


/**
 该方法默认了空格图

 @param view UIImageView
 @param imgurl 地址
 */
+(void)setSd_img:(UIImageView *)view url:(NSString *)imgurl;


/**
 通过网络地址加载图片
 
 @param view UIImageView
 @param imgurl 地址
 */
+(void)setSd_img:(UIImageView *)view url:(NSString *)imgurl placeholderImage:(NSString *)defult_img;

/**
清除图片缓存
 */
+ (void)clearCacheClick:(void(^)(int i))block;

/**
 获取图片缓存

 */
+ (NSInteger)getCachesSize;
@end
