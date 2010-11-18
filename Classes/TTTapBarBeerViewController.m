//
//  TTTapBarBeerViewController.m
//  TTTap
//
//  Created by gg on 11/13/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTTapBarBeerViewController.h"

#import "TTTapBarBeerDataSource.h"



@implementation TTTapBarBeerViewController

//@synthesize barId = _barId;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithBar:(NSString*)barId query:(NSDictionary*)query {
	TTTapBar* bar = [query objectForKey:@"__userInfo__"];
	
	if (self = [super init]) {
		self.variableHeightRows = YES;
		self.tableViewStyle = UITableViewStyleGrouped;
		
		//self.title = bar.name;
		_barId = barId;
		_bar = bar;
	}
	return self;
}

///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
	self.dataSource = [[[TTTapBarBeerDataSource alloc]
						initWithBarId:_barId bar:_bar] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<UITableViewDelegate>)createDelegate {
	return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}

@end
