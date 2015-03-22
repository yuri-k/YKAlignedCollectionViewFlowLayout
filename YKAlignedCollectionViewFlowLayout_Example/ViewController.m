//
//  ViewController.m
//  YKAlignedCollectionViewFlowLayout_Example
//
//  Created by Yuri Kobets on 3/2/15.
//  Copyright (c) 2015 Youri Kobets. All rights reserved.
//

#import "ViewController.h"
#import "YKAlignedCollectionViewFlowLayout.h"

@interface ViewController () <UICollectionViewDelegate, UICollectionViewDelegate>

@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) YKAlignedCollectionViewFlowLayout *flowLayout;
@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	self.flowLayout = [YKAlignedCollectionViewFlowLayout new];

	self.flowLayout.horizontalAlignment = YKCollectionAlignmentHorizontalLeft;
	self.flowLayout.verticalAlignment = YKCollectionAlignmentVerticalTop;

	self.collectionView.collectionViewLayout = self.flowLayout;
}

- (IBAction)didChangeValueVerticalSegmentedContol:(UISegmentedControl*)segmentedControl
{
	self.flowLayout.verticalAlignment = segmentedControl.selectedSegmentIndex;
	
	[self.collectionView.collectionViewLayout invalidateLayout];
}

- (IBAction)didChangeValueHorizontalSegmentedContol:(UISegmentedControl*)segmentedControl
{
	self.flowLayout.horizontalAlignment = segmentedControl.selectedSegmentIndex;
	
	[self.collectionView.collectionViewLayout invalidateLayout];
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)aCollectionView numberOfItemsInSection:(NSInteger)aSection
{
    return 5;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)aCollectionView
	cellForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
	UICollectionViewCell *cell = [aCollectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:anIndexPath];
	
	return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)aCollectionView layout:(UICollectionViewLayout*)aCollectionViewLayout
	sizeForItemAtIndexPath:(NSIndexPath *)anIndexPath
{
	return CGSizeMake(148.0f, 126.0f);
}

#pragma mark - YKAlignedCollectionViewFlowLayoutDelegate

- (NSUInteger)numberOfColumns
{
    return 1;
}

@end
