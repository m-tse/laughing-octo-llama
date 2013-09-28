//
//  Track
//  iTunes Explorer
//
//  Created by Tianyu Shi on 9/27/13.
//  Copyright (c) 2013 Tianyu Shi, Matt Tse, Andrew Shim. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Track : NSObject

@property int rank;

@property NSString *artistName;
@property NSString *artistViewUrl;
@property NSString *artworkUrl100;
@property NSString *collectionViewUrl;
@property NSString *primaryGenreName;
@property NSString *trackName;
@property NSString *trackPrice;
@property NSString *trackViewUrl;

@end