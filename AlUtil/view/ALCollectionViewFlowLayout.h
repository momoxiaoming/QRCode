//
//  ALCollectionViewFlowLayout.h
//  TestCollection
//
//  Created by 张小明 on 2017/11/24.
//  Copyright © 2017年 张小明. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ALCollectionViewFlowLayout : UICollectionViewFlowLayout
// 一行中 cell的个数
@property (nonatomic) NSUInteger itemCountPerRow;
// 一页显示多少行
@property (nonatomic) NSUInteger rowCount;
@end
