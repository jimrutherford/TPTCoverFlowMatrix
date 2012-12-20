//
//  ProjectCell.m
//  CoverFlowMatrix
//
//  Created by James Rutherford on 2012-12-13.
//  Copyright (c) 2012 Braxio Interactive. All rights reserved.
//

#import "TPTCell.h"

@implementation TPTCell

- (id)initWithFrame:(CGRect)frame
{
	self = [super initWithFrame:frame];
	if (self) {
		
		// Initialization code
		NSArray *arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"TPTCell" owner:self options:nil];
		
		if ([arrayOfViews count] < 1) { return nil; }
		
		if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) { return nil; }
		
		self = [arrayOfViews objectAtIndex:0];
	}
	return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
