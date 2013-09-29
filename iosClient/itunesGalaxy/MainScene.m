//
//  _LR4NFPD9GMyScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/26/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "MainScene.h"
#import "SuperClusterScene.h"
#import "DistantSuperCluster.h"
#import "DistantGalaxy.h"
#import "Sun.h"
#import "Moon.h"
#import "Planet.h"
#import "SongPlanetScene.h"
#import "iTunesCurrentNode.h"
#import "Util.h"

@implementation MainScene


NSInteger NUM_GALAXIES = 10;
float RANDOM_MOTION_IMPLUSE = 0.3;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        NSArray *mediaTypes = @[@"Apps", @"Songs"];

        for (NSString *mediaType in mediaTypes) {
            DistantSuperCluster *distantCluster = [[DistantSuperCluster alloc] initWithScene:self withLabel:mediaType];
            [distantCluster setMediaType:mediaType];
            distantCluster.position = CGPointMake([Util randFloatFrom:50 to:self.frame.size.width-50],[Util randFloatFrom:50 to:self.frame.size.height-200]);
        }
    }
    return self;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        SKPhysicsBody* body = [self.physicsWorld bodyAtPoint:location];
        SKNode * node = body.node;
        while(node != NULL){
            if([[node name] isEqual:@"BM_distantSuperCluster"]){
                DistantSuperCluster *superCluster = (DistantSuperCluster *) node;
                NSString *name = [superCluster mediaType];
                SKScene * clusterScene = [[SuperClusterScene alloc] initWithSize:self.frame.size mediaType:name];
                clusterScene.scaleMode = SKSceneScaleModeAspectFill;

                [iTunesCurrentNode updateCurrentScene:clusterScene];
                [self.view presentScene:clusterScene];
                break;
            }
            node = node.parent;
            
        }
    }
}

-(void)update:(CFTimeInterval)currentTime {
    [super update:currentTime];
    [self applyBrownianMotionInScene:self withNodeNames:@"BM_distantSuperCluster" withImpulseRange:1];
}

@end
