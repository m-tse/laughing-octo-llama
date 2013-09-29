//
//  GalaxyScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "GalaxyScene.h"
#import "ZoomedGalaxy.h"

@implementation GalaxyScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {

        
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
                SKScene * galaxyScene = [[GalaxyScene alloc] initWithSize:self.frame.size];
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
