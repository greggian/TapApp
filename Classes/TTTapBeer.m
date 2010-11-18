//
//  TTTapBeer.m
//  TTTap
//
//  Created by gg on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTTapBeer.h"


@implementation TTTapBeer

@synthesize updated   = _updated;
@synthesize name	= _name;
@synthesize brewery   = _brewery;
@synthesize uri   = _uri;



- (void) dealloc {
	TT_RELEASE_SAFELY(_updated);
	TT_RELEASE_SAFELY(_name);
	TT_RELEASE_SAFELY(_brewery);
	TT_RELEASE_SAFELY(_uri);
	
	[super dealloc];
}

@end
