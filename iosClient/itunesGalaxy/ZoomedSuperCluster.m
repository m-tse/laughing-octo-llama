//
//  ZoomedSuperCluster.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ZoomedSuperCluster.h"

@implementation ZoomedSuperCluster

int COREPHYSICSBODYSIZE = 100;

-(id)initWithScene:(SKScene *)scene {
    
    if(self = [super init]){
        self.name = @"BM_distantSuperCluster";
        SKPhysicsBody *cgPhysicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(COREPHYSICSBODYSIZE,COREPHYSICSBODYSIZE)];
        NSMutableArray * clusters;
        clusters = [NSMutableArray arrayWithObjects:self, nil];
        
        self.physicsBody=cgPhysicsBody;
        
        [scene addChild:self];
//        int numClusters = [Util randIntFrom:MINRAMDOMCLUSTERS to:MAXRANDOMCLUSTERS];
//        
//        for(int i=0;i<numClusters;i++){
//            int numClusters = [clusters count];
//            int targetCluster = [Util randIntFrom:0 to:numClusters];
//            SKNode * connectedCluster = [clusters objectAtIndex:targetCluster];
//            
//            SKNode * cluster = [self cluster];
//            SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(CLUSTERPHYSICSBODYSIZE,CLUSTERPHYSICSBODYSIZE)];
//            cluster.physicsBody = physBody;
//            [self addChild:cluster];
//            cluster.position = CGPointMake(0, 0);
//            
//            
//            SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:connectedCluster.physicsBody bodyB:cluster.physicsBody anchorA:CGPointMake(0.5,0.5) anchorB:CGPointMake(0.5,0.5)];
//            spring.frequency = 0.1;
//            spring.damping = 50;
//            [scene.physicsWorld addJoint:spring];
//            [clusters addObject:(cluster)];
//        }
//        SKNode* label = [self clusterLabel:@"Apps"];
//        [self addChild:label];
        
    }
    return self;
}
@end
