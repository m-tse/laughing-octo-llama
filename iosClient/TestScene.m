//
//  TestScene.m
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "TestScene.h"
#import <Firebase/Firebase.h>

@implementation TestScene

Firebase *firebase;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
    }
    
    return self;
}

-(void) didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void) createSceneContents {
    [self createSongNode];
}

-(void) createSongNode {
    NSString *firebaseUrl = @"https://itunesgalaxy.firebaseio.com/songs";
    
//    void (^getSongNode)(FDataSnapshot *);
//    getSongNode = ^ (FDataSnapshot *snapshot) {
//        SKLabelNode *songLabel;
//        songLabel = [SKLabelNode labelNodeWithFontNamed:snapshot.value[@"trackName"]];
//        [songLabel setPosition:CGPointMake(200, 0)];
//        [songLabel setText:snapshot.value[@"trackName"]];
//        [songNode addChild:songLabel];
//    };

    firebase = [[Firebase alloc] initWithUrl:firebaseUrl];
    [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
        int count = 0;
        [self removeAllChildren];
        for (id key in snapshot.value) {
            if (count > 100) {
                break;
            }
            NSString *songName = snapshot.value[key][@"trackName"];
            NSLog(@"%@\n", songName);
            SKSpriteNode *songNode = [SKSpriteNode spriteNodeWithImageNamed:@"choose-custom-music"];
            [songNode setPosition:CGPointMake(200, 400+20*(++count))];
            [songNode setSize:CGSizeMake(20, 20)];
            SKLabelNode *songLabel;
            songLabel = [SKLabelNode labelNodeWithFontNamed:songName];
            [songLabel setPosition:CGPointMake(200, 0)];
            [songLabel setText:songName];
            [songLabel setFontSize:10.0];
            [songNode addChild:songLabel];
            
            [self addChild:songNode];
        }
//        getSongNode(snapshot);
    }];

}

@end
