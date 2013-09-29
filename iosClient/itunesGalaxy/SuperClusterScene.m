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
#import "MainScene.h"


@implementation SuperClusterScene

int NUMGALAXIES = 10;
SKScene* myParent;

- (void)didMoveToView:(SKView *)view {
    UIPinchGestureRecognizer *gestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
        SKScene * mainScene = [[MainScene alloc] initWithSize:self.frame.size];
        mainScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:mainScene];
    }
}



-(id)initWithSize:(CGSize)size withParentScene:(SKScene*)parent{
    if (self = [super initWithSize:size]) {
        myParent = parent;

        for(int i=0;i<NUMGALAXIES;i++){
            SKNode* galaxy = [[DistantGalaxy alloc] initWithScene:self];
            CGPoint position = CGPointMake([Util randIntFrom:50 to:self.frame.size.width-50], [Util randIntFrom:50 to:self.frame.size.height-50]);
            galaxy.position = position;
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
            if([[node name] isEqual:@"distant_galaxy"]){
                SKScene * galaxyScene = [[GalaxyScene alloc] initWithSize:self.frame.size withParentScene:self];
                galaxyScene.scaleMode = SKSceneScaleModeAspectFill;
                
                
                [self.scene.view presentScene:galaxyScene];
                break;
            }
            node = node.parent;
            
        }
        

        
    }
}


@end
