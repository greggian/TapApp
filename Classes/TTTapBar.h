//
//  TTTapBar.h
//  TTTap
//
//  Created by gg on 11/11/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TTTapBar : NSObject {
	NSDate*   _updated;
	NSString* _name;
	NSString* _uri;
	
	NSNumber* _latitude;
	NSNumber* _longitude; 
}

@property (nonatomic, retain) NSDate*   updated;
@property (nonatomic, copy)   NSString* name;
@property (nonatomic, copy)   NSString* uri;

@property (nonatomic, retain) NSNumber* latitude;
@property (nonatomic, retain) NSNumber* longitude;

@end
