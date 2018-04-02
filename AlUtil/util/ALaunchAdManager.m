//
//  ALaunchAdManager.m
//  CaiYiCai
//
//  Created by 张小明 on 2018/1/11.
//  Copyright © 2018年 张小明. All rights reserved.
//  启动页广告管理器

#import "ALaunchAdManager.h"
#define kScreen_Bounds  [UIScreen mainScreen].bounds
#define kDefaultDuration 3//默认停留时间


#define cachedata_key @"cachedata"  //缓存的数据
#define cacheImageUrl_key @"launchImgUrl"  //缓存的图片地址的key
#define cacheMinlls_key @"launchTime" //缓存的秒数的key
#define cacheOpenUrl_key @"launchUrl" //打开的网页
#define cacheOpencode_key @"launchCode" //打开的网页


//json数据返回
//{
//opencode:@"1"   1是打开广告
//imageUrl:@""
//minlls:@""
//openUrl:@""
//}
@interface ALaunchAdManager()
@property (nonatomic,strong)UIView *launchView;
@property (nonatomic,strong)UIImageView *launchImageView;
@property (nonatomic,strong)UILabel *skipLab;

@property (nonatomic,copy)NSString *openUrl;

@property AdClickBlock block;

@property NSTimer *timez;

//延迟多少秒
@property (nonatomic) NSInteger delay;
@end;


@implementation ALaunchAdManager
IMPLEMENT_SYNTHESIZE_SINGLETON_FOR_CLASS(ALaunchAdManager)
static ALaunchAdManager *manager=nil;

-(void)initLaunch:(NSInteger)delayMinls SkipType:(SkipType)type Image:(UIImage*)img openUrl:(NSString *)openUrl{
    self.delay=delayMinls;
    self.openUrl=openUrl;
    [self initLaunchView:img];
    //将页面添加到
    [self addInWindow];
    
}



-(void)showAd:(AdClickBlock)block{
    //首先检查是否有缓存的图片,
    NSDictionary *dir=[ALDef objectForKey:cachedata_key];
    if(dir==nil){
        return;
    }
    NSString *imageUrl=[dir objectForKey:cacheImageUrl_key];
    NSString *minlls=[dir objectForKey:cacheMinlls_key];
    NSString *open=[dir objectForKey:cacheOpenUrl_key];
    NSString *opencode=[dir objectForKey:cacheOpencode_key];

    if(ALStrEqlstr(@"1", opencode)){
        //广告页打开
        if(imageUrl&&open){
            UIImage *img=[[UIImage alloc]initWithContentsOfFile:imageUrl];
            if(img==nil){
                return;
            }
            //如果有
            [self initLaunch:[minlls integerValue] SkipType:SkipTypeDefault Image:img openUrl:open];
            self.block = block;
            
        }
    }
    
    
    
    
}


-(void)cacheAdImage{
    
    
    
    [AlNet POST:@"" parameters:nil constructingBodyWithBlock:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
    NSDictionary *res=[[NSDictionary alloc]init];;
    
        NSString *url=[res objectForKey:cacheImageUrl_key];
        NSString *minls=[res objectForKey:cacheImageUrl_key];
        NSString *openUrl=[res objectForKey:cacheOpenUrl_key];
        NSString *opencode=[res objectForKey:cacheOpencode_key];

//    minls=@"5";
//        url=@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515668854840&di=efbb49191e82a83e8d7a27014f80e660&imgtype=0&src=http%3A%2F%2Fimg.zcool.cn%2Fcommunity%2F0158d458b77c62a801219c77c7985b.png";
//        openUrl=@"http:www.baidu.com";
    
        if(url!=nil&&openUrl!=nil){
            
            
            
            //下载图片到本地
            NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            //转为图片对象
            UIImage *img=[UIImage imageWithData:data];
            //获得沙盒路径 ,launchimg 是保存的文件名
            NSString *path= [ALPathDocument stringByAppendingPathComponent:@"launchimg.png"];
          
            BOOL issucess=  [UIImagePNGRepresentation(img) writeToFile:path atomically:YES];

            if(issucess){
                NSMutableDictionary *cache=[[NSMutableDictionary alloc]init];
                [cache setObject:path forKey:cacheImageUrl_key];
                [cache setObject:minls forKey:cacheMinlls_key];
                [cache setObject:openUrl forKey:cacheOpenUrl_key];
                [cache setObject:opencode forKey:cacheOpencode_key];

                //保存成功
               [ALDef setObject:cache forKey:cachedata_key];
               [ALDef synchronize];
            }
        
        }
//
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {

    }];
    
}

- (void)addInWindow{
    //监测DidFinished通知
    [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification * _Nonnull note) {
        //等DidFinished方法结束后,将其添加至window上(不然会检测是否有rootViewController)
        dispatch_async(dispatch_get_main_queue(), ^{
            [[[UIApplication sharedApplication].delegate window] addSubview:self.launchView];
            [UIView animateWithDuration:1 animations:^{
                self.launchView.alpha = 1;
            } completion:^(BOOL finished) {
                [self startTimeZ];

            }];
        });
    }];
}


-(void)removeAd{
    [UIView animateWithDuration:1.0 animations:^{
        [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
        self.launchView.transform=CGAffineTransformMakeScale(1.5, 1.5);
        self.launchView.alpha = 0;
    } completion:^(BOOL finished) {
        [self.launchView removeFromSuperview];
        [self stopTimeZ];
    }];
}
//开始倒计时计时
-(void)startTimeZ{
    _timez=[NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeAction) userInfo:nil repeats:YES];
   
    
}
-(void)timeAction{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        _delay=_delay-1;
         _skipLab.text=[NSString stringWithFormat:@"跳过%lu秒",_delay];
        if(_delay==0){
            [self removeAd];
           
            return;
        }
       
        
    });
    
}

//停止计时
-(void)stopTimeZ{
    if(_timez){
        [_timez invalidate];
    }
}

//初始化广告页面
-(void)initLaunchView:(UIImage *)img{
    _launchView=[[UIView alloc]initWithFrame:kScreen_Bounds];
    _launchView.backgroundColor=[UIColor yellowColor];
    _launchImageView=[[UIImageView alloc]initWithFrame:_launchView.frame];
    _skipLab=[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-70, 40, 50, 25)];

 
    
    
    _skipLab.text=[NSString stringWithFormat:@"跳过%lu秒",_delay];
    _skipLab.textColor=[UIColor whiteColor];
    _skipLab.font=[UIFont systemFontOfSize:10];
    _skipLab.numberOfLines=0;
    _skipLab.textAlignment=NSTextAlignmentCenter;
    ALViewBorderRadius(_skipLab, 12.5, 0, [UIColor whiteColor]);
    _skipLab.backgroundColor=[UIColor colorWithHexString:@"#000000" alpha:0.5];
    
    _launchImageView.image=img;
    
    [_launchView addSubview:_launchImageView];
    [_launchView addSubview:_skipLab];
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(clickAcion)];
    _skipLab.userInteractionEnabled=true;
    [_skipLab addGestureRecognizer:tap];

    UITapGestureRecognizer *tap2=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ImageclickAcion)];
    _launchImageView.userInteractionEnabled=true;
    [_launchImageView addGestureRecognizer:tap2];
    
}
//点击图片要跳转的
-(void)ImageclickAcion{
    [self removeAd];
    if(_block){
        _block(_openUrl);
    }
}
//点击了跳过
-(void)clickAcion{
    [self removeAd];
    
}



@end
