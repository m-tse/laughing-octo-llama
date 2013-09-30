//
//  Galaxy.m
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantGalaxy.h"
#import "Util.h"
#import "Label.h"

@implementation DistantGalaxy

@synthesize myGenreName;

-(id)initWithScene:(SKScene *)scene genreName:(NSString *)genreName mediaType:(NSString *)mediaType{
    if(self = [super init]){
        
        SKSpriteNode *galaxy;

        self.name = @"distant_galaxy";

        // Set up galaxy
        int galaxyType = [Util randIntFrom:1 to:10];
        
        SKTextureAtlas *galaxyAnimatedAtlas = [SKTextureAtlas atlasNamed:@"galaxy"];
        NSString *textureName = [NSString stringWithFormat:@"galaxy%d", galaxyType];
        SKTexture *temp = [galaxyAnimatedAtlas textureNamed:textureName];
        galaxy = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(15,15)];
        galaxy.physicsBody = physBody;
        

        int randomNum = [Util randIntFrom:3 to:5];
        randomNum = randomNum/15.0;
        
        galaxy.xScale = 0.6;
        galaxy.yScale = 0.6;
        
        [self addChild:galaxy];
        [scene addChild:self];
        
        [self animateGalaxy:galaxy];
        [self setMyGenreName:genreName];
        [self setMyMediaType:mediaType];
        

//        Label* label = [[Label alloc] initWithFontSize:5 onNode:self inScene:scene withText:genreName];

        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        label.name = @"label_name";
        label.text = genreName;
        label.fontSize = 15;
        label.horizontalAlignmentMode = 0;
        label.verticalAlignmentMode = 0;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:galaxy.size.width * 0.6];

        label.physicsBody = physicsBody;
//        label.position = _galaxy.position;
//
        [self addChild:label];
        SKPhysicsJointFixed *spring = [SKPhysicsJointFixed jointWithBodyA:physBody bodyB:physicsBody anchor:CGPointMake(0,0)];
        [self.scene.physicsWorld addJoint:spring];

//        [label linkLabelWithNode:self inPhysicsWorld:scene.physicsWorld];
    }
    return self;
}


-(void)animateGalaxy:(SKSpriteNode*) galaxy
{
    [galaxy runAction:[SKAction repeatActionForever:
                        [SKAction rotateByAngle:([Util randIntFrom:0 to:3] - 1.5)
                                       duration:25]]];
    return;
}

@end
