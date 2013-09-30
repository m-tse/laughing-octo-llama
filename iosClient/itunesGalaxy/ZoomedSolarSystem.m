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

@implementation ZoomedSolarSystem
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        
        
//        SKNode* sun = [[Sun alloc] init];
//        sun.position = CGPointMake(0.5, 0.5);
//        [self addChild:sun];
        
        
        SKEmitterNode * Sun;
        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
        Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithCircleOfRadius:100];
        Sun.physicsBody = physBody;
        [self addChild:Sun];

        SKNode* planet = [[Planet alloc] init];
        [self addChild:planet];
        
        [scene addChild:self];
        
        
    }
    return self;
}
@end
