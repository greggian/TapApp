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

#import "TTTapBarViewController.h"

#import "TTTapBarDataSource.h"
#import "TTTapBar.h"


///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////
@implementation TTTapBarViewController


@synthesize locationManager;

///////////////////////////////////////////////////////////////////////////////////////////////////
- (id) init {
  if (self = [super init]) {
    self.variableHeightRows = YES;
  }

  return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.title = @"Bars";
	
	// Start the location manager.
	[[self locationManager] startUpdatingLocation];


}


///////////////////////////////////////////////////////////////////////////////////////////////////
- (void)createModel {
  self.dataSource = [[[TTTapBarDataSource alloc]
                      initWithSearchQuery:@"three20"] autorelease];
}


///////////////////////////////////////////////////////////////////////////////////////////////////

- (id<UITableViewDelegate>)createDelegate {
  return [[[TTTableViewDragRefreshDelegate alloc] initWithController:self] autorelease];
}



#pragma mark -
#pragma mark Location manager

/**
 Return a location manager -- create one if necessary.
 */
- (CLLocationManager *)locationManager {
	
    if (locationManager != nil) {
		return locationManager;
	}
	
	locationManager = [[CLLocationManager alloc] init];
	[locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
	[locationManager setDelegate:self];
	
	return locationManager;
}

/**
 Conditionally enable the Add button:
 If the location manager is generating updates, then enable the button;
 If the location manager is failing, then disable the button.
 */
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation {

	if(self.dataSource != nil){
		TTTapBarDataSource* ds = (TTTapBarDataSource*)self.dataSource;
		ds.location = newLocation;
	}
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {

}


- (void)dealloc {
    [locationManager release];
    [super dealloc];
}

@end

