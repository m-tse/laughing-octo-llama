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
@property NSString *songName;
@property int songIndex;
@property bool selected;
@property NSString *previewUrl;
@property NSString *imageUrl;

-(id) initSong:(NSString *)name index:(int)index prevUrl:(NSString *)prevUrl imUrl:(NSString *)imUrl artist:(NSString *)artist;

@end
