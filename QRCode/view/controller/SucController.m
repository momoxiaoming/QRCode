//
//  SucController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/2.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "SucController.h"

@interface SucController ()
@property (nonatomic,strong)UILabel *label;
@end

@implementation SucController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"扫描结果";
}
-(void)initView{
    
    _label=[[UILabel alloc]init];
    [self.view addSubview:_label];
    [_label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
}

-(void)viewWillAppear:(BOOL)animated{
    _label.text=_strValue;
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
