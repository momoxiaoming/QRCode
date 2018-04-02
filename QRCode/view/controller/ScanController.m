//
//  ScanController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/2.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "ScanController.h"
#import <AVFoundation/AVFoundation.h>
#import "SucController.h"

#import "LCQRCodeUtil.h"
@interface ScanController ()<AVCaptureMetadataOutputObjectsDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    CAShapeLayer *cropLayer;

}
@property (nonatomic,strong)AVCaptureDeviceInput *input;
@property (nonatomic,strong)AVCaptureDevice *device;
@property (nonatomic,strong)AVCaptureMetadataOutput *output;
@property (nonatomic,strong)AVCaptureSession *session;
@property (nonatomic,strong)AVCaptureVideoPreviewLayer *preview;
@property (nonatomic,strong) UIImageView *img;
@property (nonatomic,strong) UIImageView *line;
@property (nonatomic,strong) CABasicAnimation *animation;


@end


@implementation ScanController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
 
    self.view.backgroundColor=[UIColor blackColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    

    [self performSelector:@selector(setupCamera) withObject:nil afterDelay:0.3];
   

}
-(void)viewWillDisappear:(BOOL)animated{
//    [self stopAnimation];
}


-(void)initData{
    self.title=@"扫描";
}

-(void)initView{
    UIBarButtonItem *leftBut=[[UIBarButtonItem alloc]initWithTitle:@"相册" style:UIBarButtonItemStyleDone target:self action:@selector(leftAction)];
    
    self.navigationItem.rightBarButtonItem=leftBut;
    
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame ;
    CGFloat topHeight= rectOfStatusbar.size.height+rectOfNavigationbar.size.height;
    
    [self setCropRect:CGRectMake(self.view.bounds.size.width/2-120, (self.view.bounds.size.height-topHeight)/2-120, 240, 240)];
    

    _img=[[UIImageView alloc]init];
    _img.image=ALGetImage(@"pick_bg");
    
    [self.view addSubview:_img];
    
    _line=[[UIImageView alloc]init];
    _line.image=ALGetImage(@"line");
    [self.view addSubview:_line];
    
    
    
    
    [_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(240, 240));
    }];
    
    [_line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.centerY.equalTo(self.view).offset(-120);

        make.size.mas_equalTo(CGSizeMake(240, 1.5));
    }];
    
    
    
    [self lineAnimation];
    
    
   
}

-(void)leftAction{
    //进入相册
    [self startSelector:UIImagePickerControllerSourceTypePhotoLibrary];
}

-(void)lineAnimation{
 
   
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame ;
    CGFloat topHeight= rectOfStatusbar.size.height+rectOfNavigationbar.size.height;
    // 位置移动
    _animation = [CABasicAnimation animationWithKeyPath:@"position"];
    // 1秒后执行
    _animation.beginTime = CACurrentMediaTime() + 0.3;
    // 持续时间
    _animation.duration = 2.5;
    // 重复次数
    _animation.repeatCount = 1000000;
     _animation.autoreverses = YES;
    // 起始位置
    _animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-topHeight)/2-120)];
    // 终止位置
    _animation.toValue = [NSValue valueWithCGPoint:CGPointMake(SCREEN_WIDTH/2, (SCREEN_HEIGHT-topHeight)/2-120+240)];
    
    
    
}
-(void)startAnimation{
//    [_animation is]
    if(_animation){
        // 添加动画
        [_line.layer addAnimation:_animation forKey:@"move"];
    }
  
}

-(void)stopAnimation{
    [_line.layer removeAnimationForKey:@"move"];
}

- (void)setCropRect:(CGRect)cropRect{
    
//    CALayer *layer=[[CALayer alloc]init];
//    layer.frame=self.view.bounds;
//    layer.backgroundColor=[UIColor blackColor].CGColor;
//    [layer setOpacity:0.6];
//    [self.view.layer addSublayer:layer];
    
    cropLayer = [[CAShapeLayer alloc] init];
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, nil, cropRect);
    CGPathAddRect(path, nil, self.view.bounds);

    [cropLayer setFillRule:kCAFillRuleEvenOdd];
    [cropLayer setPath:path];
    [cropLayer setFillColor:[UIColor blackColor].CGColor];
    [cropLayer setOpacity:0.6];
//
//
    [cropLayer setNeedsDisplay];
//
    [self.view.layer addSublayer:cropLayer];
