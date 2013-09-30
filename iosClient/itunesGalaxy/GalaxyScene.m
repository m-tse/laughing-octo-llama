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
#import "SongPlanetScene.h"
#import "AppPlanetScene.h"

@implementation GalaxyScene

@synthesize genre;

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

-(id)initWithSize:(CGSize)size genreName:(NSString *)genreName {
    if (self = [super initWithSize:size]) {
        [self setGenre:genreName];
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];

        SKNode* galaxy = [[ZoomedGalaxy alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-80);
        galaxy.position = position;
     
    
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
            if([[node name] isEqual:@"ZoomedGalaxy"]){
                SKScene *solarSystemScene;
                if ([genre isEqualToString:@"Apps"]) {
                    solarSystemScene = [[AppPlanetScene alloc] initWithSize:self.frame.size genreName:genre];
                } else {
                    solarSystemScene = [[SongPlanetScene alloc] initWithSize:self.frame.size genreName:genre];
                }
                solarSystemScene.scaleMode = SKSceneScaleModeAspectFill;
                
                SKAction *zoom = [SKAction scaleBy:2.0 duration:1.0];
                SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0];
                SKAction *group = [SKAction group:@[zoom, fadeOut]];
                [self runAction:group completion:^{
                    [self.scene.view presentScene:solarSystemScene];
                }];
                
                
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
//    [self.scene enumerateChildNodesWithName:@"//*" usingBlock:^(SKNode *node, BOOL *stop) {
//        if([node.name  isEqual: @"galaxyLabel"]){
//            node.physicsBody.angularVelocity = 0.05;
//            
//        }
//    }];

}

@end
