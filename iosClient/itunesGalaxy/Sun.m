//
//  Sun.m
//  itunesGalaxy
//
//  Created by Apple Inc. University Relations on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Sun.h"

@implementation Sun 

-(id)init {
    if(self = [super init]){
        
        // Set up animation
        NSMutableArray *sunAnimationFrames = [NSMutableArray array];
        SKTextureAtlas *sunAnimatedAtlas = [SKTextureAtlas atlasNamed:@"sun"];
        int numImages = sunAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"sun%d", i];
            SKTexture *temp = [sunAnimatedAtlas textureNamed:textureName];
            [sunAnimationFrames addObject:temp];
        }
        _customAction = [SKAction repeatActionForever:
                         [SKAction animateWithTextures:sunAnimationFrames
                                          timePerFrame:0.2f
                                                resize:NO
                                               restore:YES]];;
        
        SKTexture *temp = sunAnimationFrames[0];
        _body = [SKSpriteNode spriteNodeWithTexture:temp];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _body.physicsBody = physBody;
        
        [self addChild:_body];
        [self runCustomAction];
        
        _labelNode = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
        _labelNode.name = @"label_name";
        _labelNode.text = @"Sun";
        _labelNode.fontSize = 20;
        
        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _labelNode.physicsBody = physicsBody;
        physicsBody.affectedByGravity = false;
        [self addChild:_labelNode];
    }
    return self;
}

@end
