//
//  CodeController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/3.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "CodeController.h"
#import "LCQRCodeUtil.h"
#import "TextController.h"
#import "PicterController.h"
#import "ColorController.h"
@interface CodeController ()

@property (nonatomic,strong)UIView *imgView; //要截取为图片的view
@property (nonatomic,strong) UIImageView *img; //二维码图片

@property (nonatomic,strong)UILabel *bomView; //文字区域

@property (nonatomic,strong)UIView *menuView; //菜单选择

@property (nonatomic,strong)UIView *text_menu; //添加文字
@property (nonatomic,strong)UIView *img_menu; //添加图片
@property (nonatomic,strong)UIView *color_menu; //改变颜色

@property (nonatomic,strong)UIImage *codeImg; //二维码图片


//二维码上的附加信息
@property (nonatomic,strong)UIColor *bgColor; //二维码图片
@property (nonatomic,strong)UIColor *fillColor; //填充色
@property (nonatomic,strong)UIImage *logoImage; //logo图片
@property (nonatomic,strong)NSString *text; //附加

@property (nonatomic,strong)NSMutableDictionary *codeData; //附加信息

@end

@implementation CodeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"二维码";
    
    
}
-(void)initData{
    _codeData=[[NSMutableDictionary alloc]init];
    
    _fillColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];
    [_codeData setObject:_fillColor forKey:@"fillColor"];
    [_codeData setObject:_code forKey:@"codeStr"];
    [_codeData setObject:[UIColor colorWithRed:0 green:0 blue:0 alpha:1] forKey:@"textColor"];
    [_codeData setObject:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:@"bgColor"];

    
    
      _codeImg=[LCQRCodeUtil qrCodeImageWithContent:_code codeImageSize:SCREEN_WIDTH-10 logo:nil logoFrame:0 Color:_fillColor];
    
    if(!_codeImg){
        [self showErrorMB:@"生成错误,请返回重试!"];
//        return;
    }
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(contentAction:) name:@"codeContent" object:nil];
    
}


-(void)decodeCodeData{
    
    NSString *code= [_codeData objectForKey:@"codeStr"];
    NSString *text= [_codeData objectForKey:@"text"];
    UIColor *textColor= [_codeData objectForKey:@"textColor"];
    UIImage *logo= [_codeData objectForKey:@"logo"];
    UIColor *bgColor= [_codeData objectForKey:@"bgColor"];
    UIColor *fillColor= [_codeData objectForKey:@"fillColor"];
    
    UIImage *codeImage=[LCQRCodeUtil qrCodeImageWithContent:code codeImageSize:SCREEN_WIDTH-20 logo:logo logoFrame:60 Color:fillColor];
    
    _imgView.backgroundColor=bgColor;
   
    
    
    
    _img.image=codeImage;
    //计算文字高度
    
    
    if(ALStringIsEmpty(text)){
        
        return;
    }
    
        
     _bomView.textColor=textColor;
    _bomView.text=text;
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-10, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGFloat height= titleSize.height;
    
    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-10, SCREEN_WIDTH-10+10+height));
    }];
}

-(void)contentAction:(NSNotification *)not{
    NSDictionary *data=not.object;

    [_codeData setDictionary:data];
    [self decodeCodeData];

    
}

//还原二维码
-(void)resetCode{
    
//    _img.image=nil;
//    _bomView.text=@"";
//    _imgView.backgroundColor=[UIColor whiteColor];
    _bgColor=[UIColor colorWithRed:1 green:1 blue:1 alpha:1];
    _fillColor=[UIColor colorWithRed:0 green:0 blue:0 alpha:1];

    
    
    [_codeData setObject:_fillColor forKey:@"fillColor"];
    [_codeData setObject:_code forKey:@"codeStr"];
    [_codeData setObject:[UIColor colorWithRed:1 green:1 blue:1 alpha:1] forKey:@"textColor"];
    [_codeData setObject:_bgColor forKey:@"bgColor"];
    [_codeData setObject:@"" forKey:@"text"];
    [_codeData removeObjectForKey:@"logo"];

//
//    _codeImg=[LCQRCodeUtil qrCodeImageWithContent:_code codeImageSize:SCREEN_WIDTH-20 logo:nil logoFrame:0 Color:_fillColor];
    
    [self decodeCodeData];
    
    
    
    [_imgView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-10, SCREEN_WIDTH-10));
    }];
    
}






