//
//  TPTVerticalCollectionView.h
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-19.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTVerticalCollectionView : UIView <UICollectionViewDataSource, UICollectionViewDelegate>


@property (strong, nonatomic) UICollectionView * collectionView;

@property (strong, nonatomic) NSArray *dataArray;

@end
