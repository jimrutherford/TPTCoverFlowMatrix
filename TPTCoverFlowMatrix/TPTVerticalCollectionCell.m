//
//  TPTVerticalCollectionCell.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-19.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "TPTVerticalCollectionCell.h"
#import "TPTVerticalCollectionView.h"

@implementation TPTVerticalCollectionCell

@synthesize verticalCollection;

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
	
	self.verticalCollection = [[TPTVerticalCollectionView alloc] initWithFrame:CGRectMake(0, 0, 250, self.frame.size.height)];
	
	[self addSubview:verticalCollection];
	
	
}




@end
