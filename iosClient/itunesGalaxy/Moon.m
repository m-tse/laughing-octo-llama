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
        
        _customAction = [SKAction repeatActionForever:
                         [SKAction animateWithTextures:moonAnimationFrames
                                          timePerFrame:0.2f
                                                resize:NO
                                               restore:YES]];
        SKTexture *temp = moonAnimationFrames[0];
        _body = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _body.physicsBody = physBody;
        _body.xScale = 0.075;
        _body.yScale = 0.075;
        
        [self addChild:_body];
        [self runCustomAction];
        
        _labelNode = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        _labelNode.name = @"label_name";
        _labelNode.text = @"Moon";
        _labelNode.fontSize = 20;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _labelNode.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        [self addChild:_labelNode];
    }
    return self;
}

@end