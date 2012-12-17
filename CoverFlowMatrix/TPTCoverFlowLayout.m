//
//  TPTCoverFlowLayout.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "TPTCoverFlowLayout.h"

@interface TPTCoverFlowLayout ()

@property (readwrite, nonatomic, assign) CGFloat centerOffset;
@property (readwrite, nonatomic, assign) NSInteger cellCount;

@end


@implementation TPTCoverFlowLayout

#define ACTIVE_DISTANCE 100
#define TRANSLATE_DISTANCE 100
#define ZOOM_FACTOR 0.2
#define FLOW_OFFSET 30

- (id)init
{
    self = [super init];
    if (self)
    {
		[self setup];
    }
    return self;
}


- (void) setup
{
	self.scrollDirection = UICollectionViewScrollDirectionHorizontal;
	self.itemSize = (CGSize){250, 250};
	self.sectionInset = UIEdgeInsetsMake(225, 0, 225, 0);
	
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
    return YES;
}

- (CGSize)collectionViewContentSize
{
    const CGSize theSize = {
        .width = self.cellSpacing * self.cellCount + self.centerOffset * 2.0f,
        .height = self.collectionView.bounds.size.height,
	};
    return(theSize);
}


-(NSArray*)xxxlayoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray* array = [super layoutAttributesForElementsInRect:rect];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
    for (UICollectionViewLayoutAttributes* attributes in array) {
       attributes.alpha = .5;
		if (attributes.representedElementCategory == UICollectionElementCategoryCell)
        {
            if (CGRectIntersectsRect(attributes.frame, rect)) {
				[self setCellAttributes:attributes forVisibleRect:visibleRect];
            }
			
        }
    }
    return array;
}


- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *theLayoutAttributes = [NSMutableArray array];
	
	CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
	
	// Cells...
	// TODO -- 3 is a bit of a fudge to make sure we get all cells... Ideally we should compute the right number of extra cells to fetch...
    NSInteger theStart = MIN(MAX((NSInteger)floorf(CGRectGetMinX(rect) / self.cellSpacing) - 3, 0), self.cellCount);
    NSInteger theEnd = MIN(MAX((NSInteger)ceilf(CGRectGetMaxX(rect) / self.cellSpacing) + 3, 0), self.cellCount);
	
	NSLog(@"START - %i, END - %i", theStart, theEnd);
	
    for (NSInteger N = theStart; N != theEnd; ++N)
	{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:N inSection:0];
		
        UICollectionViewLayoutAttributes *theAttributes = [self layoutAttributesForItemAtIndexPath:indexPath];
        if (theAttributes != NULL)
		{
			if (theAttributes.representedElementCategory == UICollectionElementCategoryCell)
			{
				if (CGRectIntersectsRect(theAttributes.frame, rect)) {
					theAttributes.alpha = .5;
					[self setCellAttributes:theAttributes forVisibleRect:visibleRect];
				}
			}
			[theLayoutAttributes addObject:theAttributes];
		}

	}
	
	
    return(theLayoutAttributes);
}



- (void)setCellAttributes:(UICollectionViewLayoutAttributes *)attributes forVisibleRect:(CGRect)visibleRect
{
    CGFloat distance = CGRectGetMidX(visibleRect) - attributes.center.x;
    CGFloat normalizedDistance = distance / ACTIVE_DISTANCE;
    BOOL isLeft = distance > 0;
    CATransform3D transform = CATransform3DIdentity;
    transform.m34 = -1/(4.6777 * self.itemSize.width);
	
    if (ABS(distance) < ACTIVE_DISTANCE)
    {
        if (ABS(distance) < TRANSLATE_DISTANCE)
        {
            transform = CATransform3DTranslate(CATransform3DIdentity, (isLeft? - FLOW_OFFSET : FLOW_OFFSET) * ABS(distance/TRANSLATE_DISTANCE), 0, (1 - ABS(normalizedDistance)) * 40000 + (isLeft? 250 : 0));
        }
        else
        {
            transform = CATransform3DTranslate(CATransform3DIdentity, (isLeft? - FLOW_OFFSET : FLOW_OFFSET), 0, (1 - ABS(normalizedDistance)) * 40000 + (isLeft? 250 : 0));
        }

        transform.m34 = -1/(4.6777 * self.itemSize.width);
        CGFloat zoom = 1 + ZOOM_FACTOR*(1 - ABS(normalizedDistance));
        
		transform = CATransform3DScale(transform, zoom, zoom, 1);
		
        attributes.alpha = ((ABS(ACTIVE_DISTANCE - ABS(distance)) + 1) /100) +0.5f;
    }
    else
    {
        transform = CATransform3DTranslate(transform, isLeft? -FLOW_OFFSET : FLOW_OFFSET, 0, 0);
        attributes.zIndex = 0;
    }
    attributes.transform3D = transform;
}


- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *attributes = [super layoutAttributesForItemAtIndexPath:indexPath];
    CGRect visibleRect;
    visibleRect.origin = self.collectionView.contentOffset;
    visibleRect.size = self.collectionView.bounds.size;
    
	[self setCellAttributes:attributes forVisibleRect:visibleRect];
    
    return attributes;
}





- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
	/*CGPoint theTargetContentOffset = proposedContentOffset;
    
        theTargetContentOffset.x = roundf(theTargetContentOffset.x / 200) * 200;
	int cellCount = 50;
        theTargetContentOffset.x = MIN(theTargetContentOffset.x, (cellCount - 1) * 200);
	
    return(theTargetContentOffset);
  */
	CGFloat offsetAdjustment = MAXFLOAT;
    CGFloat horizontalCenter = proposedContentOffset.x + (CGRectGetWidth(self.collectionView.bounds) / 2.0);
    
    CGRect targetRect = CGRectMake(proposedContentOffset.x, 0.0, self.collectionView.bounds.size.width, self.collectionView.bounds.size.height);
    NSArray* array = [super layoutAttributesForElementsInRect:targetRect];
    
    for (UICollectionViewLayoutAttributes* layoutAttributes in array) {
        CGFloat itemHorizontalCenter = layoutAttributes.center.x;
        if (ABS(itemHorizontalCenter - horizontalCenter) < ABS(offsetAdjustment)) {
            offsetAdjustment = itemHorizontalCenter - horizontalCenter;
        }
    }
    return CGPointMake(proposedContentOffset.x + offsetAdjustment, proposedContentOffset.y); 
}

@end
