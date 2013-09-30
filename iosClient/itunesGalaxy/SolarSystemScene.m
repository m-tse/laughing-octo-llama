//
//  SolarSystemScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "SolarSystemScene.h"
#import "ZoomedSolarSystem.h"

@implementation SolarSystemScene

-(id)initWithSize:(CGSize)size{
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        SKNode* galaxy = [[ZoomedSolarSystem alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-80);
        galaxy.position = position;
        
    }
    return self;
}
@end
