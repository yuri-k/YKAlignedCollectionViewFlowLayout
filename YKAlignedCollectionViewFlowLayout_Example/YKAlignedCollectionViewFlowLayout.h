//
//  YKAlignedCollectionViewFlowLayout.h
//  YKAlignedCollectionViewFlowLayout_Example
//
//  Created by Yuri Kobets on 3/2/15.
//  Copyright (c) 2015 Youri Kobets. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, YKAlignmentHorizontal)
{
	YKCollectionAlignmentHorizontalLeft,
	YKCollectionAlignmentHorizontalCenter,
	YKCollectionAlignmentHorizontalRight,
	YKCollectionAlignmentHorizontalUnsupported
} YKHorizontalAlignments;

typedef NS_ENUM(NSUInteger, YKAlignmentVertical)
{
	YKCollectionAlignmentVerticalTop,
	YKCollectionAlignmentVerticalCenter,
	YKCollectionAlignmentVerticalBottom,
	YKCollectionAlignmentVerticalUnsupported
} YKVerticalAlignments;


@interface YKAlignedCollectionViewFlowLayout : UICollectionViewFlowLayout

@property (nonatomic, assign) YKAlignmentHorizontal horizontalAlignment;
@property (nonatomic, assign) YKAlignmentVertical verticalAlignment;

@end
