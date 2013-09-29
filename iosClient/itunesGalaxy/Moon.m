//
//  Moon.m
//  iTunesGalaxy
//
//  Created by Tianyu Shi on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Moon.h"

@implementation Moon

-(id)init {
    if(self = [super init]){
        
        // Set up animation
        NSMutableArray *moonAnimationFrames = [NSMutableArray array];
        SKTextureAtlas *moonAnimatedAtlas = [SKTextureAtlas atlasNamed:@"moon"];
        int numImages = moonAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"moon%d", i];
            SKTexture *temp = [moonAnimatedAtlas textureNamed:textureName];
            [moonAnimationFrames addObject:temp];
        }
        _moonAnimation = moonAnimationFrames;
        SKTexture *temp = moonAnimationFrames[0];
        _moon = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _moon.physicsBody = physBody;
        _moon.xScale = 0.075;
        _moon.yScale = 0.075;
        
        [self addChild:_moon];
        [self animateMoon];
        
        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        label.name = @"label_name";
        label.text = @"Moon";
        label.fontSize = 20;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        label.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        [self addChild:label];
    }
    return self;
}

-(void)animateMoon
{
    [_moon runAction:[SKAction repeatActionForever:
                     [SKAction animateWithTextures:_moonAnimation
                                      timePerFrame:0.2f
                                            resize:NO
                                           restore:YES]] withKey:@"moonAnimation"];
    return;
}


@end
