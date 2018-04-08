//
//  CodeImgCell.m
//  QRCode
//
//  Created by 张小明 on 2018/4/6.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import "CodeImgCell.h"

@implementation CodeImgCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setItemData:(NSDictionary *)imgstr{
    
    NSString *name=[imgstr objectForKey:@"name"];
    NSString *imgName=[imgstr objectForKey:@"img"];

    
    _img.image=ALGetImage(imgName);
    _name.text=name;
}
@end
