//
//  AlHeader.h
//  Chatt
//
//  Created by 张小明 on 2017/9/21.
//  Copyright © 2017年 张小明. All rights reserved.
//  allen 常用的宏,只要将该头文件添加进项目的pch文件即可

#ifndef AlHeader_h
#define AlHeader_h

//-----------------------------------工具包中一些常用类库入-----------------------------------------------//

#import "UIColor+AL.h"    
#import "UIImage+AL.h"
#import "MBProgressHUD+AL.h"
#import "UIView+ALCore.h"
#import "NSDate+AL.h"
#import "CompressionImge.h"
#import "AlUtil.h"
#import "KeyChain.h"
#import "AlHttp.h"
#import "SDWebImage.h"

#import "BaseViewController.h"
#import "BaseNavigationController.h"
#import "BaseTableCell.h"

#import <AFNetworking.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import <Masonry.h>
#import <UIImageView+WebCache.h>
//全局的宏

//debug 模式宏
#ifdef DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"%s:%d\t%s\n",[[[NSString stringWithUTF8String:__FILE__] lastPathComponent] UTF8String], __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif


//app 默认的一些资源
//#define ALDefultImage(imageName) [UIImage imageNamed:@"icon_mor"] //获取图片

#define SDIMG(UIimageView,b,c) [a]



//框架快捷使用,以防换框架




//处理block循环引用的宏
#define ALWk(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//-----------屏幕尺寸相关------------
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
//-----------缩放适配---360为设计稿的宽度--和高度----------
#define AWscale(n) (([UIScreen mainScreen].bounds.size.width)/360)*n
#define AHscale(n) (([UIScreen mainScreen].bounds.size.height)/640)*n


//缩放适配2
//判断设备类型
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size)) : NO)
#define iPhone6plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? (CGSizeEqualToSize(CGSizeMake(1125, 2001), [[UIScreen mainScreen] currentMode].size) || CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size)) : NO)
#define kDevice_Is_iPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size) : NO)

#define kWidth(R) (R)*(SCREEN_WIDTH)/375 //这里的375我是针对6为标准适配的,如果需要其他标准可以修改
#define kHeight(R) (kDevice_Is_iPhoneX?(kWidth(R)):((R)*(SCREEN_HEIGHT)/667))  //这里的6我是针对6为标准适配的,如果需要其他标准可以修改,如果是iphonex,那么高度就按宽度缩放去适配
#define font(R) (R)*(SCREEN_WIDTH)/375.0  //这里是6屏幕字体
#define KFont(R) [UIFont systemFontOfSize:font(R)]  //这里是6屏幕字体

#define ALNAVBAR_HEIGHT  ([[[UIDevice currentDevice] systemVersion] floatValue]>=7.0?64.0f:44.0f)













//-----------颜色相关------------
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a] //设置颜色值加透明度

#define RGB(r,g,b) RGBA(r,g,b,1.0f) //设置颜色值


#define ALRandomColor [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0]//得到一个随机颜色
//-----------图形相关------------

#define ALViewBorderRadius(View, Radius, Width, Color)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];\
[View.layer setBorderWidth:(Width)];\
[View.layer setBorderColor:[Color CGColor]]   //设置图形边框,圆角,颜色

//只设置圆角
#define ALViewRadius(View, Radius)\
[View.layer setCornerRadius:(Radius)];\
[View.layer setMasksToBounds:YES];

//获取一些常亮
//获取广告标识符,用于广告推广,换量追踪等用处   --卸载程序不变,但还原手机会变
#define IPFA [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString]
//应用开发商标识符 ,卸载程序会变
#define IDFV [[[UIDevice currentDevice] identifierForVendor] UUIDString]
// create a new UUID which you own
#define ALUUID 



//---------------快捷语法-----------------、、


#define ALOpenUrl(a) [[UIApplication sharedApplication] openURL:[NSURL URLWithString:(a)]]

//去空格
#define strByTrim(a) [a stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]

#define ALocalizedString(key) [[NSBundle mainBundle] localizedStringForKey:(key) value:@"" table:nil] //根据key获取资源文件中的字符串
#define ALDef [NSUserDefaults standardUserDefaults]  //获取归档对象
#define ALGetImage(imageName) [UIImage imageNamed:[NSString stringWithFormat:@"%@",imageName]] //获取图片

#define ALStrEqlstr(a,b) [a isEqualToString:b] //获取图片



//-------------获取一些系统路径----------
//获取temp
#define ALPathTemp NSTemporaryDirectory()
//获取沙盒 Document
#define ALPathDocument [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]
//获取沙盒 Cache
#define ALPathCache [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject]
//获取bundle资源路径
#define ALBundlePath(fileName,fileType) [[NSBundle mainBundle] pathForResource:fileName ofType:fileType]



//判断字符串为空,注意!@""也可用这个宏判断ß
#define ALStringIsEmpty(str) ([str isKindOfClass:[NSNull class]] || str == nil || [str length] < 1 ? YES : NO )
//判断数组为空
#define ALArrayIsEmpty(array) (array == nil || [array isKindOfClass:[NSNull class]] || array.count == 0)
//判断字典为null
#define ALDictIsEmpty(dic) (dic == nil || [dic isKindOfClass:[NSNull class]] || dic.allKeys == 0)
//判断对象为空
#define ALObjectIsEmpty(_object) (_object == nil \
|| [_object isKindOfClass:[NSNull class]] \
|| ([_object respondsToSelector:@selector(length)] && [(NSData *)_object length] == 0) \
|| ([_object respondsToSelector:@selector(count)] && [(NSArray *)_object count] == 0))



//-------------------------
//单利的创建
//Student *dt1= [Student sharedInstance];

//声明   实现一个类的单利 ,在.h中假如以下声明
#define DECLARE_SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
+ (classname *)sharedInstance; \
\


//实现  在.m中假如以下
#define IMPLEMENT_SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)sharedInstance \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
} \
\




#endif /* AlHeader_h */
