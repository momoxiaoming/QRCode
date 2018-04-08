//
//  TextController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/3.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "TextController.h"
#import "ALColorSelectorView.h"
#import "ColorAlertView.h"
#import <IQKeyboardManager.h>
@interface TextController ()
@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UIImageView *close_img;
@property (nonatomic,strong) UIImageView *yes_img;

@property (nonatomic,strong) UIView *top_view;

@property (nonatomic,strong) ColorAlertView *color_view;
@property (nonatomic,strong)  UIButton *label;


@property (nonatomic,strong)  UIColor *baseColor;

@end

@implementation TextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[UIColor blueColor];
    
//    self.view.backgroundColor=[UIColor colorWithHexString:@"#CC6600" alpha:0.5];
    
    self.title=@"文字";
    
}

-(void)viewWillAppear:(BOOL)animated{
//    [IQKeyboardManager sharedManager].shouldResignOnTouchOutside=YES;
[IQKeyboardManager sharedManager].enableAutoToolbar = NO;
}


-(void)initView{

    UIBarButtonItem *close=[[UIBarButtonItem alloc]initWithImage:ALGetImage(@"close_img") style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    UIBarButtonItem *yes_btn=[[UIBarButtonItem alloc]initWithImage:ALGetImage(@"yes_img") style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    self.navigationItem.rightBarButtonItem=yes_btn;
    ;
    self.navigationItem.leftBarButtonItem=close;
    

    
    _textView=[[UITextView alloc]init];
    _textView.font=[UIFont systemFontOfSize:16];
    [self.view addSubview:_textView];
    
    _textView.accessibilityHint=@"请输入要添加的文字";
    
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(30);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@200);
    }];
    
    
    ALViewBorderRadius(_textView, 8, 0.5, BaseColor);

    
    //---
   
    
    
    
    _label=[[UIButton alloc]init];
//    _label.titleLabel.textColor=[UIColor blackColor];
//    [_label setTintColor:[UIColor blackColor]];
    _label.titleLabel.font=[UIFont systemFontOfSize:12];
    [_label setTitleColor:BaseColor forState:UIControlStateNormal];
    [_label setTitle:@"设置文字颜色" forState:UIControlStateNormal];
    [self.view addSubview:_label];
    
    ALViewBorderRadius(_label, 8, 1, BaseColor);
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_textView.mas_bottom).offset(20);
        make.centerX.equalTo(self.view);
        make.size.mas_equalTo(CGSizeMake(100, 40));
    }];
    
    
    
    
    _color_view=[[ColorAlertView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_color_view];

    
    [_color_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(_label.mas_bottom).offset(20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 110));
    }];
    
    
    [_color_view initData:^(NSInteger index,UIColor *color) {
        [_textView setTextColor:color];
        _baseColor=color;
    }];
    

    
    
    
    [self setListener:_close_img index:1];
    [self setListener:_yes_img index:2];
    [self setListener:_label index:3];
    [self setListener:self.view index:0];

    
}
-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightAction{
    NSString *content=strByTrim(_textView.text);
    if(content.length<=0){
        [self showErrorMB:@"添加的文字为空!"];
        return ;
    }

    [_codeData setValue:content forKey:@"text"];
    [_codeData setValue:_baseColor==nil?[UIColor blackColor]:_baseColor forKey:@"textColor"];

    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"codeContent" object:_codeData];
    [self dismissViewControllerAnimated:YES completion:nil];

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
    if(index==0){
        [_color_view hidenAlertView];
        [self.textView resignFirstResponder];//关闭键盘
    }else if(index==1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(index==2){
        [self dismissViewControllerAnimated:YES completion:nil];

        
    }else if(index==3){
        //弹出颜色选择框
        
        [_color_view hidenAlertView];
        [_color_view showAlert:1];
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
