//
//  BaseTableCell.m
//  Chatt
//
//  Created by 张小明 on 2017/9/28.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import "BaseTableCell.h"
@implementation BaseTableCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setItemData:(BaseBean *)bean{}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
