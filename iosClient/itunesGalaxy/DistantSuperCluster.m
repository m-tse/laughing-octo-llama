//
//  DistantSuperCluster.m
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantSuperCluster.h"
#import "Util.h"

@implementation DistantSuperCluster

int MAXRANDOMCLUSTERS = 20;
int MINRAMDOMCLUSTERS = 10;
float MAXCLUSTERSIZE = 0.1;
float MINCLUSTERSIZE = 0.01;
int CLUSTERSCALESPEEDFACTOR = 5;
//int MAXINTERCLUSTERDISTANCE = 150;
//int MININTERCLUSTERDISTANCE = 10;
int COREPHYSICSBODYSIZE = 100;
int CLUSTERPHYSICSBODYSIZE = 30;

- (SKNode*) cluster {
    SKEmitterNode * cluster;
    NSString *clusterPath = [[NSBundle mainBundle] pathForResource:@"DistantCluster" ofType:@"sks"];
    cluster = [NSKeyedUnarchiver unarchiveObjectWithFile:clusterPath];
    CGFloat particleScale = [Util randFloatFrom:MINCLUSTERSIZE to:MAXCLUSTERSIZE];
    cluster.particleScale = particleScale;
    cluster.particleScaleSpeed = particleScale/CLUSTERSCALESPEEDFACTOR;
    
    return cluster;
}

- (SKNode*) clusterLabel:(NSString*) text {
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"BebasNeue"];
    label.name = @"super_cluser_label";
    label.text = text;
    label.fontSize = 30;
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    label.physicsBody = physicsBody;
    physicsBody.affectedByGravity = false;
    return label;
    
}

-(id)initWithScene:(SKScene *)scene {

    if(self = [super init]){
        self.name = @"BM_distantSuperCluster";
        SKPhysicsBody *cgPhysicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(COREPHYSICSBODYSIZE,COREPHYSICSBODYSIZE)];
        NSMutableArray * clusters;
        clusters = [NSMutableArray arrayWithObjects:self, nil];

        self.physicsBody=cgPhysicsBody;
        
        [scene addChild:self];
        int numClusters = [Util randIntFrom:MINRAMDOMCLUSTERS to:MAXRANDOMCLUSTERS];
        for(int i=0;i<numClusters;i++){
            int numClusters = [clusters count];
            int targetCluster = [Util randIntFrom:0 to:numClusters];
            NSLog(@"%d", targetCluster);
            SKNode * connectedCluster = [clusters objectAtIndex:targetCluster];
            
            SKNode * cluster = [self cluster];
            SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(CLUSTERPHYSICSBODYSIZE,CLUSTERPHYSICSBODYSIZE)];
            cluster.physicsBody = physBody;
            [connectedCluster addChild:cluster];
            cluster.position = CGPointMake(0, 0);
            
            
            SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:connectedCluster.physicsBody bodyB:cluster.physicsBody anchorA:CGPointMake(0,0) anchorB:CGPointMake(0,0)];
            spring.frequency = 0.1;
            spring.damping = 50;
            [scene.physicsWorld addJoint:spring];
            [clusters addObject:(cluster)];
        }
        SKNode* label = [self clusterLabel:@"Apps"];
        [self addChild:label];

    }
    return self;
}


@end