-(void)initView{
    
    _imgView=[[UIView alloc]init];
    ALViewRadius(_imgView, 8);

    [self.view addSubview:_imgView];
    _imgView.backgroundColor=[UIColor whiteColor];
    [_imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(5);
        make.right.equalTo(self.view).offset(-5);
        make.top.equalTo(self.view).offset(30);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-10, SCREEN_WIDTH-10));
        
    }];
    
    _img=[[UIImageView alloc]init];
    _img.backgroundColor=[UIColor clearColor];
    [_imgView addSubview:_img];
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_imgView);
        make.centerX.equalTo(_imgView);
        
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-10, SCREEN_WIDTH-10));
    }];
    
   
    
    
    _bomView=[[UILabel alloc]init];
    _bomView.textAlignment=NSTextAlignmentCenter;
    _bomView.font=[UIFont systemFontOfSize:16];
    _bomView.numberOfLines=0;
    [_imgView addSubview:_bomView];
    
    
    [_bomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgView).offset(10);
        make.right.equalTo(_imgView).offset(-10);
        make.top.equalTo(_img.mas_bottom);

        
    }];
    
    
    _menuView=[[UIView alloc]init];
    
    _menuView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:_menuView];
    
    if(kDevice_Is_iPhoneX){
        [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view).offset(-34);
            make.height.equalTo(@50);
            
        }];
    }else{
        [_menuView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.height.equalTo(@50);
            
        }];
        
    }
    
    _text_menu=[[UIView alloc]init];
    _img_menu=[[UIView alloc]init];
    _color_menu=[[UIView alloc]init];

    [_menuView addSubview:_text_menu];
    [_menuView addSubview:_img_menu];
    [_menuView addSubview:_color_menu];

    
//    _text_menu.backgroundColor=[UIColor redColor];
//    _img_menu.backgroundColor=[UIColor whiteColor];
//    _color_menu.backgroundColor=[UIColor blueColor];

    
    [_text_menu mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(_menuView);
        make.top.equalTo(_menuView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 50));
    }];
    
    [_img_menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_text_menu.mas_right);
        make.top.equalTo(_menuView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 50));
    }];
    
    [_color_menu mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_img_menu.mas_right);
        make.top.equalTo(_menuView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH/3, 50));
    }];
    
    
   UIImageView* text_menu_log=[[UIImageView alloc]init];
    UILabel* text_menu_text=[[UILabel alloc]init];
    text_menu_log.image=ALGetImage(@"text_logo");
    text_menu_text.text=@"文字";
    text_menu_text.textColor=[UIColor blackColor];

    text_menu_text.font=[UIFont systemFontOfSize:12];
    [_text_menu addSubview:text_menu_log];
    [_text_menu addSubview:text_menu_text];

    [text_menu_log mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_text_menu).offset(-10);
        make.centerX.equalTo(_text_menu);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [text_menu_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(text_menu_log);
        make.top.equalTo(text_menu_log.mas_bottom).offset(5);
    }];
    
    
    UIImageView* img_menu_log=[[UIImageView alloc]init];
    UILabel* img_menu_text=[[UILabel alloc]init];
    img_menu_log.image=ALGetImage(@"img_logo");
    img_menu_text.text=@"图片";
    img_menu_text.textColor=[UIColor blackColor];
    
    img_menu_text.font=[UIFont systemFontOfSize:12];
    [_img_menu addSubview:img_menu_log];
    [_img_menu addSubview:img_menu_text];
    
    [img_menu_log mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_img_menu).offset(-10);
        make.centerX.equalTo(_img_menu);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [img_menu_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(img_menu_log);
        make.top.equalTo(img_menu_log.mas_bottom).offset(5);
    }];
    
    
    
    UIImageView* color_menu_log=[[UIImageView alloc]init];
    UILabel* color_menu_text=[[UILabel alloc]init];
    color_menu_log.image=ALGetImage(@"color_logo");
    color_menu_text.text=@"颜色";
    color_menu_text.textColor=[UIColor blackColor];
    
    color_menu_text.font=[UIFont systemFontOfSize:12];
    [_color_menu addSubview:color_menu_log];
    [_color_menu addSubview:color_menu_text];
    
    [color_menu_log mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_color_menu).offset(-10);
        make.centerX.equalTo(_color_menu);
        make.size.mas_equalTo(CGSizeMake(20, 20));
    }];
    
    [color_menu_text mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(color_menu_log);
        make.top.equalTo(img_menu_log.mas_bottom).offset(5);
    }];
    
    
    
    
    
    
    
  
    
    
    UIBarButtonItem *right=[[UIBarButtonItem alloc]initWithTitle:@"更多" style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    self.navigationItem.rightBarButtonItem=right;
    
    UILongPressGestureRecognizer *tableViewGesture = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(rightAction)];

    
    //    tableViewGesture.view.tag=index;
    _img.userInteractionEnabled=YES;
    [_img addGestureRecognizer:tableViewGesture];
    
    
