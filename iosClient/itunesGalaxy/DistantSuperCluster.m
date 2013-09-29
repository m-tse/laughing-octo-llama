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
int MINRAMDOMCLUSTERS = 7;
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

-(void)setSetClusterLabel:(NSString*) label {
    _labelNode.text = label;
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
            SKNode * connectedCluster = [clusters objectAtIndex:targetCluster];
            
            SKNode * cluster = [self cluster];
            SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(CLUSTERPHYSICSBODYSIZE,CLUSTERPHYSICSBODYSIZE)];
            cluster.physicsBody = physBody;
            [self addChild:cluster];
            cluster.position = CGPointMake(0, 0);
            
            
            SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:connectedCluster.physicsBody bodyB:cluster.physicsBody anchorA:CGPointMake(0.5,0.5) anchorB:CGPointMake(0.5,0.5)];
            spring.frequency = 0.1;
            spring.damping = 50;
            [scene.physicsWorld addJoint:spring];
            [clusters addObject:(cluster)];
        }

        _labelNode = [SKLabelNode labelNodeWithFontNamed:@"BebasNeue"];
        _labelNode.fontSize = 20;
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _labelNode.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        
        [self addChild:_labelNode];
    }
    return self;
}


@end
