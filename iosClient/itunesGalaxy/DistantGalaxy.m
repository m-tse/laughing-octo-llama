//
//  Galaxy.m
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantGalaxy.h"

@implementation DistantGalaxy

-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        self.name = @"distant_galaxy";

        // Set up animation
        NSMutableArray *galaxyAnimationFrames = [NSMutableArray array];
        SKTextureAtlas *galaxyAnimatedAtlas = [SKTextureAtlas atlasNamed:@"galaxy"];
        int numImages = galaxyAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"galaxy%d", i];
            SKTexture *temp = [galaxyAnimatedAtlas textureNamed:textureName];
            [galaxyAnimationFrames addObject:temp];
        }
        _galaxyAnimation = galaxyAnimationFrames;
        SKTexture *temp = galaxyAnimationFrames[0];
        _galaxy = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _galaxy.physicsBody = physBody;
        
        [self addChild:_galaxy];
        [self animateGalaxy];
        
        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        label.name = @"label_name";
        label.text = @"Galaxy";
        label.fontSize = 20;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        label.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        [self addChild:label];
        [scene addChild:self];
    }
    return self;
}

-(void)animateGalaxy
{
    [_galaxy runAction:[SKAction repeatActionForever:
                        [SKAction rotateByAngle:-3.14
                                       duration:20]]];
    return;
}

@end
