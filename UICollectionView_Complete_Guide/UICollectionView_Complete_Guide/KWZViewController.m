//
//  ViewController.m
//  UICollectionView_Complete_Guide
//
//  Created by Zhangwei on 6/26/16.
//  Copyright © 2016 ZhangWei_Kenny. All rights reserved.
//

#import "KWZViewController.h"
#import "KWZCollectionHeaderView.h"
#import "KWZCollectionViewCell.h"
#import "KWZPhotoModel.h"
#import "KWZSelectionModel.h"

@interface KWZViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation KWZViewController
{
    //Array of selection objects
    NSArray *selectionModelArray;
    //Our current index within the selectionModelArray
    NSUInteger currentModelArrayIndex;
    //Whether or not we've completed the survey
    BOOL isFinished;
}

//Not technically required, but useful
#define kMaxItemSize CGSizeMake(200, 200)

//Static identifiers for cells and supplementary views
static NSString *CellIdentifier = @"CellIdentifier";
static NSString *HeaderIdentifier = @"HeaderIdentifier";

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Create our view
    //Create a basic flow layout that will accomodate three columns in portrait
    UICollectionViewFlowLayout *surveyFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    surveyFlowLayout.sectionInset = UIEdgeInsetsMake(30.0f, 80.0f, 30.0f, 20.0f);
    surveyFlowLayout.minimumInteritemSpacing = 20.0f;
    surveyFlowLayout.minimumLineSpacing = 20.0f;
    surveyFlowLayout.itemSize = kMaxItemSize;
    surveyFlowLayout.headerReferenceSize = CGSizeMake(60, 50);

    //Create a new collection view with our flow layout and set ourself as delegate and data source
    UICollectionView *surveyCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:surveyFlowLayout];
    surveyCollectionView.dataSource = self;
    surveyCollectionView.delegate = self;

    //Register our classes so we can use our custom subclassed cell and header
    [surveyCollectionView registerClass:[KWZCollectionViewCell class] forCellWithReuseIdentifier:CellIdentifier];
    [surveyCollectionView registerClass:[KWZCollectionHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:HeaderIdentifier];

    //Set up the collection view geometry to cover the whole screen in any orientation and other view properties
    surveyCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    surveyCollectionView.opaque = NO;
    surveyCollectionView.backgroundColor = [UIColor blackColor];

    //Finally, set our collectionView (since we are a collection view controller, this also sets self.view)
    self.view = surveyCollectionView;

    //Set up our model
    [self setupModel];

    //We start at zero
    currentModelArrayIndex = 0;
}

#pragma mark - Private Custom Methods

//A handy method to implement — returns the photo model at any index path
-(KWZPhotoModel *)photoModelForIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section >= selectionModelArray.count) return nil;
    if (indexPath.row >= [[selectionModelArray[indexPath.section] photoModels] count]) return nil;

    return [selectionModelArray[indexPath.section] photoModels][indexPath.item];
}

//Configures a cell for a given index path
-(void)configureCell:(KWZCollectionViewCell *)cell forIndexPath:(NSIndexPath *)indexPath
{
    //Set the image for the cell
    [cell setImage:[[self photoModelForIndexPath:indexPath] image]];

    //By default, assume the cell is not disabled and not selected
    [cell setDisabled:NO];
    [cell setSelected:NO];

    //If the cell is not in our current last index, disable it
    if (indexPath.section < currentModelArrayIndex)
    {
        [cell setDisabled:YES];

        //If the cell was selected by the user previously, select it now
        if (indexPath.row == [selectionModelArray[indexPath.section] selectedPhotoModelIndex])
        {
            [cell setSelected:YES];
        }
    }
}

#pragma mark - UICollectionViewDataSource

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    // Return the smallest of either our current model index plus one,
    // or our total number of sections. This will show 1 section when we // only want to display section zero, etc.
    // It will prevent us from returning 11 when we only have 10 sections.
    return MIN(currentModelArrayIndex + 1, selectionModelArray.count);
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //Return the number of photos in the section model
    return [[selectionModelArray[currentModelArrayIndex] photoModels] count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    KWZCollectionViewCell *cell = (KWZCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
    //Configure the cell
    [self configureCell:cell forIndexPath:indexPath];
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout Methods

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //Provides a different size for each invidual cell

    //Grab the photo model for the cell
    KWZPhotoModel *photoModel = [self photoModelForIndexPath:indexPath];

    //Determine the size and aspect ratio for the model's image
    CGSize photoSize = photoModel.image.size;
    CGFloat aspectRatio = photoSize.width / photoSize.height;

    //start out with the detail image size of the maximum size
    CGSize itemSize = kMaxItemSize;

    if (aspectRatio < 1)
    {
        //The photo is taller than it is wide, so constrain the width
        itemSize = CGSizeMake(kMaxItemSize.width * aspectRatio, kMaxItemSize.height);
    }
    else if (aspectRatio > 1)
    {
        //The photo is wider than it is tall, so constrain the height
        itemSize = CGSizeMake(kMaxItemSize.width, kMaxItemSize.height / aspectRatio);
    }

    return itemSize;
}

#pragma mark - Header

-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    //Provides a view for the headers in the collection view
    KWZCollectionHeaderView *headerView = (KWZCollectionHeaderView *)[collectionView
                                                                      dequeueReusableSupplementaryViewOfKind:kind
                                                                      withReuseIdentifier:HeaderIdentifier
                                                                      forIndexPath:indexPath];
    if (indexPath.section == 0) {
        //If this is the first header, display a prompt to the user
        [headerView setText:@"Tap on a photo to start the recommendation engine."];
    } else if (indexPath.section <= currentModelArrayIndex) {
        //Otherwise, display a prompt using the selected photo from the previous section
        KWZSelectionModel *selectionModel = selectionModelArray[indexPath.section - 1];
        KWZPhotoModel *selectedPhotoModel = [self photoModelForIndexPath:[NSIndexPath
                                                                         indexPathForItem:selectionModel.selectedPhotoModelIndex
                                                                         inSection:indexPath.section - 1]];
        [headerView setText:[NSString stringWithFormat:@"Because you liked %@...", selectedPhotoModel.name]];
    }

    return headerView;
}

