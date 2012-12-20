//
//  TPTCoverFlowLayout.h
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TPTCoverFlowLayout : UICollectionViewFlowLayout

@property (readwrite, nonatomic, assign) CGSize cellSize;
@property (readwrite, nonatomic, assign) CGFloat cellSpacing;
@property (readonly, nonatomic, strong) NSIndexPath *currentIndexPath;

@end