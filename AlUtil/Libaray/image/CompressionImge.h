//
//  CompressionImge.h
//  QsQ
//
//  Created by 张小明 on 2017/6/19.
//  Copyright © 2017年 张小明. All rights reserved.
//  用于图片压缩

#import <Foundation/Foundation.h>

@interface CompressionImge : NSObject
- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;

//高斯模糊效果
+(UIImage *)boxblurImage:(UIImage *)image withBlurNumber:(CGFloat)blur;
@end
