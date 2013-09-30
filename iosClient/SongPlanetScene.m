//
//  TestScene.m
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "SongPlanetScene.h"
#import <Firebase/Firebase.h>
#import "Song.h"
#import "iTunesCurrentNode.h"
#import "SuperClusterScene.h"
#import <AVFoundation/AVFoundation.h>

@implementation SongPlanetScene

@synthesize myGenre;
@synthesize myGenreId;

Firebase *firebase;
SKShapeNode *innerCircle;
SKNode *outerCircle;
NSMutableArray *invisibleSongNodes;
NSMutableArray *visibleSongNodes;
int rotationCount;

-(id)initWithSize:(CGSize)size genreName:(NSString *)genreName {
    if (self = [super initWithSize:size]) {
        [self setMyGenre:genreName];
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
        invisibleSongNodes = [[NSMutableArray alloc] init];
        visibleSongNodes = [[NSMutableArray alloc] init];
        rotationCount = 0;
        [self getGenreId];
        return self;
    }
    return nil;
}

- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
        SKScene * mainScene = [iTunesCurrentNode getCurrentScene];
        mainScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:mainScene];
        
        SKScene * galaxyScene = [[SuperClusterScene alloc] initWithSize:self.frame.size mediaType:@"Songs"];
        galaxyScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:galaxyScene];
    }
}


-(void) didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        self.contentCreated = YES;
    }
}

-(void) createSceneContents {
    [self createSongNode];
    NSString *galaxyParticlePath = [[NSBundle mainBundle] pathForResource:@"Galaxy" ofType:@"sks"];
    SKEmitterNode *galaxyParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyParticlePath];
    [galaxyParticle setPosition:CGPointMake(200, 200)];
    [self addChild:galaxyParticle];
    [self drawSongCircle];
}

-(void) drawCircleScroll {
    innerCircle = [[SKShapeNode alloc] init];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddArc(circlePath, NULL, 0, 0, 150, 0, M_PI*2, YES);
    innerCircle.path = circlePath;
    innerCircle.lineWidth = 1.0;
    innerCircle.fillColor = [SKColor clearColor];
    innerCircle.strokeColor = [SKColor whiteColor];
    innerCircle.glowWidth = 0.5;
    [outerCircle addChild:innerCircle];
}

-(void) drawSongCircle {
    outerCircle = [[SKSpriteNode alloc] init];
    outerCircle.position = CGPointMake(768/2, 1024/2);
    [self addChild:outerCircle];
    [self drawCircleScroll];
}

-(void) getGenreId {
    NSString *firebaseGenreUrl = @"https://igalaxy.firebaseio.com/genres/songs";
    Firebase *firebaseGenre = [[Firebase alloc] initWithUrl:firebaseGenreUrl];
    [firebaseGenre observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot) {
        
        for (id key in snapshot.value) {
            NSString *genreName = snapshot.value[key][@"name"];
            if ([genreName isEqualToString:[self myGenre]]) {
                NSString *id = snapshot.value[key][@"id"];
                [self setMyGenreId:id];
            }
        }
    }];
}

-(void) createSongNode {
    NSString *firebaseUrl = @"https://igalaxy.firebaseio.com/songs";
    firebase = [[Firebase alloc] initWithUrl:firebaseUrl];
    [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
        int count = 0;
        for (id song in snapshot.value[[self myGenre]]) {
            NSString *songName = snapshot.value[[self myGenre]][song][@"trackName"];
            NSString *previewUrl = snapshot.value[[self myGenre]][song][@"previewUrl"];
            Song *song = [[Song alloc] initSong:songName index:count previewUrl:previewUrl];
            if (count >= 10) {
                [invisibleSongNodes addObject:song];
            } else {
                [visibleSongNodes addObject:song];
                [outerCircle addChild:song.songNode];
            }
            ++count;
            
        }
    }];
}

-(bool) touchInSongCircle:(UITouch *)touch {
    CGPoint location = [touch locationInNode:self];
    return [outerCircle containsPoint:location] && ![innerCircle containsPoint:location];
}

NSDate *touchTimer;
float lastXLocation;
float cumulativeDeltaY;
float lastFrameOriginY;
CFTimeInterval startTime, endTime;
CGPoint previousLocation;

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    cumulativeDeltaY = 0;
    lastFrameOriginY = self.frame.origin.y;

    startTime = CACurrentMediaTime();

    NSObject * obj = [touches anyObject];
    if (obj != nil) {
        previousLocation = [(UITouch *)obj locationInNode:self];
    }
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if ([invisibleSongNodes count] <
        1) {
        return;
    }
    NSObject * obj = [touches anyObject];
    
    if (obj != nil) {
        CGPoint currentLocation = [(UITouch *)obj locationInNode:self];
        SKSpriteNode * node = (SKSpriteNode *)[self nodeAtPoint:currentLocation];
        for (Song *song in visibleSongNodes) {
            if ([[song songNode] isEqual:node]) {
                NSLog(@"SONG: %@\n", [song songName]);
                [song setSelected:true];
                [self playAudioUrl:[song previewUrl]];
                break;
            }
        }
        
        NSLog(@"%f - %f\n", currentLocation.x, previousLocation.x);
        if (currentLocation.x - previousLocation.x < 14) {
            return;
        }
    }
    
    Song *moveToInvisible, *moveToVisible;
    for (Song *song in visibleSongNodes) {
        Song *current = song;
        if (song.songIndex == 3) {
            // remove and get next
            [song.songNode removeFromParent];
            moveToInvisible = song;
            moveToVisible = (Song *)[invisibleSongNodes firstObject];
            [invisibleSongNodes removeObject:moveToVisible];
            [invisibleSongNodes addObject:song];

//            moveToVisible.angle
            current = moveToVisible;
            float x = 200.0 * cosf(M_PI/5*(3+rotationCount));
            float y = 200.0 * sinf(M_PI/5*(3+rotationCount));
            current.songNode.position = CGPointMake(x, y);
            current.songIndex = 2;
            [outerCircle addChild:current.songNode];
            [current.songNode runAction:[SKAction rotateToAngle:M_PI/5*rotationCount duration:0]];
            ++rotationCount;
            if (rotationCount > 9) {
                rotationCount = 0;
            }


        } else {
            current.angle -= M_PI/5;
            current.songIndex -= 1;
        }
        if (current.songIndex < 0) {
            current.songIndex = 9;
        }
    
        SKAction *rotate = [SKAction rotateByAngle:M_PI/5 duration:0.5];
        [current.songNode runAction:rotate];
    }
    [visibleSongNodes removeObject:moveToInvisible];
    [visibleSongNodes addObject:moveToVisible];
    SKAction *rotate = [SKAction rotateByAngle:-M_PI/5 duration:0.5];
    [outerCircle runAction:rotate];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

AVPlayer *player;

-(void) playAudioUrl:(NSString *)urlString {
    NSURL *url = [NSURL URLWithString:urlString];
    player = [AVPlayer playerWithURL:url];
    [player play];
}

@end
