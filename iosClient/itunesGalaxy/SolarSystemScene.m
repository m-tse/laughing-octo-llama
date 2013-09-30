//
//  SolarSystemScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "SolarSystemScene.h"
#import "ZoomedSolarSystem.h"
#import "GalaxyScene.h"

@implementation SolarSystemScene

- (void)didMoveToView:(SKView *)view {
    UIPinchGestureRecognizer *gestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
    [[self view] addGestureRecognizer:gestureRecognizer];
}

- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {

//        SKScene * mainScene = [iTunesCurrentNode getCurrentScene];
//        mainScene.scaleMode = SKSceneScaleModeAspectFill;
//        [self.scene.view presentScene:mainScene];
    }
}

-(id)initWithSize:(CGSize)size genre:(NSString*) genre mediaType:(NSString*)mediaType{
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        SKNode* galaxy = [[ZoomedSolarSystem alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2-80);
        galaxy.position = position;
        
    }
    return self;
}
@end
