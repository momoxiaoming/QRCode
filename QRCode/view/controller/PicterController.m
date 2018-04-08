//
//  PicterController.m
//  QRCode
//
//  Created by 张小明 on 2018/4/6.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "PicterController.h"
#import "CodeImgCell.h"
#import "LCQRCodeUtil.h"
@interface PicterController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic,strong)UIView *codeView;
@property (nonatomic,strong)UIImageView *codeImgView;
@property (nonatomic,strong)UICollectionView *bomView;
@property (nonatomic,strong)UIImage *codeImage;
@property (nonatomic,strong)UILabel *label;

@property NSMutableArray *codeImgArr;


@end
@implementation PicterController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.title=@"图片";
    
}
-(void)viewWillAppear:(BOOL)animated{
    
}

-(void)decodeCodeData{
    
    NSString *code= [_codeData objectForKey:@"codeStr"];
    NSString *text= [_codeData objectForKey:@"text"];
    UIColor *textColor= [_codeData objectForKey:@"textColor"];
    UIImage *logo= [_codeData objectForKey:@"logo"];
    UIColor *bgColor= [_codeData objectForKey:@"bgColor"];
    UIColor *fillColor= [_codeData objectForKey:@"fillColor"];

    UIImage *codeImage=[LCQRCodeUtil qrCodeImageWithContent:code codeImageSize:SCREEN_WIDTH-80 logo:logo logoFrame:50 Color:fillColor];
    
    
    _codeView.backgroundColor=bgColor;
    
    _label.textColor=textColor;
    _label.text=text;
    
    
    
    _codeImgView.image=codeImage;
    
    if(ALStringIsEmpty(text)){
        return;
    }
    //计算文字高度
    
     CGSize titleSize = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH-80, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]} context:nil].size;
    CGFloat height= titleSize.height;
    
    [_codeView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, SCREEN_WIDTH-80+10+height));
    }];
}

-(void)initData{
    
    
 
    
    _codeImgArr=[[NSMutableArray alloc]init];
    
    NSMutableDictionary *data=[[NSMutableDictionary alloc]init];
    [data setObject:@"无" forKey:@"name"];
    [data setObject:@"wu" forKey:@"img"];
    [_codeImgArr addObject:data];
    
    NSMutableDictionary *data2=[[NSMutableDictionary alloc]init];
    [data2 setObject:@"微信" forKey:@"name"];
    [data2 setObject:@"weixin" forKey:@"img"];
    [_codeImgArr addObject:data2];
    NSMutableDictionary *data3=[[NSMutableDictionary alloc]init];
    [data3 setObject:@"QQ" forKey:@"name"];
    [data3 setObject:@"QQ" forKey:@"img"];
    [_codeImgArr addObject:data3];
    
    NSMutableDictionary *data4=[[NSMutableDictionary alloc]init];
    [data4 setObject:@"支付宝" forKey:@"name"];
    [data4 setObject:@"zhifubao" forKey:@"img"];
    [_codeImgArr addObject:data4];
    
    NSMutableDictionary *data5=[[NSMutableDictionary alloc]init];
    [data5 setObject:@"微博" forKey:@"name"];
    [data5 setObject:@"sina" forKey:@"img"];
    [_codeImgArr addObject:data5];
    
    NSMutableDictionary *data6=[[NSMutableDictionary alloc]init];
    [data6 setObject:@"男孩" forKey:@"name"];
    [data6 setObject:@"boy" forKey:@"img"];
    [_codeImgArr addObject:data6];
    
    NSMutableDictionary *data7=[[NSMutableDictionary alloc]init];
    [data7 setObject:@"女孩" forKey:@"name"];
    [data7 setObject:@"grils" forKey:@"img"];
    [_codeImgArr addObject:data7];
    
    
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
    _bomView=[self createCollectionView];
//    _codeImgView.backgroundColor=[UIColor whiteColor];
    
//    _codeView.backgroundColor=[UIColor whiteColor];
    
    [self.view addSubview:_codeView];
    [_codeView addSubview:_codeImgView];

    [self.view addSubview:_bomView];
    
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(40);
        make.size.mas_equalTo(CGSizeMake(SCREEN_WIDTH-80, SCREEN_WIDTH-80));
        make.centerX.equalTo(self.view);
    }];
    
    [_codeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_codeView);
        make.top.equalTo(_codeView);
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
    
    
    
    [_bomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.height.equalTo(@100);
    }];
//

    
    [self decodeCodeData];
    
}




-(void)leftAction{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)rightAction{
   
//    [self decodeCodeData];
    [[NSNotificationCenter defaultCenter]postNotificationName:@"codeContent" object:_codeData];
    [self dismissViewControllerAnimated:YES completion:nil];
    
}



-(UICollectionView *)createCollectionView{
    UICollectionViewFlowLayout * layout=[[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal; //设置滚动方向
    UICollectionView *uct=[[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    //这是2017 06 26新领悟到的,只有设置最小间距为0的时候,我们设置cell宽度为屏幕四分之一时,才会一行排成4个,否者会排不下
    [layout setMinimumInteritemSpacing:0];  //设置同一行cell一行的最小间距,默认是10
    [layout setMinimumLineSpacing:0];  //设置行的间距,默认是10
    
    [uct setShowsHorizontalScrollIndicator:NO];  //隐藏滚动条
    
    //注册cell,nib注册,或者class注册
    [uct registerNib:[UINib nibWithNibName:@"CodeImgCell" bundle:nil] forCellWithReuseIdentifier:@"CodeImgCell"];
    
    uct.delegate=self;  //添加代理
    uct.dataSource=self;  //添加数据代理
    //注意这个颜色值是必须除以255.0f的,而且分子也要带0.f,因为是float类型
    uct.backgroundColor=[UIColor whiteColor];
    return uct;
}

//cell个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"----");
    return _codeImgArr.count;
}


//设置每个cell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(80, 80);   //注意,我们这里的宽度时,我们中间边距的距离只需要算一个即可,这样算出来的才会每个方向的间距都会相同
}

////设置每个cell的边距
//-( UIEdgeInsets )collectionView:( UICollectionView *)collectionView layout:( UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:( NSInteger )section
//{
//    //有几个间距就除几,比如一行四个item的话,间距就有5个
//    return UIEdgeInsetsMake ( 10 , (SCREEN_WIDTH-300)/4 , 10 ,(SCREEN_WIDTH-300)/4 );   //上,左,下,右
//}


-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CodeImgCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"CodeImgCell" forIndexPath:indexPath];
    [cell setItemData:_codeImgArr[indexPath.row]];
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSDictionary *dir=_codeImgArr[indexPath.row];
    NSString *img=[dir objectForKey:@"img"];

    
    if(ALStrEqlstr(@"wu", img)){
        [_codeData setValue:nil forKey:@"logo"];

//         UIImage *codeImage=[LCQRCodeUtil qrCodeImageWithContent:@"1111" codeImageSize:SCREEN_WIDTH-80 logo:nil logoFrame:0 Color:nil];
//        _codeImgView.image=codeImage;
        
    }else{
        
        [_codeData setValue:ALGetImage(img) forKey:@"logo"];

    }
    [self decodeCodeData];
//  [self decodeCodeData];
}

@end
