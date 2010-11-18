//
//  TTTapBarBeerDataSource.m
//  TTTap
//
//  Created by gg on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTTapBarBeerDataSource.h"


#import "TTTapBarBeerModel.h"
#import "TTTapBeer.h"

@implementation TTTapBarBeerDataSource


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithBarId:(NSString*)barId bar:bar {
	if (self = [super init]) {
		_barBeerModel = [[TTTapBarBeerModel alloc] initWithBarId:barId];
		_bar = bar;
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_barBeerModel);
	
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _barBeerModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	for (TTTapBeer* beer in _barBeerModel.beers) {
		TTTableMessageItem* item = [TTTableMessageItem 
									itemWithTitle:beer.name
									caption:beer.brewery
									text:@"by :User:"
									timestamp:beer.updated
									URL:nil];		
		
		[items addObject:item];
	}
	
	TTTableMessageItem* head = [TTTableMessageItem 
								itemWithTitle: _bar.name
								caption:@"address"
								text:@""
								timestamp:_bar.updated
								URL:nil];	
	NSMutableArray* heads = [[NSMutableArray alloc] init];	
	[heads addObject:head];
	
	
	NSMutableArray* itemItems = [[NSMutableArray alloc] init];	
	[itemItems addObject:heads];
	[itemItems addObject:items];
	self.items = itemItems;
	
	
	NSMutableArray* sections = [[NSMutableArray alloc] init];
	[sections addObject:@""];
	[sections addObject:@"Stocked Beers"];
	self.sections = sections;
	
	TT_RELEASE_SAFELY(sections);
	TT_RELEASE_SAFELY(items);
	TT_RELEASE_SAFELY(heads);
	TT_RELEASE_SAFELY(itemItems);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return NSLocalizedString(@"Updating beer feed...", @"Twitter feed updating text");
	} else {
		return NSLocalizedString(@"Loading beer feed...", @"Twitter feed loading text");
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
	return NSLocalizedString(@"No beers found.", @"Twitter feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
	return NSLocalizedString(@"Sorry, there was an error loading the beer stream.", @"");
}


@end
