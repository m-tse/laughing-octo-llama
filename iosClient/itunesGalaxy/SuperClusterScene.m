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
#import "SongPlanetScene.h"
#import <Firebase/Firebase.h>


@implementation SuperClusterScene

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

-(id)initWithSize:(CGSize)size mediaType:(NSString *)mediaType {
    if (self = [super initWithSize:size]) {
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        NSString *firebaseUrl;
        if ([mediaType isEqualToString:@"Apps"]) {
            firebaseUrl = @"https://igalaxy.firebaseio.com/genres/apps";
        } else if ([mediaType isEqualToString:@"Songs"]) {
            firebaseUrl = @"https://igalaxy.firebaseio.com/songs";
        } else if ([mediaType isEqualToString:@"TV Shows"]) {
            firebaseUrl = @"https://igalaxy.firebaseio.com/genres/shows";
        } else {
            [NSException raise:@"Invalid media type" format:@"Type: %@\n", mediaType];
        }
        Firebase *firebase = [[Firebase alloc] initWithUrl:firebaseUrl];
        [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            int count = 0;
            for (id key in snapshot.value) {
                if (count > 10) {
                    break;
                }
                NSString *genreName = key;
                SKNode* galaxy = [[DistantGalaxy alloc] initWithScene:self genreName:genreName];
                CGPoint position = CGPointMake([Util randIntFrom:50 to:self.frame.size.width-50], [Util randIntFrom:50 to:self.frame.size.height-50]);
                galaxy.position = position;
                ++count;
            }
        }];
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

                DistantGalaxy *galaxy = (DistantGalaxy *)node;
                NSString *genreName = [galaxy myGenreName];
                SKScene * galaxyScene = [[SongPlanetScene alloc] initWithSize:self.frame.size genreName:genreName];
                galaxyScene.scaleMode = SKSceneScaleModeAspectFill;
                SKAction *zoom = [SKAction scaleBy:2.0 duration:1.0];
                SKAction *fadeOut = [SKAction fadeOutWithDuration:1.0];
                SKAction *group = [SKAction group:@[zoom, fadeOut]];
                [self runAction:group completion:^{
                    [self.scene.view presentScene:galaxyScene];
                }];
                break;
            }
            node = node.parent;
            
        }
        

        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    [super update:currentTime];
    [self applyBrownianMotionInScene:self withNodeNames:@"//*" withImpulseRange:1];
}


@end
