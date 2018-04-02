//
//  UIColor+AL.h
//  Chatt
//
//  Created by 张小明 on 2017/9/21.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (AL)
+ (UIColor *)colorWithHexString:(NSString *)color;

//从十六进制字符串获取颜色，
//color:支持@“#123456”、 @“0X123456”、 @“123456”三种格式
+ (UIColor *)colorWithHexString:(NSString *)color alpha:(CGFloat)alpha;

+(UIImage*) createImage:(NSString*) color;
//颜色转图片
+(UIImage*) createImageForColor:(UIColor*) colo;
@end
