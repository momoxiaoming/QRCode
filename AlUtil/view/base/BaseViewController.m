//
//  BaseViewController.m
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "BaseViewController.h"
#import <OAStackView.h>

@interface BaseViewController ()
@property OAStackView *err_view;
@end

@implementation BaseViewController

-(void)initData{}
-(void)initView{}
-(void)setHideNavbar:(BOOL)isf{
    [self.navigationController.navigationBar setHidden:isf];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    
   
    self.edgesForExtendedLayout = UIRectEdgeAll; //系统默认值,系统布局需要从状态栏开始
    self.navigationController.navigationBar.translucent = NO;  //ios6之前默认为no,ios6之后默认为ysa,NO的时候,,布局就会自动从状态栏下方开始,我们布局直接从状态栏开始,无下移ß下64,但是屏幕高度会减少64

    //统一设置背景颜色
    self.view.backgroundColor=[UIColor colorWithHexString:@"#f0f0f0"];
    
    
    [self initData];
    [self initView];
    
    
//    self.automaticallyAdjustsScrollViewInsets = YES;  //根据页面高度,自动调整view的起始坐标

}



-(void)viewWillAppear:(BOOL)animated{
    [self setHideNavbar:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    self.navigationController.interactivePopGestureRecognizer.enabled = YES;
}
-(void)showAlertCon:(NSString *)title{
    [self showAlertCon:title block:nil];
}


-(void)showAlertCon:(NSString *)title block:(void(^)(void))block{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
   
      [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
          if(ALObjectIsEmpty(block)){ return;}
          block();
      }]];
    [self presentViewController:alert animated:YES completion:nil];

}

-(void)showAlertCon:(NSString *)title left:(NSString *)lefttitle leftblock:(void (^)(void))leftblock right:(NSString *)righttitle rgihtblock:(void (^)(void))rightblock{

    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:lefttitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(ALObjectIsEmpty(leftblock)){ return;}
        leftblock();
    }]];
    
    [alert addAction:[UIAlertAction actionWithTitle:righttitle style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(ALObjectIsEmpty(rightblock)){ return;}
        rightblock();
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];

}



-(void)goNextController:(UIViewController *)controller{
    UIBarButtonItem *backBtn = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    controller.navigationItem.backBarButtonItem = backBtn;
    
    [self.navigationController pushViewController:controller animated:YES];
}

-(void)ppController:(UIViewController *)controller animation:(BOOL)bo{

   
    
    controller.view.backgroundColor=[UIColor colorWithWhite:0 alpha:0.4];   //提前设置背景透明
    
    if([[[UIDevice currentDevice] systemVersion] floatValue]>8.0){  //区分版本
        controller.modalPresentationStyle=UIModalPresentationOverCurrentContext;    //该句一定要
    }else{
        controller.modalPresentationStyle=UIModalPresentationCurrentContext;    //该句一定要
        
    }
    
    //    pay.modalTransitionStyle=UIModalTransitionStyleCrossDissolve;   //这句设置弹出的动画效果
    [self presentViewController:controller animated:bo completion:^(void){
        controller.view.superview.backgroundColor=[UIColor clearColor];
        
    }];
    
    
   
}


-(void)goStackController:(NSInteger)index animation:(BOOL)bo{
   NSArray *arr=    self.navigationController.childViewControllers;
    if(arr>0&&(arr.count>index)){
        UIViewController *v=arr[index];
        [self.navigationController popToViewController:v animated:bo];
    }
  
    
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)showProgress:(NSString *)msg{
    [MBProgressHUD showMessage:msg];
}

-(void)hideProgress{
    [MBProgressHUD hideHUD];
}

-(void)showErrorMB:(NSString *)msg{
    
    [MBProgressHUD showError:msg];
}

-(void)showSucessMB:(NSString *)msg{
    
    [MBProgressHUD showSuccess:msg];
}

-(void)hidenEmoryView{
    [_err_view setHidden:YES];
    _err_view=nil;
    [self.view willRemoveSubview:_err_view];

}


-(void)showEmoryView:(NSString *)str block:(clickEmoryBolck)block{
    
    [self showEmoryView:str img:ALGetImage(@"icon_wu") block:block];
}
-(void)showEmoryView:(NSString *)str img:(UIImage *)err_img block:(clickEmoryBolck)block{
    _block=block;
    
    if(![_err_view isHidden]){
        [_err_view setHidden:YES];
    }
    
    _err_view=[[OAStackView alloc]init];
    _err_view.spacing=20;
    _err_view.axis=UILayoutConstraintAxisVertical;
    UIImageView *img=[[UIImageView alloc]init];
    img.contentMode=UIViewContentModeCenter;
    img.image=err_img;
    
    
    UILabel *txt=[[UILabel alloc]init];
    txt.numberOfLines=0;
    txt.textAlignment=NSTextAlignmentCenter;
    txt.text=str==nil?@"没有数据,请检查网络连接":str;
    [txt setTextColor:[UIColor colorWithHexString:@"#808080"]];

    
    [self.view addSubview:_err_view];
//    [self.view bringSubviewToFront:_err_view];
//    [self.view insertSubview:_err_view atIndex:99];
    [_err_view addArrangedSubview:img];
    [_err_view addArrangedSubview:txt];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@126);
    }];

    
    
    [_err_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
        make.left.equalTo(self.view).offset(40);
        make.right.equalTo(self.view).offset(-40);
    }];

    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Emoryclick)];
    [_err_view setUserInteractionEnabled:YES];
    [_err_view addGestureRecognizer:tap];
}
-(void)Emoryclick{

    if(_block!=nil){
        _block();
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
