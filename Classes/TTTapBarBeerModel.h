//
//  TTTapBarBeerModel.h
//  TTTap
//
//  Created by gg on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TTTapBarBeerModel : TTURLRequestModel {
	NSString* _barId;
	
	NSArray*  _beers;
}

@property (nonatomic, copy)     NSString* barId;
@property (nonatomic, readonly) NSArray*  beers;

- (id)initWithBarId:(NSString*)barId;

@end
