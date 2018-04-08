//
//  LCQrcodeUtil.h
//  二维码测试
//
//  Created by 刘通超 on 16/5/5.
//  Copyright © 2016年 刘通超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LCQRCodeUtil : NSObject



/**
 生成二维码

 @param content 二维码内容
 @param size 二维码大小
 @param logo log图片  可为空
 @param logoFrame logo大小
 @param color logo颜色   必须要是三元色!!!!!
 @return 返回图片
 */
+(UIImage*)qrCodeImageWithContent:(NSString *)content
                codeImageSize:(CGFloat)size
                         logo:(UIImage *)logo
                    logoFrame:(CGFloat)logoFrame
                        Color:(UIColor*)color;

/**
 *  读取图片中二维码信息
 *
 *  @param image 图片
 *
 *  @return 二维码内容
 */
+(NSString *)readQRCodeFromImage:(UIImage *)image;
@end
