//
//  TTTapBeer.h
//  TTTap
//
//  Created by gg on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TTTapBeer : NSObject {
	NSDate*   _updated;
	NSString* _name;
	NSString* _brewery;
	NSString* _uri;
}

@property (nonatomic, retain) NSDate*   updated;
@property (nonatomic, copy)   NSString* name;
@property (nonatomic, copy)   NSString* brewery;
@property (nonatomic, copy)   NSString* uri;

@end
