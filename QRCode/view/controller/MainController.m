//
//  MainController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/2.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "MainController.h"
#import "ScanController.h"
#import "ModeController.h"
#import "AboutController.h"
@interface MainController ()
@property (weak, nonatomic) IBOutlet UIView *item1_bgview;
@property (weak, nonatomic) IBOutlet UIView *item2_bgview;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void)initData{
    
    self.title=@"二维码全能王";
    
    
    
}
-(void)initView{
    ALViewRadius(_item1_bgview, 8);
    ALViewRadius(_item2_bgview, 8);
    
    [self setListener:_item1_bgview index:1];
    [self setListener:_item2_bgview index:2];
    
    
    
    
    UIBarButtonItem *obout=[[UIBarButtonItem alloc]initWithTitle:@"关于" style:UIBarButtonItemStyleDone target:self action:@selector(rightAction)];
    self.navigationItem.leftBarButtonItem=obout;
}
-(void)rightAction{
    [self goNextController:[AboutController new]];
    
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
        
        [self goNextController:[ScanController new]];
        
//        [self presentViewController:[ScanController new] animated:YES completion:nil];
    }else if(index==2){
        
        [self goNextController:[ModeController new]];

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
