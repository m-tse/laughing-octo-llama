//
//  Sun.m
//  itunesGalaxy
//
//  Created by Apple Inc. University Relations on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Sun.h"

@implementation Sun {
    SKSpriteNode *_sun;
    NSArray *_sunAnimation;
}

-(id)init {
    if(self = [super init]){
        
        // Set up animation
        NSMutableArray *sunAnimationFrames = [NSMutableArray array];
        SKTextureAtlas *sunAnimatedAtlas = [SKTextureAtlas atlasNamed:@"sunImages"];
        int numImages = sunAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"sun%d", i];
            SKTexture *temp = [sunAnimatedAtlas textureNamed:textureName];
            [sunAnimationFrames addObject:temp];
        }
        _sunAnimation = sunAnimationFrames;
        SKTexture *temp = sunAnimationFrames[0];
        _sun = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _sun.physicsBody = physBody;
        
        [self addChild:_sun];
        [self animateSun];
        
        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        label.name = @"label_name";
        label.text = @"MUSIC";
        label.fontSize = 20;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        label.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        [self addChild:label];
    }
    return self;
}

-(void)animateSun
{
    [_sun runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:_sunAnimation
                                       timePerFrame:0.2f
                                             resize:NO
                                            restore:YES]] withKey:@"sunAnimation"];
    return;
}

@end
