//
//  ViewController.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "ViewController.h"
#import "ProjectCell.h"
#import "TPTCoverFlowLayout.h"

#define kProjectCellIdentifier @"projectCellIdentifier"

@interface ViewController ()

@end

@implementation ViewController


@synthesize dataArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	dataArray = [NSMutableArray array];
	
	for (int i=0; i<13; i++) {
		[dataArray addObject:[NSString stringWithFormat:@"blur%d.png", i+1]];
	}

	for (int i=0; i<9; i++) {
		[dataArray addObject:[NSString stringWithFormat:@"bamfield%d.png", i+1]];
	}
	
//	for (int i=0; i<5; i++) {
//		[dataArray addObject:[NSString stringWithFormat:@"paper%d.png", i+1]];
//	}
//	
//	for (int i=0; i<8; i++) {
//		[dataArray addObject:[NSString stringWithFormat:@"mexico%d.png", i+1]];
//	}
	
	[self.horizontalCollectionView registerClass:[ProjectCell class] forCellWithReuseIdentifier:kProjectCellIdentifier];
	
	TPTCoverFlowLayout *flowLayout = [[TPTCoverFlowLayout alloc] init];
	[flowLayout setItemSize:CGSizeMake(200, 200)];
	
	[self.horizontalCollectionView setCollectionViewLayout:flowLayout];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	NSLog(@"Number of items in section = %i", [dataArray count]);
	return [dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = kProjectCellIdentifier;
	ProjectCell *cell = (ProjectCell *)[self.horizontalCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	//NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
	
	NSString *cellData = [dataArray objectAtIndex:indexPath.row];
	
	NSLog(@"Cell Data : %@", cellData);
	
	[cell.cellImage setImage:[UIImage imageNamed:cellData]];
	
	return cell;
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
