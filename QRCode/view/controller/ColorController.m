//
//  ColorController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/6.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "ColorController.h"
#import "ColorAlertView.h"
#import "LCQRCodeUtil.h"
@interface ColorController ()
@property (nonatomic,strong)UIView *codeView;
@property (nonatomic,strong)UIView *bomView;

@property (nonatomic,strong)UIImageView *codeImgView;

@property (nonatomic,strong) ColorAlertView *color_view;
@property (nonatomic,strong)UILabel *label;

@property (nonatomic ,strong)UIColor *fill_color;
@property (nonatomic ,strong)UIColor *bg_color;
@property (nonatomic ,strong)UIImage *codeImg;

@end

@implementation ColorController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"颜色";
}

-(void)initData{
//    _codeImg=[LCQRCodeUtil qrCodeImageWithContent:_codeStr codeImageSize:SCREEN_WIDTH-80 logo:nil logoFrame:0 Color:[UIColor whiteColor]];
    
    
    
}

-(void)decodeCodeData{
    
    NSString *code= [_codeData objectForKey:@"codeStr"];
    NSString *text= [_codeData objectForKey:@"text"];
    UIColor *textColor= [_codeData objectForKey:@"textColor"];
    UIImage *logo= [_codeData objectForKey:@"logo"];
    UIColor *bgColor= [_codeData objectForKey:@"bgColor"];
    UIColor *fillColor= [_codeData objectForKey:@"fillColor"];
    
    UIImage *codeImage=[LCQRCodeUtil qrCodeImageWithContent:code codeImageSize:SCREEN_WIDTH-80 logo:logo logoFrame:50 Color:fillColor==nil?[UIColor blackColor]:fillColor];
    
    _codeView.backgroundColor=ALObjectIsEmpty(bgColor)?[UIColor whiteColor]:bgColor;
    _label.textColor=textColor;
    _label.text=text;
    
    
    _codeImgView.image=codeImage;

    //计算文字高度
    
    if(ALStringIsEmpty(text)){
        return;
    }
    
    CGSize titleSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGFloat height= titleSize.height;
    
    [_codeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, SCREEN_WIDTH-80+10+height));
    }];
    

}



-(void)initView{
    
    UIBarButtonItem *close=[[UIBarButtonItem alloc]initWithImage:ALGetImage(@"close_img") style:UIBarButtonItemStylePlain target:self action:@selector(leftAction)];
    
    UIBarButtonItem *yes_btn=[[UIBarButtonItem alloc]initWithImage:ALGetImage(@"yes_img") style:UIBarButtonItemStylePlain target:self action:@selector(rightAction)];
    
    self.navigationItem.rightBarButtonItem=yes_btn;
    ;
    self.navigationItem.leftBarButtonItem=close;
    
    _codeView=[[UIView alloc]init];
    _codeImgView=[[UIImageView alloc]init];
    ALViewRadius(_codeView, 8);

    _codeView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:_codeView];
    [_codeView addSubview:_codeImgView];
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, SCREEN_WIDTH-80));
        make.centerX.equalTo(self.view);
    }];
    
    [_codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_codeView);
        make.centerX.equalTo(_codeView);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, SCREEN_WIDTH-80));
    }];
  
    _label=[[UILabel alloc]init];
    _label.textAlignment=NSTextAlignmentCenter;
    _label.font=[UIFont systemFontOfSize:14];
    //    [_bomView setLineBreakMode:NSLineBreakByCharWrapping];
    _label.numberOfLines=0;
    [_codeView addSubview:_label];
    
    
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_codeView).offset(10);
        make.right.equalTo(_codeView).offset(-10);
        make.top.equalTo(_codeImgView.mas_bottom);
        
    }];
    
    
    
    //
    
    
    _bomView=[[UIView alloc]init];
    _bomView.backgroundColor=[UIColor whiteColor];
    [self.view addSubview:_bomView];
    
    [_bomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.equalTo(@55);
    }];
    
    UIView *left=[[UIView alloc]init];
    UIView *right=[[UIView alloc]init];

    [_bomView addSubview:left];
    [_bomView addSubview:right];
    
    [left mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bomView);
        make.left.equalTo(_bomView);
        make.height.equalTo(_bomView);
        make.width.equalTo(_bomView).multipliedBy(0.5);
    }];

    [right mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_bomView);
        make.right.equalTo(_bomView);
        make.height.equalTo(_bomView);
        make.width.equalTo(_bomView).multipliedBy(0.5);
    }];
    
    
    UIImageView *left_img=[[UIImageView alloc]init];
    UILabel *left_txt=[[UILabel alloc]init];
    left_img.image=ALGetImage(@"fill_img");
    left_txt.text=@"填充色";
    left_txt.font=[UIFont systemFontOfSize:12];

    
    [left addSubview:left_img];
    [left addSubview:left_txt];
    
    [left_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(left);
        make.centerY.equalTo(left).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
        
    }];
    
    [left_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(left_img.mas_bottom).offset(5);
        make.centerX.equalTo(left_img);
        
        
    }];
    
    UIImageView *right_img=[[UIImageView alloc]init];
    UILabel *right_txt=[[UILabel alloc]init];
    
    
    right_img.image=ALGetImage(@"bg_img");
    right_txt.text=@"背景色";
    right_txt.font=[UIFont systemFontOfSize:12];
    
    [right addSubview:right_img];
    [right addSubview:right_txt];

    
    
    [right_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(right);
        make.centerY.equalTo(right).offset(-10);
        make.size.mas_equalTo(CGSizeMake(30, 30));
        
        
    }];
    
    [right_txt mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(right_img.mas_bottom).offset(5);
        make.centerX.equalTo(right_img);
        
        
    }];
    
    
    _color_view=[[ColorAlertView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:_color_view];
    
    
    [_color_view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(_bomView.mas_top).offset(-20);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-20, 110));
    }];
    
    
    [_color_view initData:^(NSInteger index,UIColor *color) {

        if(index==1){
            _fill_color=color;
            [_codeData setValue:_fill_color forKey:@"fillColor"];

            [self decodeCodeData];

        }else{
            _bg_color=color;
            _codeView.backgroundColor=_bg_color;
            [_codeData setValue:color forKey:@"bgColor"];

        }
    }];
    
    [self setListener:self.view index:0];

    [self setListener:left index:1];
    [self setListener:right index:2];

    [self decodeCodeData];
    
}
-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightAction{
    UIColor *bgColor=_bg_color;
    UIColor *fillColor=_fill_color;

   
    
    [_codeData setValue:fillColor==nil?[UIColor blackColor]:fillColor forKey:@"fillColor"];
    [_codeData setValue:bgColor==nil?[UIColor whiteColor]:bgColor forKey:@"bgColor"];

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
    }else if(index==1){
        
        [_color_view showAlert:1];
        
    }else if(index==2){
        [_color_view showAlert:2];

        
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
