//
//  TestScene.m
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "TestScene.h"
#import <Firebase/Firebase.h>
#import "Song.h"

@implementation TestScene

Firebase *firebase;
SKShapeNode *innerCircle;
SKShapeNode *outerCircle;
NSMutableArray *songNodes;

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.05 alpha:1.0];
    }
    songNodes = [[NSMutableArray alloc] init];
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
    NSString *galaxyParticlePath = [[NSBundle mainBundle] pathForResource:@"Galaxy" ofType:@"sks"];
    SKEmitterNode *galaxyParticle = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyParticlePath];
    [galaxyParticle setPosition:CGPointMake(200, 200)];
    [self addChild:galaxyParticle];
    [self drawCircleScroll];
    [self drawSongCircle];
}

-(void) drawCircleScroll {
    innerCircle = [[SKShapeNode alloc] init];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddArc(circlePath, NULL, 768/2, 1024/2, 150, 0, M_PI*2, YES);
    innerCircle.path = circlePath;
    innerCircle.lineWidth = 1.0;
    innerCircle.fillColor = [SKColor clearColor];
    innerCircle.strokeColor = [SKColor whiteColor];
    innerCircle.glowWidth = 0.5;
    [self addChild:innerCircle];
}

-(void) drawSongCircle {
    outerCircle = [[SKShapeNode alloc] init];
    CGMutablePathRef circlePath = CGPathCreateMutable();
    CGPathAddArc(circlePath, NULL, 768/2, 1024/2, 250, 0, M_PI*2, YES);
    outerCircle.path = circlePath;
    outerCircle.lineWidth = 1.0;
    outerCircle.fillColor = [SKColor clearColor];
    outerCircle.strokeColor = [SKColor clearColor];
    outerCircle.glowWidth = 0.5;
    [self addChild:outerCircle];
}

-(void) createSongNode {
    NSString *firebaseUrl = @"https://itunesgalaxy.firebaseio.com/songs";

    firebase = [[Firebase alloc] initWithUrl:firebaseUrl];
    [firebase observeEventType:FEventTypeValue withBlock:^(FDataSnapshot *snapshot){
        int count = 0;
        for (id key in snapshot.value) {
            if (count > 10) {
                break;
            }
            NSString *songName = snapshot.value[key][@"trackName"];
            Song *song = [[Song alloc] initSong:songName index:count];
            [songNodes addObject:song];
            ++count;
            [self addChild:song.songNode];
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
    float timeElapsed = [[NSDate date] timeIntervalSinceDate:touchTimer] * 1000.0f;
    touchTimer = [NSDate date];
    for (UITouch *touch in touches) {
        float xDifference = lastXLocation - [touch locationInNode:self].x;
        lastXLocation = [touch locationInNode:self].x;
        if (xDifference < 0) {
            
        }
        break;
    }
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    NSObject * obj = [touches anyObject];
    // The time at which the touches ended
    //
    endTime = CACurrentMediaTime();
    if (obj != nil) {
        CGPoint p = [(UITouch *)obj locationInNode:self];
        CGPoint o = [(UITouch *)obj previousLocationInNode:self];
        // Translation only, not real distance between points
        //
        int deltay = p.y - o.y;
        // This is how much we have moved since we started dragging
        // defined as an integer property of the view controller
        //
        cumulativeDeltaY = cumulativeDeltaY + deltay;
        CGRect r = [self frame];
        // Put a cap on what the speed can be, so we
        // don't have to deal with absurdly fast flicks.
        // Also, treat a tiny move as no move at all - you don't want a
        // tiny move causing a large drift.
        //
        int maxSpeed = 80;
        // Find out the how long the touches lasted
        //
        float timeDifference = endTime - startTime;
        // Chose 0.35 after some trial and error.  It seemed like the most
        // natural amount
        //
        if (timeDifference < 0.35) {
            // The flick was really fast.  Use Distance/Time to
            // calculate speed.  It will likely be accurate.
            // Get the current location in the parent view
            //
            o = [(UITouch *)obj locationInNode:self];
            // Calculate the speed as distance/time.  Use some scaling
            // to get the speed to be comparable to a normal flick.
            //
            deltay = (o.y - previousLocation.y) / (timeDifference * 10);
        }
        if      (deltay > maxSpeed)         { deltay =  maxSpeed; }
        else if (deltay < -maxSpeed)        { deltay = -maxSpeed; }
        else if (deltay > -5 && deltay < 5) { return; }
        double duration = 0.5;
        // Chose 10 after trial and error because
        // the results 'looked right'
        //
        int finalDistance = deltay * 10;
        r.origin.y += finalDistance;
        // Animate the view with an EaseOut curve so that it slows down.
        //
        for (Song *song in songNodes) {
            CGMutablePathRef movePath = CGPathCreateMutable();
            CGFloat newX = 200*cosf(finalDistance + [song.songNode position].x);
            CGFloat newY = 200*sinf(finalDistance + [song.songNode position].y);
            NSLog(@"%f - %f", newX, newY);
//            CGPathMoveToPoint(movePath, NULL, newX, newY);
            float currentAngle = [song angle];
            float nextAngle = currentAngle + M_PI/5;
            song.angle = nextAngle;
            
            CGPathAddArc(movePath, NULL, 768/2, 1024/2, 200.0, currentAngle, nextAngle, YES);
//            CGPathAddArcToPoint(movePath, NULL, [song position].x+0.001, [song position].y+0.001, newX+0.001, newY+0.001, 100);
            SKAction *move = [SKAction followPath:movePath asOffset:NO orientToPath:NO duration:1.5];
            [song.songNode runAction:move];
            NSLog(@"POSITION : %f - %f", [song.songNode position].x, [song.songNode position].y);
        }
        
    }
}

-(void) touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    
}

@end
