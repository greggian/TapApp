//
//  TTapBar.m
//  TTTap
//
//  Created by gg on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTTapBar.h"


@implementation TTTapBar

@synthesize updated   = _updated;
@synthesize name   = _name;
@synthesize uri   = _uri;

@synthesize longitude   = _longitude;
@synthesize latitude   = _latitude;



- (void) dealloc {
	TT_RELEASE_SAFELY(_updated);
	TT_RELEASE_SAFELY(_name);
	TT_RELEASE_SAFELY(_uri);
	
	TT_RELEASE_SAFELY(_longitude);
	TT_RELEASE_SAFELY(_latitude);
	[super dealloc];
}


@end
