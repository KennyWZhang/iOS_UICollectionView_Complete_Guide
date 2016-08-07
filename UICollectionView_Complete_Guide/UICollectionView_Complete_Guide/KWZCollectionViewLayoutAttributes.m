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
    attributes.layoutMode = self.layoutMode;
    return attributes;
}

-(BOOL)isEqual:(id)object
{
    return [super isEqual:object] &&
    (self.layoutMode == [object layoutMode]);
}

@end
