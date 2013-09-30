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
//#import "iTunesCurrentNode.h"
#import "SuperClusterScene.h"
#import <AVFoundation/AVFoundation.h>
#import "ZoomedSolarSystem.h"
#import <UIKit/UIKit.h>

@implementation SongPlanetScene

@synthesize myGenre;
@synthesize mediaType;
@synthesize myGenreId;
@synthesize songArtistLabel;
@synthesize songNameLabel;
@synthesize songImage;

Firebase *firebase;
SKShapeNode *innerCircle;
SKNode *outerCircle;
NSMutableArray *invisibleSongNodes;
NSMutableArray *visibleSongNodes;
Song *current;
int rotationCount;
UIImage *songUIImage;


+(void) playMySong {
    SongPlanetScene *songScene = [[SongPlanetScene alloc] init];
    [songScene playAudioUrl:@"http://a1934.phobos.apple.com/us/r1000/120/Music/v4/3e/06/15/3e06155f-49ce-4704-7fca-0b46034daa79/mzaf_757850183412465295.aac.m4a"];
}

+(void) playDemons {
    SongPlanetScene *songScene = [[SongPlanetScene alloc] init];
    [songScene playAudioUrl:@"http://a1630.phobos.apple.com/us/r1000/120/Music/d4/6b/aa/mzi.celfzkmf.aac.p.m4a"];
}


-(id)initWithSize:(CGSize)size genreName:(NSString *)genreName mediaType:(NSString*) mediaType{
    if (self = [super initWithSize:size]) {
        [self setMyGenre:genreName];
        [self setMediaType:mediaType];
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
        invisibleSongNodes = [[NSMutableArray alloc] init];
        visibleSongNodes = [[NSMutableArray alloc] init];
        rotationCount = 0;
        [self getGenreId];
        [self setUpSongLabels];
        
        self.physicsBody = [SKPhysicsBody bodyWithEdgeLoopFromRect:self.frame];
        
        SKNode* galaxy = [[ZoomedSolarSystem alloc] initWithScene:self];
        CGPoint position = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
        galaxy.position = position;
        
        
        return self;
    }
    return nil;
}

-(void) goToSongInfo:(Song *)song {
    NSLog(@"working - %@\n", [song collectionViewUrl]);
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString: [song collectionViewUrl]]];
}

-(void) getSongImage:(Song *)song {
    NSString *imageUrl = [song imageUrl];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    songUIImage = [[UIImage alloc] initWithData:data];
    UIImageView *songPicture = [[UIImageView alloc] initWithFrame:CGRectMake(768/2-75, 1024/2-75-20, 150, 150)];
    [songPicture setImage:songUIImage];
    [songArtistLabel setText:[song artistName]];
    [songNameLabel setText:[song songName]];

    [self.view addSubview:songPicture];
}

-(void) setUpSongLabels {
    songNameLabel = [[SKLabelNode alloc] initWithFontNamed:@"bebasneue"];
    [songNameLabel setPosition:CGPointMake(768/2, 1024/2-100)];
    [songNameLabel setFontSize:40.0];
    [self addChild:songNameLabel];
    

    songArtistLabel = [[SKLabelNode alloc] initWithFontNamed:@"bebasneue"];
    [songArtistLabel setPosition:CGPointMake(768/2, 1024/2-120)];
    [songArtistLabel setFontSize:20.0];
    [self addChild:songArtistLabel];
}

- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
	if (recognizer.state == UIGestureRecognizerStateEnded) {
//        SKScene * mainScene = [iTunesCurrentNode getCurrentScene];
//        mainScene.scaleMode = SKSceneScaleModeAspectFill;
//        [self.scene.view presentScene:mainScene];
        
        SKScene * galaxyScene = [[SuperClusterScene alloc] initWithSize:self.frame.size mediaType:@"Songs"];
        galaxyScene.scaleMode = SKSceneScaleModeAspectFill;
        [self.scene.view presentScene:galaxyScene];
    }
}

CGPoint lastTappedLocation;

-(void) didMoveToView:(SKView *)view {
    if (!self.contentCreated) {
        [self createSceneContents];
        UITapGestureRecognizer *doubleTapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleDoubleTap:)];
        doubleTapRecognizer.numberOfTapsRequired = 2;
        [[self view] addGestureRecognizer:doubleTapRecognizer];
        
        self.contentCreated = YES;
    }
}


