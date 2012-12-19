//
//  TPTCoverFlowLayout.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "TPTCoverFlowLayout.h"

// If we decide to make this vertical we could use these macros to help make it painless...
//#define XORY(axis, point) ((axis) ? (point.y) : (point.x))
//#define WORH(axis, size) ((axis) ? (size.height) : (size.width))

#define ZOOM_FACTOR  0.3f
#define ALPHA_FACTOR 0.7f

@interface TPTCoverFlowLayout ()

@property (readwrite, nonatomic, strong) NSIndexPath *currentIndexPath;
@property (readwrite, nonatomic, assign) CGFloat centerOffset;
@property (readwrite, nonatomic, assign) NSInteger cellCount;

@end

@implementation TPTCoverFlowLayout

- (id)init
{
    if ((self = [super init]) != NULL)
	{
		[self setup];
	}
    return self;
}

- (void)awakeFromNib
{
	[self setup];
}

- (void)setup
{
    self.cellSize = (CGSize){ 250.0f, 250.0f };
    self.cellSpacing = 250.0f;
}

- (void)prepareLayout
{
    [super prepareLayout];
	
	self.centerOffset = (self.collectionView.bounds.size.width - self.cellSpacing) * 0.5f;
    self.cellCount = [self.collectionView numberOfItemsInSection:0];
}

- (BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)oldBounds
{
    return(YES);
}

- (CGSize)collectionViewContentSize
{
    const CGSize theSize = {
        .width = self.cellSpacing * self.cellCount + self.centerOffset * 2.0f,
        .height = self.collectionView.bounds.size.height,
	};
    return(theSize);
}

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributes = [NSMutableArray array];
	
	// Cells...
	// TODO -- 3 is a bit of a fudge to make sure we get all cells... Ideally we should compute the right number of extra cells to fetch...
    NSInteger start = MIN(MAX((NSInteger)floorf(CGRectGetMinX(rect) / self.cellSpacing) - 3, 0), self.cellCount);
    NSInteger end = MIN(MAX((NSInteger)ceilf(CGRectGetMaxX(rect) / self.cellSpacing) + 3, 0), self.cellCount);
	
    for (NSInteger i = start; i != end; ++i)
	{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
		
        UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (attributes != NULL)
		{
            [layoutAttributes addObject:attributes];
		}
	}
	
    return(layoutAttributes);
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
	// Capture some commonly used variables...
    const CGFloat currentRow = indexPath.row;
	const CGRect viewBounds = self.collectionView.bounds;
	
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
	attributes.size = self.cellSize;
	
	// Delta is distance from center of the view...
	CGFloat distance = ABS((currentRow + 0.5f) * self.cellSpacing + self.centerOffset - viewBounds.size.width * 0.5f - self.collectionView.contentOffset.x);
	
	// TODO - we should write a getter for this that calculates the value. Setting it constantly is wasteful.
	if (roundf(distance/self.cellSpacing) == 0)
	{
		self.currentIndexPath = indexPath;
	}
	
	// set the center point of our cell
	const CGFloat thePosition = (currentRow + 0.5f) * (self.cellSpacing);
	attributes.center = (CGPoint){ thePosition + self.centerOffset, CGRectGetMidY(viewBounds) };
	
	CATransform3D transform = CATransform3DIdentity;
	transform.m34 = -1.0f / 250; // Need to figure out what this actually does.
	

	CGFloat zoom;
	if (distance < self.cellSpacing) {
		zoom = [self interpolateValueFrom:distance withFactorOf:ZOOM_FACTOR];
		attributes.alpha = [self interpolateValueFrom:distance withFactorOf:ALPHA_FACTOR];
	} else {
		zoom = 1.0f - ZOOM_FACTOR;
		attributes.alpha = 1.0f - ALPHA_FACTOR;
	}
	
    transform = CATransform3DScale(transform, zoom, zoom, 1.0f);
	
	attributes.transform3D = transform;
	
    return(attributes);
}

- (CGFloat) interpolateValueFrom:(CGFloat)value withFactorOf:(CGFloat)factor
{
	return (1 - ((value*100)/self.cellSpacing * factor) / 100);
}

- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    CGPoint theTargetContentOffset = proposedContentOffset;
	
	theTargetContentOffset.x = roundf(theTargetContentOffset.x / self.cellSpacing) * self.cellSpacing;
	theTargetContentOffset.x = MIN(theTargetContentOffset.x, (self.cellCount - 1) * self.cellSpacing);
	
    return(theTargetContentOffset);
}


@end
