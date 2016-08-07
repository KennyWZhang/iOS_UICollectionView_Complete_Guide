//
//  KWZPhotoModel.h
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface KWZPhotoModel : NSObject

+(instancetype)photoModelWithImage:(UIImage *)image;

@property (nonatomic, strong) UIImage *image;

@end

