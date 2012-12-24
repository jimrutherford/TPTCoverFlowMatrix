//
//  TPTCoverFlowMatrix.h
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-20.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTCoverFlowMatrix : UIView <UICollectionViewDataSource, UICollectionViewDelegate>


@property (strong, nonatomic) UICollectionView * collectionView;

@property (strong, nonatomic) NSArray *dataArray;

- (void)selectItemAtIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated scrollPosition:(UICollectionViewScrollPosition)scrollPosition;

- (void)scrollByFractionalValue:(float)value;

@property (nonatomic) BOOL isLiveScrolling;

- (void) startLiveScrolling;
- (void) stopLiveScrolling;

@end
