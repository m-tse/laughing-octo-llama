//
//  Track.h
//  iTunesGalaxy
//
//  Created by Andrew Shim on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface Song : NSObject

@property int rank;

@property NSString *artistName;
@property NSString *artistViewUrl;
@property NSString *artworkUrl100;
@property NSString *collectionViewUrl;
@property NSString *primaryGenreName;
@property NSString *trackName;
@property NSString *trackPrice;
@property NSString *trackViewUrl;
@property float angle;
@property SKSpriteNode *songNode;

-(id) initSong:(NSString *)name index:(int)index;

@end
