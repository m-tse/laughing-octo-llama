//
//  DistantSuperCluster.h
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DistantSuperCluster : SKNode

-(id)initWithScene:(SKScene *)scene withLabel:(NSString*) label;
@property NSString *mediaType;

@end
