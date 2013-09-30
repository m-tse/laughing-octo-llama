//
//  DistantSolarSystem.m
//  itunesGalaxy
//
//  Created by Matthew on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantSolarSystem.h"
#import "Sun.h"

@implementation DistantSolarSystem
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5.0];
        SKEmitterNode * cluster;
        NSString *clusterPath = [[NSBundle mainBundle] pathForResource:@"DistantCluster" ofType:@"sks"];
        cluster = [NSKeyedUnarchiver unarchiveObjectWithFile:clusterPath];
        cluster.position = CGPointMake(300,300);
//        SKNode* sun = [[Sun alloc] init];
//        sun.position = CGPointMake(0.5, 0.5);
        [self addChild:cluster];

        [scene addChild:self];
        
        
    }
    return self;
}

-(id)init{
    if(self = [super init]){
        self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:5.0];
        SKEmitterNode * cluster;
        NSString *clusterPath = [[NSBundle mainBundle] pathForResource:@"DistantCluster" ofType:@"sks"];
        cluster = [NSKeyedUnarchiver unarchiveObjectWithFile:clusterPath];
        cluster.position = CGPointMake(300,300);
        //        SKNode* sun = [[Sun alloc] init];
        //        sun.position = CGPointMake(0.5, 0.5);
        [self addChild:cluster];
        
    }
    return self;
}
@end
