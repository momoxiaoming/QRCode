//
//  ColorAlertView.h
//  QRCode
//
//  Created by 张小明 on 2018/4/4.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^colorBlcok)(NSInteger index,UIColor*color);
@interface ColorAlertView : UIView

@property (nonatomic,strong)NSArray *colors;

@property (nonatomic,strong)colorBlcok colorBlock;

@property (nonatomic,assign)BOOL isShow;

@property (nonatomic,assign)NSInteger index;


-(void)initData:(colorBlcok)block;
-(void)hidenAlertView;
-(void)showAlert:(NSInteger)index;
@end
