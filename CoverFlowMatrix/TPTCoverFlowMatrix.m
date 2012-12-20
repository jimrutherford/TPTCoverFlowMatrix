//
//  TPTCoverFlowMatrix.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-20.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "TPTCoverFlowMatrix.h"
#import "TPTVerticalCollectionCell.h"
#import "TPTCoverFlowLayout.h"

#define kVerticalCollectionCellIdentifier @"verticalCollectionCellIdentifier"

@implementation TPTCoverFlowMatrix

@synthesize collectionView;
@synthesize dataArray;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void) setup
{
	dataArray = [NSArray array];
	
	self.backgroundColor = [UIColor clearColor];
	
	TPTCoverFlowLayout *coverFlowLayout = [[TPTCoverFlowLayout alloc] init];

	coverFlowLayout.cellSize = CGSizeMake(250.0f, self.frame.size.height);
    coverFlowLayout.cellSpacing = 250.0f;
	
	
	collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:coverFlowLayout];
	
	[self.collectionView registerClass:[TPTVerticalCollectionCell class] forCellWithReuseIdentifier:kVerticalCollectionCellIdentifier];
	
	collectionView.showsHorizontalScrollIndicator = NO;
	collectionView.showsVerticalScrollIndicator = NO;
	
	collectionView.dataSource = self;
	collectionView.delegate = self;
	
	collectionView.backgroundColor = [UIColor clearColor];
	
	[self addSubview:collectionView];
	
}

-(void) setDataArray:(NSArray *)aDataArray
{
	dataArray = aDataArray;
	[self.collectionView reloadData];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return [dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = kVerticalCollectionCellIdentifier;
	TPTVerticalCollectionCell *cell = (TPTVerticalCollectionCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	NSArray *cellData = [dataArray objectAtIndex:indexPath.row];
	
	//NSLog(@"Cell Data : %@", cellData);
	
	[cell.verticalCollection setDataArray:cellData];
	
	return cell;
	
}


@end
