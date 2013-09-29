//
//  Planet.m
//  iTunesGalaxy
//
//  Created by Tianyu Shi on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Planet.h"

@implementation Planet

-(id)init {
    if(self = [super init]){
        
        // Set up animation
        NSMutableArray *planetAnimationFrames = [NSMutableArray array];
        SKTextureAtlas *planetAnimatedAtlas = [SKTextureAtlas atlasNamed:@"planet"];
        int numImages = planetAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"planet%d", i];
            SKTexture *temp = [planetAnimatedAtlas textureNamed:textureName];
            [planetAnimationFrames addObject:temp];
        }
        _planetAnimation = planetAnimationFrames;
        SKTexture *temp = planetAnimationFrames[0];
        _planet = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _planet.physicsBody = physBody;
        _planet.xScale = 0.1;
        _planet.yScale = 0.1;
        
        [self addChild:_planet];
        [self animatePlanet];
        
        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        label.name = @"label_name";
        label.text = @"planet";
        label.fontSize = 20;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        label.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        [self addChild:label];
    }
    return self;
}

-(void)animatePlanet
{
    [_planet runAction:[SKAction repeatActionForever:
                      [SKAction animateWithTextures:_planetAnimation
                                       timePerFrame:0.1f
                                             resize:NO
                                            restore:YES]] withKey:@"planetAnimation"];
    return;
}

@end
