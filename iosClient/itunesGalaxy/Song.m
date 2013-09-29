//
//  Track.m
//  iTunesGalaxy
//
//  Created by Andrew Shim on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Song.h"

@implementation Song

const float RADIUS = 200.0;

-(id) initSong:(NSString *)name index:(int)index {
    if ([name length] > 20) {
        name = [[NSString alloc] initWithFormat:@"%@...",[name substringToIndex:20]]; 
    }
    self.angle = M_PI/5*index;
    self.songNode = [SKSpriteNode spriteNodeWithImageNamed:@"choose-custom-music"];
    float x = RADIUS * cosf(M_PI/5*(index));
    float y = RADIUS * sinf(M_PI/5*(index));
    [self.songNode setPosition:CGPointMake(x, y)];
    [self.songNode setSize:CGSizeMake(20, 20)];
    SKLabelNode *songLabel;
    songLabel = [SKLabelNode labelNodeWithFontNamed:name];
    [songLabel setPosition:CGPointMake(0, -20)];
    [songLabel setText:name];
    [songLabel setFontSize:10.0];
    [self.songNode addChild:songLabel];
    self.songName = name;
    self.songIndex = index;
    return self;
}

@end