#pragma mark - Interaction

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    //The user has selected a cell

    //No matter what, deselect that cell
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];

    if (currentModelArrayIndex >= selectionModelArray.count - 1) {
        //Let’s just present some dialogue to indicate things are done.
        [[[UIAlertView alloc] initWithTitle:@"Recommendation Engine"
                                    message:@"Based on your selections, we have concluded you have excellent taste in photography!"
                                   delegate:nil
                          cancelButtonTitle:nil
                          otherButtonTitles:@"Awesome!", nil] show];
        return;
    }

    //Set the selected photo index
    [selectionModelArray[currentModelArrayIndex] setSelectedPhotoModelIndex:indexPath.item];
    [collectionView performBatchUpdates:^{
        currentModelArrayIndex++;
        [collectionView insertSections:[NSIndexSet
                                        indexSetWithIndex:currentModelArrayIndex]];
        [collectionView reloadSections:[NSIndexSet indexSetWithIndex:currentModelArrayIndex-1]];
    } completion:^(BOOL finished) {
            [collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:currentModelArrayIndex]
                                   atScrollPosition:UICollectionViewScrollPositionTop animated:YES];
    }];
}

-(BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    return indexPath.section == currentModelArrayIndex && !isFinished;
}

-(void)setupModel
{
    NSMutableArray *mutableArray = [NSMutableArray array];

    [mutableArray addObjectsFromArray:@[[KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Purple Flower" image:[UIImage imageNamed:@"0.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"WWDC Hypertable" image:[UIImage imageNamed:@"1.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Purple Flower II" image:[UIImage imageNamed:@"2.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Castle" image:[UIImage imageNamed:@"3.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Skyward Look" image:[UIImage imageNamed:@"4.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Kakabeka Falls" image:[UIImage imageNamed:@"5.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Puppy" image:[UIImage imageNamed:@"6.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Thunder Bay Sunset" image:[UIImage imageNamed:@"7.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"SUnflower I" image:[UIImage imageNamed:@"8.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Sunflower II" image:[UIImage imageNamed:@"9.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Sunflower I" image:[UIImage imageNamed:@"10.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Squirrel" image:[UIImage imageNamed:@"11.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Montréal Subway" image:[UIImage imageNamed:@"12.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Geometrically Intriguing Flower" image:[UIImage imageNamed:@"13.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Grand Lake" image:[UIImage imageNamed:@"17.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Spadina Subway Station" image:[UIImage imageNamed:@"15.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Staircase to Grey" image:[UIImage imageNamed:@"14.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Saint John River" image:[UIImage imageNamed:@"16.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Purple Bokeh Flower" image:[UIImage imageNamed:@"18.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Puppy II" image:[UIImage imageNamed:@"19.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Plant" image:[UIImage imageNamed:@"21.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Peggy's Cove I" image:[UIImage imageNamed:@"21.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Peggy's Cove II" image:[UIImage imageNamed:@"22.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Sneaky Cat" image:[UIImage imageNamed:@"23.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"King Street West" image:[UIImage imageNamed:@"24.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"TTC Streetcar" image:[UIImage imageNamed:@"25.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"UofT at Night" image:[UIImage imageNamed:@"26.jpg"]]]],
                                        [KWZSelectionModel
                                         selectionModelWithPhotoModels:@[
                                                                         [KWZPhotoModel photoModelWithName:@"Mushroom" image:[UIImage imageNamed:@"27.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"Montréal Subway Selective Colour" image:[UIImage imageNamed:@"28.jpg"]],
                                                                         [KWZPhotoModel photoModelWithName:@"On Air" image:[UIImage imageNamed:@"29.jpg"]]]]]];
    
    selectionModelArray = [NSArray arrayWithArray:mutableArray];
}

@end
