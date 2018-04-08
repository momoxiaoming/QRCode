//
//  CodeImgCell.h
//  QRCode
//
//  Created by 张小明 on 2018/4/6.
//  Copyright © 2018年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CodeImgCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *img;

@property (weak, nonatomic) IBOutlet UILabel *name;

-(void)setItemData:(NSDictionary*)imgstr;
@end
