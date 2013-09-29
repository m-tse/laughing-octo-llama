//
//  AbstractSpaceScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "AbstractSpaceScene.h"
#import "Util.h"
int PUSH_FROM_EDGE_IMPULSE=1;
int BROWNIAN_MOTION_IMPULSE = 1;


@implementation AbstractSpaceScene
-(id)initWithSize:(CGSize) size {
    
    if(self = [super initWithSize:size]){
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.1 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        // Create background particles
        NSString *backgroundPath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"sks"];
        SKEmitterNode * spawnBackground;
        spawnBackground = [NSKeyedUnarchiver unarchiveObjectWithFile:backgroundPath];
        spawnBackground.position = CGPointMake(500, 500);
        [self addChild:spawnBackground];
    }
    return self;
}

-(void)update:(CFTimeInterval)currentTime {
    //Send things away from the edges
    [self enumerateChildNodesWithName:@"//*" usingBlock:^(SKNode *node, BOOL *stop) {

        CGFloat xImpulse = 0;
        CGFloat yImpulse = 0;
        CGPoint nodePositionInScene = [node.scene convertPoint:node.position fromNode:node.parent];
        if(nodePositionInScene.x<50){
//            NSLog(@"right, %f", nodePositionInScene.x);
            xImpulse = (CGFloat) PUSH_FROM_EDGE_IMPULSE;
        }
        if(nodePositionInScene.x>self.scene.size.width-50){
            
//            NSLog(@"left, %f", nodePositionInScene.x);
            xImpulse = (CGFloat) -PUSH_FROM_EDGE_IMPULSE;
        }
        if(nodePositionInScene.y<50){
//            NSLog(@"up, %f", nodePositionInScene.y);

            yImpulse = (CGFloat) PUSH_FROM_EDGE_IMPULSE;
        }
        if(nodePositionInScene.y>self.scene.size.height-50){
//            NSLog(@"down, %f", nodePositionInScene.y);

            yImpulse = (CGFloat) -PUSH_FROM_EDGE_IMPULSE;
        }
        
        [node.physicsBody applyImpulse:CGVectorMake(xImpulse,yImpulse)];
    }];
    
    
    /* Called before each frame is rendered */
}

-(void)applyBrownianMotionInScene:(SKScene*) scene withNodeNames:(NSString*) name{
    [scene enumerateChildNodesWithName:name usingBlock:^(SKNode *node, BOOL *stop) {
        CGFloat xImpulse = [Util randFloatFrom:-BROWNIAN_MOTION_IMPULSE to:BROWNIAN_MOTION_IMPULSE];
        CGFloat yImpulse = [Util randFloatFrom:-BROWNIAN_MOTION_IMPULSE to:BROWNIAN_MOTION_IMPULSE];
        [node.physicsBody applyImpulse:CGVectorMake(xImpulse, yImpulse)];
    }];
}

@end
