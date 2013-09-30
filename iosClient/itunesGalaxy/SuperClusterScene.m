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
        
        NSArray *a = [NSArray arrayWithObjects:@"Classical", @"Electronic", @"House", @"Rock", @"Alternative", nil];
        NSArray *b = [NSArray arrayWithObjects:@"Hip Hop", @"Pop", nil];
        
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        NSString *firebaseUrl;
        if ([mediaType isEqualToString:@"Apps"]) {
            firebaseUrl = @"https://igalaxy.firebaseio.com/apps";
        } else if ([mediaType isEqualToString:@"Songs"]) {
            firebaseUrl = @"https://igalaxy.firebaseio.com/songs";
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
                SKNode* galaxy = [[DistantGalaxy alloc] initWithScene:self genreName:genreName mediaType:mediaType];
                
                if([a containsObject:genreName]) {
                    galaxy.xScale = 2;
                    galaxy.yScale = 2;
                } else if ([b containsObject:genreName]) {
                    galaxy.xScale = 4;
                    galaxy.yScale = 4;
                }
                
                CGPoint position = CGPointMake([Util randIntFrom:200 to:self.frame.size.width-200], [Util randIntFrom:200 to:self.frame.size.height-200]);
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
                SKScene * galaxyScene = [[GalaxyScene alloc] initWithSize:self.frame.size genreName:genreName mediaType:galaxy.myMediaType];
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
