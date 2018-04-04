//
//  ALColorSelectorView.m
//  QRCode
//
//  Created by 张小明 on 2018/4/3.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "ALColorSelectorView.h"

@implementation ALColorSelectorView
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

-(void)commonInit{
    
    [self initView];
    
    
}

-(void)initView{
    int max=16;
    
    NSArray *colors=[NSArray arrayWithObjects:
                     (id)[UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0] ,
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
                     (id)[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1.0] ,

                     nil];

    
    
    for (int i=0;i<max;i++){
        
//        UIColor *cor=[UIColor colorWithRed:0 green:1 blue:0 alpha:1];
        CGRect rect=CGRectMake(self.bounds.size.width/max*i, 0, self.bounds.size.width/max, self.bounds.size.height);
        UIView *item=[[UIView alloc]initWithFrame:rect];
//        item.backgroundColor=cor;
//        if(i<6){
//
//        }
        item.backgroundColor=colors[i];

        [self addSubview:item];
    }
    
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
