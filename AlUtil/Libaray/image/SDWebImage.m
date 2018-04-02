//
//  SDWebImage.m
//  Chatt
//
//  Created by 张小明 on 2017/9/27.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "SDWebImage.h"

@implementation SDWebImage
+(void)setSd_img:(UIImageView *)view url:(NSString *)imgurl{
    
    [view sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:ALGetImage(@"icon_mor")];
  
}

+(void)setSd_img:(UIImageView *)view url:(NSString *)imgurl placeholderImage:(NSString *)defult_img{
    [view sd_setImageWithURL:[NSURL URLWithString:imgurl] placeholderImage:ALGetImage(defult_img)];


}

+(void)clearCacheClick:(void (^)(int))block{
    [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
        //这里是子线程
        dispatch_async(dispatch_get_main_queue(), ^{
            block(1);
        });
        
        
    }];
}


+ (NSInteger)getCachesSize{
    
    return [[SDImageCache sharedImageCache]getSize];;
}
@end
