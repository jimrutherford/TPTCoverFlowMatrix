//
//  ViewController.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "ViewController.h"
#import "TPTVerticalCollectionCell.h"
#import "TPTCoverFlowLayout.h"
#import "TPTVerticalCollectionView.h"

#define kVerticalCollectionCellIdentifier @"verticalCollectionCellIdentifier"

@interface ViewController ()

@end

@implementation ViewController


@synthesize dataArray;

@synthesize blurArray;
@synthesize bamfieldArray;
@synthesize paperArray;
@synthesize mexicoArray;

@synthesize spaceArray;
@synthesize travelArray;
@synthesize winterArray;
@synthesize foodArray;
@synthesize celebrityArray;
@synthesize autumnArray;
@synthesize animalArray;

- (void)viewDidLoad
{
    [super viewDidLoad];
	dataArray = [NSArray array];
	
	blurArray = [NSMutableArray array];
	bamfieldArray = [NSMutableArray array];
	paperArray = [NSMutableArray array];
	mexicoArray = [NSMutableArray array];
	spaceArray = [NSMutableArray array];
	travelArray = [NSMutableArray array];
	winterArray = [NSMutableArray array];
	foodArray = [NSMutableArray array];
	celebrityArray = [NSMutableArray array];
	autumnArray = [NSMutableArray array];
	animalArray = [NSMutableArray array];
	
	
	for (int i=0; i<13; i++) {
		[blurArray addObject:[NSString stringWithFormat:@"blur%d.png", i+1]];
		[animalArray addObject:[NSString stringWithFormat:@"animal%d.png", i+1]];
		[spaceArray addObject:[NSString stringWithFormat:@"space%d.png", i+1]];
		[travelArray addObject:[NSString stringWithFormat:@"travel%d.png", i+1]];
		[winterArray addObject:[NSString stringWithFormat:@"winter%d.png", i+1]];
	}
	
	for (int i=0; i<9; i++) {
		[bamfieldArray addObject:[NSString stringWithFormat:@"bamfield%d.png", i+1]];
		[autumnArray addObject:[NSString stringWithFormat:@"autumn%d.png", i+1]];
	}

	for (int i=0; i<11; i++) {
		[celebrityArray addObject:[NSString stringWithFormat:@"celebrity%d.png", i+1]];
		[foodArray addObject:[NSString stringWithFormat:@"food%d.png", i+1]];
	}
	
	for (int i=0; i<5; i++) {
		[paperArray addObject:[NSString stringWithFormat:@"paper%d.png", i+1]];
	}

	for (int i=0; i<8; i++) {
		[mexicoArray addObject:[NSString stringWithFormat:@"mexico%d.png", i+1]];
	}
	
	dataArray = [NSArray arrayWithObjects: blurArray, bamfieldArray, paperArray, mexicoArray, spaceArray, travelArray, winterArray, foodArray, celebrityArray, autumnArray, animalArray, nil];
	
	TPTCoverFlowLayout *flowLayout = [[TPTCoverFlowLayout alloc] init];
	[flowLayout setItemSize:CGSizeMake(250, self.view.frame.size.height)];
	
	[self.horizontalCollectionView registerClass:[TPTVerticalCollectionCell class] forCellWithReuseIdentifier:kVerticalCollectionCellIdentifier];
	[self.horizontalCollectionView setCollectionViewLayout:flowLayout];
	
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
	return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	//NSLog(@"Number of items in section = %i", [dataArray count]);
	return [dataArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *cellIdentifier = kVerticalCollectionCellIdentifier;
	TPTVerticalCollectionCell *cell = (TPTVerticalCollectionCell *)[self.horizontalCollectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	//NSMutableArray *data = [self.dataArray objectAtIndex:indexPath.section];
	
	NSArray *cellData = [dataArray objectAtIndex:indexPath.row];
	
	NSLog(@"Cell Data : %@", cellData);
	
	[cell.verticalCollection setDataArray:cellData];
	
	return cell;
	
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
