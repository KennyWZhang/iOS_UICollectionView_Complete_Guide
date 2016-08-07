//
//  KWZCollectionViewLayoutAttributes.h
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 8/7/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    KWZCollectionViewFlowLayoutModeAspectFit,    //Default
    KWZCollectionViewFlowLayoutModeAspectFill
}KWZCollectionViewFlowLayoutMode;

@interface KWZCollectionViewLayoutAttributes : UICollectionViewLayoutAttributes

@property (nonatomic, assign) KWZCollectionViewFlowLayoutMode layoutMode;

@end
