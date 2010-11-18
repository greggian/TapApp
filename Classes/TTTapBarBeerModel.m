//
//  TTTapBarBeerModel.m
//  TTTap
//
//  Created by gg on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "TTTapBarBeerModel.h"

#import "TTTapBeer.h"

#import <extThree20JSON/extThree20JSON.h>

static NSString* kTapBarBeerFeedFormat = @"http://localhost:8080/bar/%@/beer/?format=json";

@implementation TTTapBarBeerModel


@synthesize barId = _barId;
@synthesize beers = _beers;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithBarId:(NSString*)barId {
	if (self = [super init]) {
		self.barId = barId;
	}
	
	return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
	TT_RELEASE_SAFELY(_barId);
	TT_RELEASE_SAFELY(_beers);
	[super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
	if (!self.isLoading && TTIsStringWithAnyText(_barId)) {
		NSString* url = [NSString stringWithFormat:kTapBarBeerFeedFormat, _barId];
		
		TTURLRequest* request = [TTURLRequest requestWithURL: url delegate: self];
		
		request.cachePolicy = cachePolicy;
		request.cacheExpirationAge = 0;//TT_DEFAULT_CACHE_INVALIDATION_AGE;
		
		TTURLJSONResponse* response = [[TTURLJSONResponse alloc] init];
		request.response = response;
		TT_RELEASE_SAFELY(response);
		
		[request send];
	}
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)requestDidFinishLoad:(TTURLRequest*)request {
	TTURLJSONResponse* response = request.response;
	
	TTDASSERT([response.rootObject isKindOfClass:[NSDictionary class]]);
	NSDictionary* feed = response.rootObject;
	
	TTDASSERT([[feed objectForKey:@"stockedbeers"] isKindOfClass:[NSArray class]]);
	NSArray* entries = [feed objectForKey:@"stockedbeers"];
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	TT_RELEASE_SAFELY(_beers);
	NSMutableArray* beers = [[NSMutableArray alloc] initWithCapacity:[entries count]];
	
	for (NSDictionary* entry in entries) {
		TTTapBeer* beer = [[TTTapBeer alloc] init];
		
		beer.updated = [dateFormatter dateFromString:[entry objectForKey:@"updated_on"]];
		beer.name = [entry objectForKey:@"name"];
		beer.brewery = [entry objectForKey:@"brewery"];
		beer.uri = [entry objectForKey:@"resource_uri"];
		
		[beers addObject:beer];
		TT_RELEASE_SAFELY(beer);
	}
	
	_beers = beers;
	
	TT_RELEASE_SAFELY(dateFormatter);
	
	[super requestDidFinishLoad:request];
}



@end
