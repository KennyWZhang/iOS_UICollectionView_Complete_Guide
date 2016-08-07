//
//  KWZCollectionViewFlowLayout.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 7/10/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZCollectionViewFlowLayout.h"

@implementation KWZCollectionViewFlowLayout

-(id)init {
    if (!(self = [super init]))
        return nil;
    // Some basic setup. 140+140 + 3*13 ~= 320, so we can get a
    // two-column grid in portrait orientation.
    self.itemSize = kMaxItemSize;
    self.sectionInset = UIEdgeInsetsMake(13.0f, 13.0f, 13.0f, 13.0f);
    self.minimumInteritemSpacing = 13.0f;
    self.minimumLineSpacing = 13.0f;
    return self;
}

-(void)applyLayoutAttributes:(KWZCollectionViewLayoutAttributes *)attributes {
    // Check for representedElementKind being nil, indicating this
    // is a cell and not a header or decoration view
    if (attributes.representedElementKind == nil)
    {
        // Pass our layout mode onto the layout attributes
        attributes.layoutMode = self.layoutMode;
        if ([self.collectionView.delegate respondsToSelector:@selector(collectionView:layout:layoutModeForItemAtIndexPath:)])
        {
            attributes.layoutMode = [(id<KWZCollectionViewDelegateFlowLayout>)self.collectionView.delegate
                                     collectionView:self.collectionView
                                     layout:self
                                     layoutModeForItemAtIndexPath:attributes.indexPath];
        }
    }
}

#pragma mark - Cell Layout

-(NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray *attributesArray = [super layoutAttributesForElementsInRect:rect];
    for (KWZCollectionViewLayoutAttributes *attributes in attributesArray) {
        [self applyLayoutAttributes:attributes];
    }
    return attributesArray;
}

-(UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath: (NSIndexPath *)indexPath
{
    KWZCollectionViewLayoutAttributes *attributes = (KWZCollectionViewLayoutAttributes *)[super layoutAttributesForItemAtIndexPath:indexPath];
    [self applyLayoutAttributes:attributes];
    return attributes;
}

+(Class)layoutAttributesClass {
    return [KWZCollectionViewLayoutAttributes class];
}

-(void)setLayoutMode:(KWZCollectionViewFlowLayoutMode)layoutMode {
    // Update our backing ivar...
    _layoutMode = layoutMode;
    // then invalidate our layout.
    [self invalidateLayout];
}

@end
