//
//  Utility.h
//  iTunes Explorer
//
//  Created by Tianyu Shi on 9/27/13.
//  Copyright (c) 2013 Tianyu Shi, Matt Tse, Andrew Shim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject

// HTTP string to define a maximum # of results
extern NSString *const REQUEST_LIMIT;

// HTTP string to define genre search query
extern NSString *const GENRE_QUERY;

// Max limit of results to be returned
extern int const MAX_LIMIT;

+ (NSString *) serverAddress;
+ (void) setServerAddress: (NSString *) address;

// Get Data from server

+ (NSMutableArray *) getTracksInGenre:(NSString *)genre
                        numRequested:(int)numRequested;
@end