//    [self.view bringSubviewToFront:self.img];
    
}
- (void)setupCamera
{
    
    if(_session){  //
        // Start
        [_session startRunning];
         [self startAnimation];
        return;
        
    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if (device==nil) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"设备没有摄像头" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }]];
        [self presentViewController:alert animated:YES completion:nil];
        return;
    }
    // Device
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // Input
    _input = [AVCaptureDeviceInput deviceInputWithDevice:self.device error:nil];
    
    // Output
    _output = [[AVCaptureMetadataOutput alloc]init];
    [_output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    CGRect rectOfStatusbar = [[UIApplication sharedApplication] statusBarFrame];
    CGRect rectOfNavigationbar = self.navigationController.navigationBar.frame ;
    CGFloat topHeight= rectOfStatusbar.size.height+rectOfNavigationbar.size.height;
    
    
    
    //设置扫描区域
    CGFloat top = ((SCREEN_HEIGHT-topHeight)/2-120)/SCREEN_HEIGHT;
    CGFloat left = (SCREEN_WIDTH-240)/2/SCREEN_WIDTH;
    CGFloat width = 240/SCREEN_WIDTH;
    CGFloat height = 240/SCREEN_HEIGHT;
    ///top 与 left 互换  width 与 height 互换
    [_output setRectOfInterest:CGRectMake(top,left, height, width)];
    
    
    // Session
    _session = [[AVCaptureSession alloc]init];
    [_session setSessionPreset:AVCaptureSessionPresetHigh];
    if ([_session canAddInput:self.input])
    {
        [_session addInput:self.input];
    }
    
    if ([_session canAddOutput:self.output])
    {
        [_session addOutput:self.output];
    }
    
    // 条码类型 AVMetadataObjectTypeQRCode
    [_output setMetadataObjectTypes:[NSArray arrayWithObjects:AVMetadataObjectTypeQRCode, nil]];
    
    // Preview
    _preview =[AVCaptureVideoPreviewLayer layerWithSession:_session];
    _preview.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _preview.frame =self.view.layer.bounds;
    [self.view.layer insertSublayer:_preview atIndex:0];
    
    // Start
    [_session startRunning];
     [self startAnimation];
}

- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    NSString *stringValue;
    if ([metadataObjects count] >0){
        //停止扫描
        [_session stopRunning];
        [self stopAnimation];
        AVMetadataMachineReadableCodeObject * metadataObject = [metadataObjects objectAtIndex:0];
        stringValue = metadataObject.stringValue;
        NSLog(@"扫描到了-->%@",stringValue);
        
        [self sucessController:stringValue];
    }
}
-(void)sucessController:(NSString*)str{
    SucController *suc=[[SucController alloc]init];
    suc.strValue=str;
    
    [self goNextController:suc];
}

//-------------------------------相册------------

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    
    //info是所选择照片的信息
    
    //    UIImagePickerControllerEditedImage//编辑过的图片
    //    UIImagePickerControllerOriginalImage//原图
    
    //这里我们取出编辑过的图片
    UIImage *resultImage = [info objectForKey:@"UIImagePickerControllerOriginalImage"];
    
    NSString *code=[LCQRCodeUtil readQRCodeFromImage:resultImage];
    
  

    //使用模态返回到软件界面
    [self dismissViewControllerAnimated:YES completion:nil];
    [self sucessController:code];
}


-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    
    
    //这是捕获点击右上角cancel按钮所触发的事件，如果我们需要在点击cancel按钮的时候做一些其他逻辑操作。就需要实现该代理方法，如果不做任何逻辑操作，就可以不实现
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    
}



//启动选择器  type
// UIImagePickerControllerSourceTypePhotoLibrary,  //图集
//UIImagePickerControllerSourceTypeCamera,   相机
//UIImagePickerControllerSourceTypeSavedPhotosAlbum   //分组图集
- (void)startSelector:(NSInteger) type{
    
    //调用系统相册的类
    UIImagePickerController *pickerController = [[UIImagePickerController alloc]init];
    
    
    //设置选取的照片是否可编辑
    pickerController.allowsEditing = NO;
    //设置相册呈现的样式
    pickerController.sourceType =  type;//图片分组列表样式
    //照片的选取样式还有以下两种
    //UIImagePickerControllerSourceTypePhotoLibrary,直接全部呈现系统相册
    //UIImagePickerControllerSourceTypeCamera//调取摄像头
    
    //选择完成图片或者点击取消按钮都是通过代理来操作我们所需要的逻辑过程
    pickerController.delegate =self;
    //使用模态呈现相册
    [self.navigationController presentViewController:pickerController animated:YES completion:^{
        
    }];
    
    
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
