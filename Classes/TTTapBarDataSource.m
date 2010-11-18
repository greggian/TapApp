//
// Copyright 2009-2010 Facebook
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//    http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.
//

#import "TTTapBarDataSource.h"

#import "TTTapBar.h"

// Three20 Additions
#import <Three20Core/NSDateAdditions.h>


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTapBarDataSource


@synthesize location;


static NSNumberFormatter* distanceFormatter;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString*)searchQuery {
	if (self = [super init]) {
		_barModel = [[TTTapBarModel alloc] initWithSearchQuery:searchQuery];
		
		if(!distanceFormatter){
			distanceFormatter = [[NSNumberFormatter alloc] init];
			[distanceFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
			[distanceFormatter setMaximumFractionDigits:1];
		}
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)dealloc {
	TT_RELEASE_SAFELY(_barModel);
	
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id<TTModel>)model {
	return _barModel;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)tableViewDidLoadModel:(UITableView*)tableView {
	NSMutableArray* items = [[NSMutableArray alloc] init];
	
	CLLocation *userLoc = self.location;
	
	for (TTTapBar* bar in _barModel.bars) {
		CLLocation *poiLoc = [[CLLocation alloc] initWithLatitude: [bar.latitude doubleValue] longitude: [bar.longitude doubleValue]];
		CLLocationDistance distMiles = [userLoc distanceFromLocation:poiLoc] / 1609.344;
		
		
		TTStyledText* styledText = [TTStyledText textFromXHTML:
									[NSString stringWithFormat:@"%@\n<b>%@ mi</b>",
									 [bar.name stringByReplacingOccurrencesOfString:@"&" withString:@"&amp;"],
									 [distanceFormatter stringFromNumber:[NSNumber numberWithDouble: distMiles]]
									 ]
									lineBreaks:YES URLs:YES];
		// If this asserts, it's likely that the bar.name contains an HTML character that caused
		// the XML parser to fail.
		TTDASSERT(nil != styledText);
		TTTableStyledTextItem* item = [TTTableStyledTextItem itemWithText:styledText URL:[NSString stringWithFormat:@"tt:/%@", bar.uri]];
		item.userInfo = bar;
		
		[items addObject: item];
		
		TT_RELEASE_SAFELY(poiLoc);
	}
	
	self.items = items;
	TT_RELEASE_SAFELY(items);
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForLoading:(BOOL)reloading {
	if (reloading) {
		return NSLocalizedString(@"Updating bar feed...", @"Twitter feed updating text");
	} else {
		return NSLocalizedString(@"Loading bar feed...", @"Twitter feed loading text");
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)titleForEmpty {
	return NSLocalizedString(@"No bars found.", @"Twitter feed no results");
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (NSString*)subtitleForError:(NSError*)error {
	return NSLocalizedString(@"Sorry, there was an error loading the bar stream.", @"");
}


@end

