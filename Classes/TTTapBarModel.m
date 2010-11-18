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

#import "TTTapBarModel.h"

#import "TTTapBar.h"

#import <extThree20JSON/extThree20JSON.h>

//static NSString* kTwitterSearchFeedFormat = @"http://search.twitter.com/search.json?q=%@";
static NSString* kTapBarFeedFormat = @"http://localhost:8080/bar/?format=json";


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTapBarModel

@synthesize searchQuery = _searchQuery;
@synthesize bars      = _bars;


///////////////////////////////////////////////////////////////////////////////////////////////////
- (id)initWithSearchQuery:(NSString*)searchQuery {
  if (self = [super init]) {
    self.searchQuery = searchQuery;
  }

  return self;
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void) dealloc {
  TT_RELEASE_SAFELY(_searchQuery);
  TT_RELEASE_SAFELY(_bars);
  [super dealloc];
}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)load:(TTURLRequestCachePolicy)cachePolicy more:(BOOL)more {
  if (!self.isLoading && TTIsStringWithAnyText(_searchQuery)) {
    NSString* url = [NSString stringWithFormat:kTapBarFeedFormat, _searchQuery];

    TTURLRequest* request = [TTURLRequest
                             requestWithURL: url
                             delegate: self];

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
  
  TTDASSERT([response.rootObject isKindOfClass:[NSArray class]]);
  NSArray* entries = response.rootObject;
	
	NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
  TT_RELEASE_SAFELY(_bars);
  NSMutableArray* bars = [[NSMutableArray alloc] initWithCapacity:[entries count]];

  for (NSDictionary* entry in entries) {
    TTTapBar* bar = [[TTTapBar alloc] init];

	bar.updated = [dateFormatter dateFromString:[entry objectForKey:@"updated_on"]];
    bar.name = [entry objectForKey:@"name"];
    bar.uri = [entry objectForKey:@"resource_uri"];
	  
	
	NSDictionary* location = [entry objectForKey:@"location"];
	bar.longitude = [NSNumber numberWithFloat:
						 [[location objectForKey:@"lon"] floatValue]];
	bar.latitude = [NSNumber numberWithFloat:
						 [[location objectForKey:@"lat"] floatValue]];
    //TT_RELEASE_SAFELY(location);
	  
    [bars addObject:bar];

	TT_RELEASE_SAFELY(bar);
  }
 
  _bars = bars;

  TT_RELEASE_SAFELY(dateFormatter);

  [super requestDidFinishLoad:request];
}


@end

