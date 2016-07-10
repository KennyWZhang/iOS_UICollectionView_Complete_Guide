//
//  KWZCollectionViewCell.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 7/10/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZCollectionViewCell.h"

//@interface KWZCollectionViewCell ()
//
//@end

@implementation KWZCollectionViewCell
{
    UIImageView *imageView;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }
    imageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    [self.contentView addSubview:imageView];

    UIView *selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectZero];
    selectedBackgroundView.backgroundColor = [UIColor orangeColor];
    self.selectedBackgroundView = selectedBackgroundView;

    return self;
}

-(void)prepareForReuse
{
    [super prepareForReuse];
    [self setImage:nil];
    [self setSelected:NO];
}

-(void)layoutSubviews
{
    imageView.frame = CGRectInset(self.bounds, 10, 10);
}

-(void)setImage:(UIImage *)image
{
    _image = image;
    imageView.image = image;
}

-(void)setDisabled:(BOOL)disabled
{
    self.contentView.alpha = disabled ? 0.5f : 1.0f;
    self.backgroundColor = disabled ? [UIColor grayColor] : [UIColor whiteColor];
}

@end
