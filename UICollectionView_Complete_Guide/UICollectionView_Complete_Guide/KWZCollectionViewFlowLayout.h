//
//  KWZCollectionViewFlowLayout.h
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 7/10/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "KWZCollectionViewLayoutAttributes.h"

#define kMaxItemDimension 140
#define kMaxItemSize CGSizeMake(kMaxItemDimension, kMaxItemDimension)


@protocol KWZCollectionViewDelegateFlowLayout <UICollectionViewDelegateFlowLayout>

@optional
-(KWZCollectionViewFlowLayoutMode)collectionView:(UICollectionView *)collectionView
                                         layout:(UICollectionViewLayout*)collectionViewLayout
                   layoutModeForItemAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface KWZCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) KWZCollectionViewFlowLayoutMode layoutMode;

@end
