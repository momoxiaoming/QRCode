//
//  ModeController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/2.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "ModeController.h"
#import "CodeController.h"
@interface ModeController ()
@property (weak, nonatomic) IBOutlet UITextView *top_view;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation ModeController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)initData{
    self.title=@"生成";
}
-(void)initView{
    ALViewBorderRadius(_top_view, 8, 1, BaseColor);
    ALViewRadius(_btn, 8);
    
    [_btn addTarget:self action:@selector(btnAction) forControlEvents:UIControlEventTouchUpInside];
}


-(void)btnAction{
    NSString *codestr=_top_view.text ;
    codestr=strByTrim(codestr);
    
    if(codestr.length<=0){
        [self showErrorMB:@"输入内容不能为空哦!"];
        return;
    }
    CodeController *code=[CodeController new];
    code.code=codestr;
    
    [self goNextController:code];
    
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
