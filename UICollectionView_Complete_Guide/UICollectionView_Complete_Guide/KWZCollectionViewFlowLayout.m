//
//  KWZCollectionViewFlowLayout.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 7/10/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZCollectionViewFlowLayout.h"

@implementation KWZCollectionViewFlowLayout

-(id)init
{
    if (!(self = [super init]))
        return nil;

    self.sectionInset = UIEdgeInsetsMake(30.0f, 80.0f, 30.0f, 20.0f);
    self.minimumInteritemSpacing = 20.0f;
    self.minimumLineSpacing = 20.0f;
    self.itemSize = kMaxItemSize;
    self.headerReferenceSize = CGSizeMake(60, 50);

    return self;
}

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (UICollectionViewLayoutAttributes *attributes in attributesArray) {
        [self applyLayoutAttributes:attributes];
    }
    return attributesArray;
}

-(UICollectionViewLayoutAttributes *) layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];

    [self applyLayoutAttributes:attributes];

    return attributes;
}

-(void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *) attributes
{
    // Check for representedElementKind being nil, indicating this is // a cell and not a header or decoration view
    if (attributes.representedElementKind == nil)
    {
        CGFloat width = [self collectionViewContentSize].width;
        CGFloat leftMargin = [self sectionInset].left;
        CGFloat rightMargin = [self sectionInset].right;
        NSUInteger itemsInSection = [[self collectionView] numberOfItemsInSection:attributes.indexPath.section];
        CGFloat firstXPosition = (width - (leftMargin + rightMargin)) / (2 * itemsInSection);
        CGFloat xPosition = firstXPosition + (2*firstXPosition*attributes.indexPath.item);
        attributes.center = CGPointMake(leftMargin + xPosition, attributes.center.y);
        attributes.frame = CGRectIntegral(attributes.frame);
    }
}

@end
