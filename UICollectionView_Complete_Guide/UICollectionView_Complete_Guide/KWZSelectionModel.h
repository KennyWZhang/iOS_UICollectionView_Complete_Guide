//
//  KWZSectionModel.h
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 7/10/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSUInteger AFSelectionModelNoSelectionIndex;

@interface KWZSelectionModel : NSObject

+(instancetype)selectionModelWithPhotoModels:(NSArray *)photoModels;

@property (nonatomic, strong, readonly) NSArray *photoModels;
@property (nonatomic, assign) NSUInteger selectedPhotoModelIndex;
@property (nonatomic, readonly) BOOL hasBeenSelected;

@end
