//
//  BaseViewController.h
//  QsQ
//
//  Created by 张小明 on 2017/3/25.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

//子类需要实现的代理
@protocol initViewController <NSObject>
@required
-(void)initView;   //这里主要用于初始化一些布局
@required
-(void)initData;   //主要用于子类初始化数据

@end
typedef void(^clickEmoryBolck)(void);



@interface BaseViewController : UIViewController<initViewController>
@property (nonatomic,strong) clickEmoryBolck block;
@property (nonatomic,strong) UITableView *table;



/**
 弹出只有确定按钮的提示窗

 @param title 标题
 */
-(void)showAlertCon:(NSString *)title;

-(void)showAlertCon:(NSString *)title block:(void(^)(void))block;

-(void)showAlertCon:(NSString *)title left:(NSString *)lefttitle leftblock:(void(^)(void))leftblock right:(NSString *)righttitle rgihtblock:(void(^)(void))rightblock;


-(void)setHideNavbar:(BOOL)isf;


/**
 跳转到栈中某个页面

 */
-(void)goStackController:(NSInteger)index animation:(BOOL)bo;
-(void)goNextController:(UIViewController *)controller;

-(void)ppController:(UIViewController *)controller animation:(BOOL)bo;


/**
 显示进度窗

 @param msg 进度窗的显示的文字,为nil时默认显示
 */
-(void)showProgress:(NSString *)msg;

-(void)hideProgress;

/**
 显示错误弹窗

 @param msg 错误的内容
 */
-(void)showErrorMB:(NSString *)msg;
-(void)showSucessMB:(NSString *)msg;


-(void)back;

-(void)showEmoryView:(NSString *)str img:(UIImage *)err_img block:(clickEmoryBolck)block;

-(void)showEmoryView:(NSString *)str block:(clickEmoryBolck)block;

-(void)hidenEmoryView;
@end
