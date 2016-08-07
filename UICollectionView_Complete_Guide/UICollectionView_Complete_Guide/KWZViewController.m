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
#import "KWZCollectionViewFlowLayout.h"

@interface KWZViewController ()<UICollectionViewDelegate,
                                UICollectionViewDataSource,
                                UICollectionViewDelegateFlowLayout>

@end

@implementation KWZViewController
{
    // Array of model objects
    NSArray *photoModelArray;

    UISegmentedControl *aspectChangeSegmentedControl;

    KWZCollectionViewFlowLayout *photoCollectionViewLayout;
}

// Static identifiers for cells
static NSString *CellIdentifier = @"CellIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Create an instance of our custom flow layout.
    photoCollectionViewLayout = [KWZCollectionViewFlowLayout new];

    // Create a new collection view with our flow layout and set ourself as delegate and data source
    UICollectionView *photoCollectionView = [[UICollectionView alloc]
                                             initWithFrame:CGRectZero
                                             collectionViewLayout:photoCollectionViewLayout];
    photoCollectionView.dataSource = self;
    photoCollectionView.delegate = self;

    // Register our classes so we can use our custom subclassed cell
    [photoCollectionView registerClass:[KWZCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];

    // Set up the collection view geometry to cover the whole screen in any orientation and other view properties
    photoCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    photoCollectionView.allowsSelection = NO;
    photoCollectionView.indicatorStyle = UIScrollViewIndicatorStyleWhite;

    // Finally, set our collectionView (since we are a collection view controller, this also sets self.view)
    self.view = photoCollectionView;

    // Set up our model
    [self setupModel];


    aspectChangeSegmentedControl = [[UISegmentedControl alloc]
                                    initWithItems:@[@"Aspect Fit",
                                                    @"Aspect Fill"]];
    aspectChangeSegmentedControl.selectedSegmentIndex = 0;
//    aspectChangeSegmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    [aspectChangeSegmentedControl addTarget:self
                                     action:@selector(aspectChangeSegmentedControlDidChangeValue:)
                           forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = aspectChangeSegmentedControl;
}

-(void)aspectChangeSegmentedControlDidChangeValue:(id)sender
{
    // We need to explicitly tell the collection view layout that we want the change animated.
    [UIView animateWithDuration:0.5f animations:^{
        // This just swaps the two values

        if (photoCollectionViewLayout.layoutMode == KWZCollectionViewFlowLayoutModeAspectFill)
        {
            photoCollectionViewLayout.layoutMode = KWZCollectionViewFlowLayoutModeAspectFit;
        }
        else
        {
            photoCollectionViewLayout.layoutMode = KWZCollectionViewFlowLayoutModeAspectFill;
        }
    }];
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
                        [KWZPhotoModel photoModelWithName:@"Purple Flower" image:[UIImage imageNamed:@"0.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"WWDC Hypertable" image:[UIImage imageNamed:@"1.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Purple Flower II" image:[UIImage imageNamed:@"2.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Castle" image:[UIImage imageNamed:@"3.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Skyward Look" image:[UIImage imageNamed:@"4.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Kakabeka Falls" image:[UIImage imageNamed:@"5.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Puppy" image:[UIImage imageNamed:@"6.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Thunder Bay Sunset" image:[UIImage imageNamed:@"7.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Sunflower I" image:[UIImage imageNamed:@"8.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Sunflower II" image:[UIImage imageNamed:@"9.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Sunflower I" image:[UIImage imageNamed:@"10.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Squirrel" image:[UIImage imageNamed:@"11.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Montréal Subway" image:[UIImage imageNamed:@"12.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Geometrically Intriguing Flower" image:[UIImage imageNamed:@"13.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Grand Lake" image:[UIImage imageNamed:@"17.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Spadina Subway Station" image:[UIImage imageNamed:@"15.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Staircase to Grey" image:[UIImage imageNamed:@"14.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Saint John River" image:[UIImage imageNamed:@"16.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Purple Bokeh Flower" image:[UIImage imageNamed:@"18.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Puppy II" image:[UIImage imageNamed:@"19.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Plant" image:[UIImage imageNamed:@"21.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Peggy's Cove I" image:[UIImage imageNamed:@"21.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Peggy's Cove II" image:[UIImage imageNamed:@"22.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Sneaky Cat" image:[UIImage imageNamed:@"23.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"King Street West" image:[UIImage imageNamed:@"24.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"TTC Streetcar" image:[UIImage imageNamed:@"25.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"UofT at Night" image:[UIImage imageNamed:@"26.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Mushroom" image:[UIImage imageNamed:@"27.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"Montréal Subway Selective Colour" image:[UIImage imageNamed:@"28.jpg"]],
                        [KWZPhotoModel photoModelWithName:@"On Air" image:[UIImage imageNamed:@"29.jpg"]]];
}

@end
