# YKAlignedCollectionViewFlowLayout
UICollectViewFlowLayout which aligns cells horizontally and vertically

```
	YKAlignedCollectionViewFlowLayout *flowLayout = [YKAlignedCollectionViewFlowLayout new];

	self.flowLayout.horizontalAlignment = YKCollectionAlignmentHorizontalLeft;
	self.flowLayout.verticalAlignment = YKCollectionAlignmentVerticalTop;

	self.collectionView.collectionViewLayout = self.flowLayout;
```
Available aligment options:
```
YKAlignmentHorizontal:
	YKCollectionAlignmentHorizontalLeft,
	YKCollectionAlignmentHorizontalCenter,
	YKCollectionAlignmentHorizontalRight,
	YKCollectionAlignmentHorizontalUnsupported

YKAlignmentVertical:
	YKCollectionAlignmentVerticalTop,
	YKCollectionAlignmentVerticalCenter,
	YKCollectionAlignmentVerticalBottom,
	YKCollectionAlignmentVerticalUnsupported
```
