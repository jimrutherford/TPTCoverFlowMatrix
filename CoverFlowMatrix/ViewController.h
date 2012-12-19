//
//  ViewController.h
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPTVerticalCollectionView.h"

@interface ViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView *horizontalCollectionView;

@property (nonatomic, strong) NSArray *dataArray;

@property (nonatomic, strong) NSMutableArray *blurArray;
@property (nonatomic, strong) NSMutableArray *bamfieldArray;
@property (nonatomic, strong) NSMutableArray *paperArray;
@property (nonatomic, strong) NSMutableArray *mexicoArray;

@property (nonatomic, strong) NSMutableArray *spaceArray;
@property (nonatomic, strong) NSMutableArray *travelArray;
@property (nonatomic, strong) NSMutableArray *winterArray;
@property (nonatomic, strong) NSMutableArray *foodArray;
@property (nonatomic, strong) NSMutableArray *celebrityArray;
@property (nonatomic, strong) NSMutableArray *autumnArray;
@property (nonatomic, strong) NSMutableArray *animalArray;


@end
