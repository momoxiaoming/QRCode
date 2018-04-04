//
//  TextController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/3.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "TextController.h"
#import "ALColorSelectorView.h"
@interface TextController ()
@property (nonatomic,strong) UITextView *textView;

@property (nonatomic,strong) UIImageView *close_img;
@property (nonatomic,strong) UIImageView *yes_img;

@property (nonatomic,strong) UIView *top_view;

@property (nonatomic,strong) ALColorSelectorView *color_view;



@end

@implementation TextController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.view.backgroundColor=[UIColor blueColor];
    
//    self.view.backgroundColor=[UIColor colorWithHexString:@"#CC6600" alpha:0.5];
    
    self.title=@"文字";
    
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
    
    
    ALViewBorderRadius(_textView, 8, 1, BaseColor);

    
    //---
    _color_view=[[ALColorSelectorView alloc]initWithFrame:CGRectMake(0, 310, SCREEN_WIDTH, 30)];
    
    [self.view addSubview:_color_view];
    
    
    
    
    [self setListener:_close_img index:1];
    [self setListener:_yes_img index:2];

    
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
    
   
    NSMutableDictionary *dir=[[NSMutableDictionary alloc]init];
    [dir setObject:@"1" forKey:@"type"];
    [dir setObject:content forKey:@"content"];
    
    
    
    
    
    [[NSNotificationCenter defaultCenter]postNotificationName:@"codeContent" object:dir];
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
    
    if(index==1){
        [self dismissViewControllerAnimated:YES completion:nil];
    }else if(index==2){
        [self dismissViewControllerAnimated:YES completion:nil];

        
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
