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
            firebaseUrl = @"https://igalaxy.firebaseio.com/genres/songs";
        } else if ([mediaType isEqualToString:@"TV Shows"]) {
            firebaseUrl = @"https://igalaxy.firebaseio.com/genres/shows";
        } else {
            [NSException raise:@"Invalid media type" format:@"Type: %@\n", mediaType];
        }
        Firebase *firebase = [[Firebase alloc] initWithUrl:firebaseUrl];
        [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
            for (id key in snapshot.value) {
                NSString *genreName = snapshot.value[key][@"name"];
                SKNode* galaxy = [[DistantGalaxy alloc] initWithScene:self genreName:genreName];
                CGPoint position = CGPointMake([Util randIntFrom:50 to:self.frame.size.width-50], [Util randIntFrom:50 to:self.frame.size.height-50]);
                galaxy.position = position;
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
                
                [self.scene.view presentScene:galaxyScene];
                break;
            }
            node = node.parent;
            
        }
        

        
    }
}


@end
