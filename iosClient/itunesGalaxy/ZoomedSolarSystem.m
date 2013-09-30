//
//  ZoomedSolarSystem.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ZoomedSolarSystem.h"
#import "Sun.h"
#import "Planet.h"
#import "Util.h"

@implementation ZoomedSolarSystem
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        

        
        SKEmitterNode * Sun;
        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
        Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithCircleOfRadius:100];
        Sun.physicsBody = physBody;
        [self addChild:Sun];

        
        for(int i = 0;i<5;i++){
            SKNode* planet = [[SKSpriteNode alloc] initWithImageNamed:@"planet6.png"];
            CGFloat randomScale = [Util randFloatFrom:0.1 to:0.5];
            [planet setScale:randomScale];
            int maxDistance = 385;
            CGPoint randPosition = CGPointMake([Util randFloatFrom:-maxDistance to:maxDistance],[Util randFloatFrom:-maxDistance to:maxDistance]);
            planet.position = randPosition;
            [self addChild:planet];

        }
        [scene addChild:self];
    }
    return self;
}
@end
