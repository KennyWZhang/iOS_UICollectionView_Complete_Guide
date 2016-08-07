//
//  ViewController.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZViewController.h"
#import "KWZCollectionViewCell.h"
#import "KWZPhotoModel.h"
#import "KWZCoverFlowFlowLayout.h"

@interface KWZViewController ()<UICollectionViewDelegateFlowLayout>

@end

@implementation KWZViewController
{
    // Array of model objects
    NSArray *photoModelArray;

    UISegmentedControl *layoutChangeSegmentedControl;

    KWZCoverFlowFlowLayout *coverFlowCollectionViewLayout;
    UICollectionViewFlowLayout *boringCollectionViewLayout;
}

// Static identifiers for cells
static NSString *CellIdentifier = @"CellIdentifier";

- (void)loadView
{
    [super viewDidLoad];

    // Create an instance of our custom flow layout.
    coverFlowCollectionViewLayout = [KWZCoverFlowFlowLayout new];

    boringCollectionViewLayout = [UICollectionViewFlowLayout new];
    boringCollectionViewLayout.itemSize = CGSizeMake(120, 120);
    boringCollectionViewLayout.minimumLineSpacing = 10.0f;
    boringCollectionViewLayout.minimumInteritemSpacing = 10.0f;
    boringCollectionViewLayout.sectionInset = UIEdgeInsetsZero;

    // Create a new collection view with our flow layout and set ourself as delegate and data source
    UICollectionView *photoCollectionView = [[UICollectionView alloc]
                                             initWithFrame:CGRectZero
                                             collectionViewLayout:boringCollectionViewLayout];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;

    // Register our classes so we can use our custom subclassed cell
    [photoCollectionView registerClass:[KWZCollectionViewCell class]
            forCellWithReuseIdentifier:CellIdentifier];

    // Set up the collection view geometry to cover the whole screen in any orientation and other view properties
    photoCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    photoCollectionView.allowsSelection = NO;
    photoCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;

    // Finally, set our collectionView (since we are a collection view controller, this also sets self.view)
    self.collectionView = photoCollectionView;

    // Set up our model
    [self setupModel];


    layoutChangeSegmentedControl = [[UISegmentedControl alloc]
                                    initWithItems:@[@"Boring",
                                                    @"Cover Flow"]];
    layoutChangeSegmentedControl.selectedSegmentIndex = 0;
//    layoutChangeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [layoutChangeSegmentedControl addTarget:self
                                     action:@selector(layoutChangeSegmentedControlDidChangeValue:)
                           forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = layoutChangeSegmentedControl;
}

-(void)layoutChangeSegmentedControlDidChangeValue:(id)sender
{
    // Change to the alternate layout
    if (layoutChangeSegmentedControl.selectedSegmentIndex == 0) {
        [self.collectionView setCollectionViewLayout:boringCollectionViewLayout
                                            animated:NO];
    } else {
        [self.collectionView setCollectionViewLayout:coverFlowCollectionViewLayout
                                            animated:NO];
    }
    // Invalidate the new layout
    [self.collectionView.collectionViewLayout invalidateLayout];
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView
                       layout:(UICollectionViewLayout *)collectionViewLayout
       insetForSectionAtIndex:(NSInteger)section
{
    if (collectionViewLayout == boringCollectionViewLayout) {
        // A basic flow layout that will accommodate three // columns in portrait
        return UIEdgeInsetsMake(10, 20, 10, 20);
    } else {
        if (UIInterfaceOrientationIsPortrait(self.interfaceOrientation)) {
            // Portrait is the same in either orientation
            return UIEdgeInsetsMake(0, 70, 0, 70); }
        else {
            // We need to get the height of the main screen to see
            // if we're running on a 4" screen. If so, we need
            // extra side padding.
            if (CGRectGetHeight([[UIScreen mainScreen] bounds]) > 480) {
                return UIEdgeInsetsMake(0, 190, 0, 190); }
            else {
                return UIEdgeInsetsMake(0, 150, 0, 150); }
        } }
}

#pragma mark - Private Custom Methods

//A handy method to implement — returns the photo model at any index path
-(KWZPhotoModel *)photoModelForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.item >= photoModelArray.count)
        return nil;

    return photoModelArray[indexPath.item];
}

//Configures a cell for a given index path
-(void)configureCell:(KWZCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    //Set the image for the cell
    [cell setImage:[[self photoModelForIndexPath:indexPath] image]];
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [photoModelArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KWZCollectionViewCell *cell = (KWZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //Configure the cell
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

-(void)setupModel
{
    photoModelArray = @[
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"1.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"2.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"3.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"4.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"5.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"6.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"7.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"8.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"9.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"10.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"11.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"12.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"13.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"17.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"15.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"14.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"16.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"18.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"19.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"21.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"21.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"22.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"23.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"24.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"25.jpg"]],
                        [KWZPhotoModel photoModelWithImage:[UIImage imageNamed:@"26.jpg"]]];
}

@end
