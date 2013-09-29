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
@end
