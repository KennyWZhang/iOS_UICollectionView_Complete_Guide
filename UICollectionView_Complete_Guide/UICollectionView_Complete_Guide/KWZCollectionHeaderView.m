//
//  KWZCollectionHeaderView.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZCollectionHeaderView.h"

@implementation KWZCollectionHeaderView
{
    UILabel *textLabel;
}

- (id)initWithFrame:(CGRect)frame
{
    if (!(self = [super initWithFrame:frame])) {
        return nil;
    }

    textLabel = [[UILabel alloc] initWithFrame:CGRectInset(CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame)),
                                                           30, 10)];
    textLabel.backgroundColor = [UIColor clearColor];
    textLabel.textColor = [UIColor whiteColor];
    textLabel.font = [UIFont boldSystemFontOfSize:20];
    textLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    [self addSubview:textLabel];
    
    return self;
}

- (void)prepareForReuse
{
    [super prepareForReuse];
    [self setText:@""];
}

-(void)setText:(NSString *)text
{
    _text = [text copy];
    [textLabel setText:text];
}

@end
