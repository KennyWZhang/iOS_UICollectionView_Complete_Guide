//
//  KWZCollectionViewLayoutAttributes.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 8/7/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZCollectionViewLayoutAttributes.h"

@implementation KWZCollectionViewLayoutAttributes

-(id)copyWithZone:(NSZone *)zone
{
    KWZCollectionViewLayoutAttributes *attributes = [super copyWithZone:zone];
    attributes.shouldRasterize = self.shouldRasterize;
    attributes.maskingValue = self.maskingValue;

    return attributes;
}

-(BOOL)isEqual:(KWZCollectionViewLayoutAttributes *)other
{
    return [super isEqual:other] &&
    (self.shouldRasterize == other.shouldRasterize &&
     self.maskingValue == other.maskingValue);
}

@end
