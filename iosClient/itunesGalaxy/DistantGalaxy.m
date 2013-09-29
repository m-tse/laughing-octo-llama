//
//  Galaxy.m
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantGalaxy.h"

@implementation DistantGalaxy

@synthesize myGenreName;

-(id)initWithScene:(SKScene *)scene genreName:(NSString *)genreName {
    if(self = [super init]){
        self.name = @"distant_galaxy";

        // Set up galaxy
        int galaxyNumber = [self getRandomNumberBetween:1 to:10];
        
        SKTextureAtlas *galaxyAnimatedAtlas = [SKTextureAtlas atlasNamed:@"galaxy"];
        NSString *textureName = [NSString stringWithFormat:@"galaxy%d", galaxyNumber];
        SKTexture *temp = [galaxyAnimatedAtlas textureNamed:textureName];
        _galaxy = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _galaxy.physicsBody = physBody;
        
        int randomNum = [self getRandomNumberBetween:3 to:5];
        randomNum = randomNum/15.0;
        
        _galaxy.xScale = 0.3;
        _galaxy.yScale = 0.3;
        
        [self addChild:_galaxy];
        [self animateGalaxy];
        [self setMyGenreName:genreName];
        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        label.name = @"label_name";
        label.text = genreName;
        label.fontSize = 7.5;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:_galaxy.size.width * 0.6];
        label.physicsBody = physicsBody;
        label.position = _galaxy.position;
        physicsBody.affectedByGravity = false;
        [self addChild:label];
        [scene addChild:self];
    }
    return self;
}

-(int)getRandomNumberBetween:(int)from to:(int)to {
    return (int)from + arc4random() % (to-from+1);
}

-(void)animateGalaxy
{
    [_galaxy runAction:[SKAction repeatActionForever:
                        [SKAction rotateByAngle:([self getRandomNumberBetween:0 to:3] - 1.5)
                                       duration:25]]];
    return;
}

@end
