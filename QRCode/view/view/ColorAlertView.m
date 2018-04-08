//
//  ColorAlertView.m
//  QRCode
//
//  Created by 张小明 on 2018/4/4.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "ColorAlertView.h"

@implementation ColorAlertView

-(instancetype)initWithFrame:(CGRect)frame{
    
    self=[super initWithFrame:frame];
    if(self){
        [self initData];
    }
    return self;
}

-(void)initData{
    _isShow=false;
    _colors=[NSArray arrayWithObjects:
             (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ,
             
             (id)[UIColor colorWithRed:1.0 green:0.0 blue:0.0 alpha:1.0] ,
             (id)[UIColor colorWithRed:0.5 green:0.0 blue:0.0 alpha:1.0] ,
             
             (id)[UIColor colorWithRed:0.0 green:1.0 blue:0.0 alpha:1.0],
             (id)[UIColor colorWithRed:0.0 green:0.5 blue:0.0 alpha:1.0],
             
             (id)[UIColor colorWithRed:0.0 green:0.0 blue:1.0 alpha:1.0] ,
             (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.5 alpha:1.0] ,
             
             (id)[UIColor colorWithRed:1.0 green:1.0 blue:0.0 alpha:1.0],
             (id)[UIColor colorWithRed:0.5 green:0.5 blue:0.0 alpha:1.0],
             
             (id)[UIColor colorWithRed:1.0 green:0.0 blue:1.0 alpha:1.0] ,
             (id)[UIColor colorWithRed:0.5 green:0.0 blue:0.5 alpha:1.0] ,
             
             (id)[UIColor colorWithRed:0.0 green:1.0 blue:1.0 alpha:1.0] ,
             (id)[UIColor colorWithRed:0.0 green:0.5 blue:0.5 alpha:1.0] ,
             
             (id)[UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0] ,
             //                     (id)[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] ,
             //                     (id)[UIColor colorWithRed:0.3 green:0 blue:0 alpha:1.0] ,
             
             nil];
}

-(void)initData:(colorBlcok)block{
//    [self initData];
    _colorBlock=block;
   
}
    



-(void)showAlert:(NSInteger)index{
    _index=index;
    
    if(_isShow){
        [self hidenAlertView];
    }
    
    [UIView animateWithDuration:0.2 animations:^{
        [self setHidden:NO];
        //显示在下方
        _isShow=true;
    }];
    
    
}


-(void)hidenAlertView{
    //显示在下方
    [UIView animateWithDuration:0.2 animations:^{
        [self setHidden:YES];
        _isShow=false;
        
    }];
    
}



-(void)initView{
    

    
    [self setHidden:YES];
    
    self.backgroundColor=[UIColor colorWithHexString:@"#000000" alpha:0.7];
    ALViewBorderRadius(self, 8, 1, BaseColor);
    for(int i=0;i<_colors.count;i++){
        if(i<(_colors.count/2)){
            
            
            
            UIView *item=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/(_colors.count/2)*i, 0, self.frame.size.width/(_colors.count/2), self.frame.size.height/2)];

            
            UIView *colorView=[[UIView alloc]init];
         
            colorView.backgroundColor=_colors[i];
            [item addSubview:colorView];
            [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(item);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            
            ALViewRadius(colorView, 15);
            [self addSubview:item];
            [self setListener:item index:i];
        }else{
            UIView *item=[[UIView alloc]initWithFrame:CGRectMake(self.frame.size.width/(_colors.count/2)* (i-(_colors.count/2)), self.frame.size.height/2, self.frame.size.width/(_colors.count/2), self.frame.size.height/2)];
            
            
            UIView *colorView=[[UIView alloc]init];
            
            colorView.backgroundColor=_colors[i];
            [item addSubview:colorView];
            [colorView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.center.equalTo(item);
                make.size.mas_equalTo(CGSizeMake(30, 30));
            }];
            
            ALViewRadius(colorView, 15);
            [self addSubview:item];
            [self setListener:item index:i];
        }
        
        
        
    }
    
    
    
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
    
    _colorBlock(_index,_colors[index]);
    
    [self hidenAlertView];
}

//要是布局控件，必须在这里面写他的位置
- (void)layoutSubviews{
    //假如我们view中还有其他控件,在这个方法中添加
     [self initView];
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
