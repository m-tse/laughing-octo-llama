//
//  AbstractSpaceScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "AbstractSpaceScene.h"
#import "Util.h"
int PUSH_FROM_EDGE_IMPULSE=4;
//int BROWNIAN_MOTION_IMPULSE = 1;


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
        NSLog(@"%f", nodePositionInScene.y);
        if(nodePositionInScene.x<50){
            xImpulse = (CGFloat) PUSH_FROM_EDGE_IMPULSE;
        }
        if(nodePositionInScene.x>self.scene.size.width-50){
            xImpulse = (CGFloat) -PUSH_FROM_EDGE_IMPULSE;
        }
        if(nodePositionInScene.y<50){
            yImpulse = (CGFloat) PUSH_FROM_EDGE_IMPULSE;
        }
        if(nodePositionInScene.y>self.scene.size.height-100){
            yImpulse = (CGFloat) -PUSH_FROM_EDGE_IMPULSE;
        }
        
        [node.physicsBody applyImpulse:CGVectorMake(xImpulse,yImpulse)];
    }];
    
    

}

-(void)applyBrownianMotionInScene:(SKScene*) scene withNodeNames:(NSString*) name withImpulseRange:(float) impulse{
    [scene enumerateChildNodesWithName:name usingBlock:^(SKNode *node, BOOL *stop) {
        CGFloat xImpulse = [Util randFloatFrom:-impulse to:impulse];
        CGFloat yImpulse = [Util randFloatFrom:-impulse to:impulse];
        [node.physicsBody applyImpulse:CGVectorMake(xImpulse, yImpulse)];
    }];
}

@end
