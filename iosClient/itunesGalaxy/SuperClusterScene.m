//
//  SuperClusterScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "SuperClusterScene.h"
#import "AbstractSpaceScene.h"
#import "DistantGalaxy.h"
#import "Util.h"
#import "GalaxyScene.h"


@implementation SuperClusterScene

int NUMGALAXIES = 10;

-(void) upOneLevel{
    NSLog(@"asf");
}
-(void)handlePinch:(UIPinchGestureRecognizer*)sender {
    NSLog(@"asdf");
}

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
//        SKAction* upOneLevel = [[SKAction alloc] init];
//        upOneLevel.
        
        UIPinchGestureRecognizer* pinchRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePinch:)];
        [self.view addGestureRecognizer:(pinchRecognizer)];
//    self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.60 alpha:1.0];
        
        for(int i=0;i<NUMGALAXIES;i++){
            SKNode* galaxy = [[DistantGalaxy alloc] initWithScene:self];
            CGPoint position = CGPointMake([Util randIntFrom:50 to:self.frame.size.width-50], [Util randIntFrom:50 to:self.frame.size.height-50]);
            galaxy.position = position;
        }
        
//        SKNode * zoomedCluster = [[ZoomedSuperCluster alloc] initWithScene:self];
//        zoomedCluster.position = CGPointMake(size.width/2, size.height/2);
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
