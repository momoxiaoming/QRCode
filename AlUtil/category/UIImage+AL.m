//
//  UIImage+AL.m
//  Chatt
//
//  Created by 张小明 on 2017/10/20.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "UIImage+AL.h"
#import <AVFoundation/AVFoundation.h>
@implementation UIImage (AL)


//+(NSString *)saveImageToDocument:(UIImage *)image{
//    NSDateFormatter *formater = [[NSDateFormatter alloc] init];//用时间给文件全名，以免重复，在测试的时候其实可以判断文件是否存在若存在，则删除，重新生成文件即可
//    [formater setDateFormat:@"yyyy-MM-dd-HH-mm-ss"];
//    NSString *timeName= [formater stringFromDate:[NSDate date]];
//    
//    //注意,不能再沙盒中添加文件夹,否者会出错
//    NSString *newfileName=[NSString stringWithFormat:@"%@.jpg",timeName];
//    // 本地沙盒目录
//    NSString *path = ALPathDocument;
//    // 得到本地沙盒中名为"MyImage"的路径，"MyImage"是保存的图片名
//    NSString *imageFilePath =nil;
//    imageFilePath=[path stringByAppendingPathComponent:newfileName];
//    // 将取得的图片写入本地的沙盒中，其中0.5表示压缩比例，1表示不压缩，数值越小压缩比例越大
//    BOOL success = [UIImageJPEGRepresentation(image, 0.5) writeToFile:imageFilePath  atomically:YES];
//    
//    if (success){
//        NSLog(@"写入本地成功");
//        return imageFilePath;
//    }
//    
//    
//    return @"--";
//
//}
//+(UIImage *)fFirstVideoFrame:(NSString *)path {
//   
//        
//        AVURLAsset *asset = [[AVURLAsset alloc] initWithURL:[NSURL fileURLWithPath:path] options:nil];
//        
//        AVAssetImageGenerator *gen = [[AVAssetImageGenerator alloc] initWithAsset:asset];
//        
//        gen.appliesPreferredTrackTransform = YES;
//        
//        CMTime time = CMTimeMakeWithSeconds(0.0, 600);
//        
//        NSError *error = nil;
//        
//        CMTime actualTime;
//        
//        CGImageRef image = [gen copyCGImageAtTime:time actualTime:&actualTime error:&error];
//        
//        UIImage *thumb = [[UIImage alloc] initWithCGImage:image];
//        
//        CGImageRelease(image);
//        
//        return thumb;
//    
//    
//    
//}



@end
