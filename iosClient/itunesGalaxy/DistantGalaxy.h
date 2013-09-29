//
//  Galaxy.h
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DistantGalaxy : SKNode {
    SKSpriteNode *_galaxy;
    NSArray *_galaxyAnimation;
}

-(id)initWithScene:(SKScene *)scene;

@end
