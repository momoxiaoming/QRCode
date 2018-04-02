//
//  BaseTableCell.h
//  Chatt
//
//  Created by 张小明 on 2017/9/28.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseBean.h"
@protocol TableCellDelete <NSObject>
@required
-(void)setItemData:(BaseBean*)bean;

@end
@interface BaseTableCell : UITableViewCell<TableCellDelete>

@end
