//
//  DistantSuperCluster.m
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantSuperCluster.h"
#import "Util.h"
#import "Label.h"

@implementation DistantSuperCluster

@synthesize mediaType;

int MAXRANDOMCLUSTERS = 40;
int MINRAMDOMCLUSTERS = 20;
float MAXCLUSTERSIZE = 0.1;
float MINCLUSTERSIZE = 0.01;
int CLUSTERSCALESPEEDFACTOR = 5;
//int MAXINTERCLUSTERDISTANCE = 150;
//int MININTERCLUSTERDISTANCE = 10;
int COREPHYSICSBODYSIZE = 100;
int CLUSTERPHYSICSBODYSIZE = 15;

- (SKNode*) cluster {
    SKEmitterNode * cluster;
    NSString *clusterPath = [[NSBundle mainBundle] pathForResource:@"DistantCluster" ofType:@"sks"];
    cluster = [NSKeyedUnarchiver unarchiveObjectWithFile:clusterPath];
    CGFloat particleScale = [Util randFloatFrom:MINCLUSTERSIZE to:MAXCLUSTERSIZE];
    cluster.particleScale = particleScale;
    cluster.particleScaleSpeed = particleScale/CLUSTERSCALESPEEDFACTOR;
    
    return cluster;
}


-(id)initWithScene:(SKScene *)scene withLabel:(NSString*) label{
    
    if(self = [super init]){
        self.mediaType = label;
        self.name = @"BM_distantSuperCluster";
        SKPhysicsBody *cgPhysicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(COREPHYSICSBODYSIZE,COREPHYSICSBODYSIZE)];
        NSMutableArray * clusters;
        clusters = [[NSMutableArray alloc] init];
        [clusters addObject:self];

        self.physicsBody=cgPhysicsBody;
        
        [scene addChild:self];
        
        int numClusters = [Util randIntFrom:MINRAMDOMCLUSTERS to:MAXRANDOMCLUSTERS];
        for(int i=0;i<numClusters;i++){
            int numClusters = [clusters count];
            int targetCluster = [Util randIntFrom:0 to:numClusters];
            SKNode * connectedCluster = [clusters objectAtIndex:targetCluster];
            
            SKNode * cluster = [self cluster];
            CGFloat randFloat = [Util randFloatFrom:5 to:30];
            SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(randFloat,randFloat)];
            cluster.physicsBody = physBody;
            [connectedCluster addChild:cluster];
            cluster.position = CGPointMake(0, 0);
            
            SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:connectedCluster.physicsBody bodyB:cluster.physicsBody anchorA:CGPointMake(0.5,0.5) anchorB:CGPointMake(0.5,0.5)];
            spring.frequency = 2;
            spring.damping = 50;
            [scene.physicsWorld addJoint:spring];
            [clusters addObject:(cluster)];
        }

        SKLabelNode * myLabel = [[Label alloc] initWithFontSize:20 onNode:self inScene:scene withText:label];
        
    }
    return self;
}


@end
