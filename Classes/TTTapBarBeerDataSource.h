//
//  TTTapBarBeerDataSource.h
//  TTTap
//
//  Created by gg on 11/14/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TTTapBar.h"

@class TTTapBarBeerModel;

@interface TTTapBarBeerDataSource : TTSectionedDataSource {
  TTTapBarBeerModel* _barBeerModel;
  TTTapBar* _bar;
}
- (id)initWithBarId:(NSString*)barId bar:bar;

@end
