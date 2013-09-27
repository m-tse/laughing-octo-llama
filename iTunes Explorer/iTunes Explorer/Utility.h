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

+ (NSString *) serverAddress;
+ (void) setServerAddress: (NSString *) address;

// Get Data from server
+ (NSMutableArray *) getRelatedGenres:(NSString *)genre
                         numRequested:(int)numRequested;
+ (NSMutableArray *) getSongsInGenre:(NSString *)genre
                        numRequested:(int)numRequested;

// If we are to remember a user's preferences in our explorer
+ (void) incrementGenreCount:(NSString *)genre;

@end
