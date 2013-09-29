//
//  GalaxyScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "GalaxyScene.h"
#import "ZoomedGalaxy.h"
#import "SuperClusterScene.h"
#import "iTunesCurrentNode.h"
#import "SolarSystemScene.h"
#import "DistantSolarSystem.h"

@implementation GalaxyScene

- (void)didMoveToView:(SKView *)view {
    UIPinchGestureRecognizer *gestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
        SKScene * mainScene = [iTunesCurrentNode getCurrentScene];
        mainScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:mainScene];
    }
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

        SKNode* galaxy = [[ZoomedGalaxy alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-50);
        galaxy.position = position;
     
        
        SKNode* distantSolarSystem = [[DistantSolarSystem alloc] initWithScene:self.scene];
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
            if([[node name] isEqual:@"distant_galaxy"]){
                SKScene * solarSystemScene = [[SolarSystemScene alloc] initWithSize:self.frame.size];
                solarSystemScene.scaleMode = SKSceneScaleModeAspectFill;
                
                
                [self.scene.view presentScene:solarSystemScene];
                break;
            }
            node = node.parent;
            
        }
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    [self.scene enumerateChildNodesWithName:@"//*" usingBlock:^(SKNode *node, BOOL *stop) {
        if([node.name  isEqual: @"ZoomedGalaxy"]){
            node.physicsBody.angularVelocity = -0.05;

        }
    }];

}

@end
