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

@implementation GalaxyScene
SKScene* myParent;

- (void)didMoveToView:(SKView *)view {
    UIPinchGestureRecognizer *gestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
        SKScene * mainScene = [[SuperClusterScene alloc] initWithSize:self.frame.size];
        mainScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:mainScene];
    }
}




-(id)initWithSize:(CGSize)size withParentScene:(SKScene*) parent{
    if (self = [super initWithSize:size]) {
        myParent = parent;
        
//        UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
//        [self.view addGestureRecognizer:(pinchRecognizer)];
        //    self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.60 alpha:1.0];
        
        SKNode* galaxy = [[ZoomedGalaxy alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
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
            if([[node name] isEqual:@"distant_galaxy"]){
                SKScene * galaxyScene = [[GalaxyScene alloc] initWithSize:self.frame.size withParentScene:self];
                galaxyScene.scaleMode = SKSceneScaleModeAspectFill;
                
                
                [self.scene.view presentScene:galaxyScene];
                break;
            }
            node = node.parent;
            
        }
        
        
        //        if ([[node name] isEqual:@"testScene"]) {
        //            SKScene *testScene = [[TestScene alloc] initWithSize:self.size];
        //            testScene.scaleMode = SKSceneScaleModeAspectFit;
        //            [self.scene.view presentScene:testScene transition:[SKTransition fadeWithDuration:1.0]];
        //            return;
        //        }
        
    }
}
@end