//    ColorAlertView *alerColor=[[ColorAlertView alloc]initWithFrame:CGRectZero];

    
    _img.image=_codeImg;

    
    
    [self setListener:_text_menu index:1];
    [self setListener:_img_menu index:2];
    [self setListener:_color_menu index:3];
}



-(void)rightAction{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    ALWk(weakSelf);
    [alert addAction:[UIAlertAction actionWithTitle:@"保存图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [alert dismissViewControllerAnimated:YES
                                  completion:nil];
        
        UIImage *img=[weakSelf imageFromView:_imgView];
        [weakSelf loadImageFinished:img];

    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"分享图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf sharp];
        [alert dismissViewControllerAnimated:YES
                                  completion:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"重置图片" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf resetCode];
        [alert dismissViewControllerAnimated:YES
                                  completion:nil];
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }]];
    [self presentViewController:alert animated:YES completion:nil];
  

}

/**
 截取view作为图片
 */
-(void)createImage{
    
    
}

//保存到相册
- (void)loadImageFinished:(UIImage *)image
{
    [self showProgress:@"保存.."];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    [self hideProgress];
    if(!error){
        [self showSucessMB:@"保存成功"];
    }else{
        [self showSucessMB:@"保存失败"];

    }
    
}

-(void)sharp{
    
    NSArray *images = @[@"fd2aa8bbef714343abd0b5a9259a0e02.jpg"];
    UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
    [self.navigationController presentViewController:activityController animated:YES completion:nil];
}
//获得屏幕图像
- (UIImage *)imageFromView: (UIView *) theView
{
    
    UIGraphicsBeginImageContext(theView.frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    [theView.layer renderInContext:context];
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return theImage;
}


-(void)setListener:(UIView *) arr index:(NSInteger) index{
    
    arr.tag=index;   //设置传递的参数
    UITapGestureRecognizer *tableViewGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(menuAction:)];
    //    tableViewGesture.view.tag=index;
    arr.userInteractionEnabled=YES;
    [arr addGestureRecognizer:tableViewGesture];
    
}
-(void)menuAction:(id)sender{
    UITapGestureRecognizer *tap = (UITapGestureRecognizer*)sender;
    
    UIView *views = (UIView*) tap.view;
    
    NSUInteger index = views.tag;   //获取上面view设置的tag
    
    if(index==1){
        TextController *text=[TextController new];
        text.codeData=_codeData;
        BaseNavigationController *na=[[BaseNavigationController alloc]initWithRootViewController:text];
        [self presentViewController:na animated:YES completion:nil];
        
    }else if(index==2) {
        PicterController *pic=[PicterController new];
        pic.codeData=_codeData;
        
        BaseNavigationController *na=[[BaseNavigationController alloc]initWithRootViewController:pic];
        [self presentViewController:na animated:YES completion:nil];
        
    }else if(index==3) {
        ColorController *col=[ColorController new];
        col.codeData=_codeData;
        BaseNavigationController *na=[[BaseNavigationController alloc]initWithRootViewController:col];
        [self presentViewController:na animated:YES completion:nil];
        
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
