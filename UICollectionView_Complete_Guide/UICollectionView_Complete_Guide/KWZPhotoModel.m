//
//  KWZPhotoModel.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZPhotoModel.h"

@implementation KWZPhotoModel

+(instancetype)photoModelWithName:(NSString *)name image:(UIImage *)image
{
    KWZPhotoModel *model = [[KWZPhotoModel alloc] init];

    model.name = name;
    model.image = image;

    return model;
}

@end
