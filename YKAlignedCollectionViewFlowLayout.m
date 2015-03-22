//
//  YKAlignedCollectionViewFlowLayout.m
//  YKAlignedCollectionViewFlowLayout_Example
//
//  Created by Yuri Kobets on 3/2/15.
//  Copyright (c) 2015 Youri Kobets. All rights reserved.
//

#import "YKAlignedCollectionViewFlowLayout.h"

void *YKContext = &YKContext;

@implementation YKAlignedCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
	NSMutableArray *layoutAttributes = [[super layoutAttributesForElementsInRect:rect] mutableCopy];

	NSMutableDictionary *rowsDictionary = [NSMutableDictionary new];

	for (UICollectionViewLayoutAttributes *itemAttributes in layoutAttributes)
	{
		NSNumber *yCenter = @(CGRectGetMidY(itemAttributes.frame));

		if (!rowsDictionary[yCenter]) {
			rowsDictionary[yCenter] = [NSMutableArray new];
		}
		
		[rowsDictionary[yCenter] addObject:itemAttributes];
	}
	
	[rowsDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {

		NSArray *itemsRowArray = obj;
		CGFloat sumInteritemSpacing = self.minimumInteritemSpacing * (itemsRowArray.count-1);

		CGFloat sumItemWidths = 0.f;
		for (UICollectionViewLayoutAttributes *itemAttributes in itemsRowArray) {
			sumItemWidths += CGRectGetWidth(itemAttributes.frame);
		}
		
		switch (self.horizontalAlignment) {
		  	case YKCollectionAlignmentHorizontalCenter:
			{
				CGFloat alignmentWidth = sumItemWidths + sumInteritemSpacing;
				CGFloat alignmentXOffset = (CGRectGetWidth(self.collectionView.bounds) - alignmentWidth) / 2.f;

				CGRect previousFrame = CGRectZero;
				for (UICollectionViewLayoutAttributes *itemAttributes in itemsRowArray)
				{
					CGRect itemFrame = itemAttributes.frame;
	
					if (CGRectEqualToRect(previousFrame, CGRectZero)) {
						itemFrame.origin.x = alignmentXOffset;
					} else {
						itemFrame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;
					}
					
					itemAttributes.frame = itemFrame;
					previousFrame = itemFrame;
				}
			}
			break;

			case YKCollectionAlignmentHorizontalLeft:
			{
				CGRect previousFrame = CGRectZero;
				for (UICollectionViewLayoutAttributes *itemAttributes in itemsRowArray)
				{
					CGRect itemFrame = itemAttributes.frame;
	
					CGFloat spacing = CGRectEqualToRect(previousFrame, CGRectZero) ? 0 : self.minimumInteritemSpacing;
					itemFrame.origin.x = CGRectGetMaxX(previousFrame) + spacing;

					itemAttributes.frame = itemFrame;
					previousFrame = itemFrame;
				}
			}
			break;

			case YKCollectionAlignmentHorizontalRight:
			{
				CGFloat alignmentWidth = sumItemWidths + sumInteritemSpacing;
				CGFloat alignmentXOffset = CGRectGetWidth(self.collectionView.bounds) - alignmentWidth;
				
				CGRect previousFrame = CGRectZero;
				for (UICollectionViewLayoutAttributes *itemAttributes in itemsRowArray)
				{
					CGRect itemFrame = itemAttributes.frame;
						
					if (CGRectEqualToRect(previousFrame, CGRectZero)) {
    					itemFrame.origin.x = alignmentXOffset;
					} else {
						itemFrame.origin.x = CGRectGetMaxX(previousFrame) + self.minimumInteritemSpacing;
					}
					
					itemAttributes.frame = itemFrame;
					previousFrame = itemFrame;
				}
			}
			break;
			
			default:
			break;
		}
	}];
	
	if ([self.collectionView.collectionViewLayout isKindOfClass:[self class]]) {
		[(__typeof(self))self.collectionView.collectionViewLayout
			setSectionInset:[self sectionInsetWithAttributes:layoutAttributes]];
	}

	return layoutAttributes;
}

- (UIEdgeInsets)sectionInsetWithAttributes:(NSArray *)layoutAttributes
{
	switch (_verticalAlignment) {
		case YKCollectionAlignmentVerticalTop:
		case YKCollectionAlignmentVerticalUnsupported:
		{
			return UIEdgeInsetsZero;
		}
		break;
		
		case YKCollectionAlignmentVerticalCenter:
		{
			return [self centerInsetWithAttributes:layoutAttributes];
		}
		break;
		
		case YKCollectionAlignmentVerticalBottom:
		{
			return [self bottomInsetWithAttributes:layoutAttributes];
		}
		break;
		
		default:
		break;
	}
	
	return UIEdgeInsetsZero;
}

- (UIEdgeInsets)centerInsetWithAttributes:(NSArray *)layoutAttributes
{
	NSMutableDictionary *rowsDictionary = [[self rowsWithCellsDictionaryForAttributes:layoutAttributes] mutableCopy];
	
	CGFloat heightOfRows = [self heightOfCellsContentWithAttributes:layoutAttributes];

	CGRect frame = self.collectionView.frame;
	
	CGFloat sumLineSpacing = self.minimumLineSpacing * (rowsDictionary.allKeys.count-1);

	CGFloat topIndent = 0;
	
	if (heightOfRows < frame.size.height) {
		topIndent = (frame.size.height - heightOfRows - sumLineSpacing)/2;
	}
	
	return UIEdgeInsetsMake(topIndent, 0, 0, 0);
}

- (UIEdgeInsets)bottomInsetWithAttributes:(NSArray *)layoutAttributes
{
	NSMutableDictionary *rowsDictionary = [[self rowsWithCellsDictionaryForAttributes:layoutAttributes] mutableCopy];
	
	CGFloat heightOfRows = [self heightOfCellsContentWithAttributes:layoutAttributes];

	CGRect frame = self.collectionView.frame;
	
	CGFloat sumLineSpacing = self.minimumLineSpacing * (rowsDictionary.allKeys.count-1);

	CGFloat topIndent = frame.size.height - heightOfRows - sumLineSpacing;
	
	return UIEdgeInsetsMake(topIndent, 0, 0, 0);
}

- (NSDictionary*)rowsWithCellsDictionaryForAttributes:(NSArray *)layoutAttributes
{
	NSMutableDictionary *rowsDictionary = [NSMutableDictionary new];

	for (UICollectionViewLayoutAttributes *itemAttributes in layoutAttributes)
  	{
		NSNumber *yCenter = @(CGRectGetMidY(itemAttributes.frame));

		if (!rowsDictionary[yCenter]) {
			rowsDictionary[yCenter] = [NSMutableArray new];
		}
		
		[rowsDictionary[yCenter] addObject:itemAttributes];
	}
	
	return rowsDictionary;
}

- (CGFloat)heightOfCellsContentWithAttributes:(NSArray *)layoutAttributes
{
	NSMutableDictionary *rowsDictionary = [[self rowsWithCellsDictionaryForAttributes:layoutAttributes] mutableCopy];
	
	__block CGFloat heightOfRows = 0.0f;
	[rowsDictionary enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
		NSArray *itemsRowArray = obj;
		
		CGFloat heightOfRow = 0.0f;
		for (UICollectionViewLayoutAttributes *itemAttributes in itemsRowArray)
		{
			heightOfRow = MAX(CGRectGetHeight(itemAttributes.frame), heightOfRow);
		}
		
		heightOfRows += heightOfRow;
	}];

	return heightOfRows;
}

@end