-(void) handleDoubleTap:(UITapGestureRecognizer *)recognizer {
    if (recognizer.state == UIGestureRecognizerStateRecognized) {

//        NSLog(@"(%f, %f) ==== (%f, %f)\n", currentLocation.x, currentLocation.y, songNode.position.x, songNode.position.y);
        if (current) {
            [self goToSongInfo:current];
        }

    }
}

-(void) createSceneContents {
    [self createSongNode];
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
            NSString *imageUrl = snapshot.value[[self myGenre]][song][@"artworkUrl100"];
            NSString *artistName = snapshot.value[[self myGenre]][song][@"artistName"];
            NSString *collectionView = snapshot.value[[self myGenre]][song][@"trackViewUrl"];
            Song *song = [[Song alloc] initSong:songName index:count prevUrl:previewUrl imUrl:imageUrl artist:artistName collectionView:collectionView];
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

- (void) updateCenter {
    
}

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
    NSObject * obj = [touches anyObject];
    
    CGPoint currentLocation = [(UITouch *)obj locationInNode:self];
    SKSpriteNode * node = (SKSpriteNode *)[self nodeAtPoint:currentLocation];
    for (Song *song in visibleSongNodes) {
        if ([[song songNode] isEqual:node]) {
            current = song;
            [self playAudioUrl:[song previewUrl]];
            [self getSongImage:song];
            break;
        }
    }
    
    NSLog(@"%f - %f\n", currentLocation.x, previousLocation.x);
    bool goRight = true;
    if (previousLocation.x - currentLocation.x > 14) {
        goRight = false;
    } else if (currentLocation.x - previousLocation.x < 14) {
        return;
    }
    
    if ([invisibleSongNodes count] < 1) {
        return;
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
            if (goRight) {
                [current.songNode runAction:[SKAction rotateToAngle:M_PI/5*rotationCount duration:0]];
            } else {
                [current.songNode runAction:[SKAction rotateToAngle:-M_PI/5*rotationCount duration:0]];
            }
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
        SKAction *rotate;
        if (goRight) {
            rotate = [SKAction rotateByAngle:M_PI/5 duration:0.5];
        } else {
            rotate = [SKAction rotateByAngle:-M_PI/5 duration:0.5];
        }

        [current.songNode runAction:rotate];
    }
    [visibleSongNodes removeObject:moveToInvisible];
    [visibleSongNodes addObject:moveToVisible];
    SKAction *rotate;
    if (goRight) {
        rotate = [SKAction rotateByAngle:-M_PI/5 duration:0.5];
    } else {
        rotate = [SKAction rotateByAngle:M_PI/5 duration:0.5];
    }
    [outerCircle runAction:rotate];
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

AVPlayer *player;
bool isPlaying = false;
NSString *lastPlayedUrl = @"";

-(void) playAudioUrl:(NSString *)urlString {
    if (isPlaying && [urlString isEqualToString:lastPlayedUrl]) {
        [player pause];
        isPlaying = false;
    } else {
        NSURL *url = [NSURL URLWithString:urlString];
        player = [AVPlayer playerWithURL:url];
        [player play];
        isPlaying = true;
        lastPlayedUrl = urlString;
    }
}

//-(void)update:(CFTimeInterval)currentTime {
//    //Send things away from the edges
//    [self.scene enumerateChildNodesWithName:@"//*" usingBlock:^(SKNode *node, BOOL *stop) {
//        if([node.name isEqual: @"planet"]){
////            CGFloat xImpulse = 50;
////            CGFloat yImpulse = 50;
////            [node.physicsBody applyImpulse:CGVectorMake(xImpulse, yImpulse)];
//        }
//    }];
//    
//    
//}


//- (void)didMoveToView:(SKView *)view {
//    UIPinchGestureRecognizer *gestureRecognizer = [[UIPinchGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanFrom:)];
//    [[self view] addGestureRecognizer:gestureRecognizer];
//}
//
//- (void)handlePanFrom:(UIPinchGestureRecognizer *)recognizer {
//	if (recognizer.state == UIGestureRecognizerStateEnded) {
//        SKScene * prevScene = [[GalaxyScene alloc] initWithSize:<#(CGSize)#> genreName:<#(NSString *)#> mediaType:<#(NSString *)#>
////        SKScene * mainScene = [iTunesCurrentNode getCurrentScene];
//        mainScene.scaleMode = SKSceneScaleModeAspectFill;
//                               [self.scene.view presentScene:mainScene];
//                               }
//}

@end
