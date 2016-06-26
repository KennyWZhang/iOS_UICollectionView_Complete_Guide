//
//  KWZSectionModel.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 7/10/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZSelectionModel.h"

const NSUInteger AFSelectionModelNoSelectionIndex = -1;

@interface KWZSelectionModel ()

@property (nonatomic, strong) NSArray *photoModels;

@end

@implementation KWZSelectionModel

+(instancetype)selectionModelWithPhotoModels:(NSArray *)photoModels
{
    KWZSelectionModel *model = [[KWZSelectionModel alloc] init];

    model.photoModels = photoModels;
    model.selectedPhotoModelIndex = AFSelectionModelNoSelectionIndex;

    return model;
}

-(BOOL)hasBeenSelected
{
    return self.selectedPhotoModelIndex != AFSelectionModelNoSelectionIndex;
}

@end
