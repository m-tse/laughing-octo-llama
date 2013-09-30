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
//        self.name = @"planet";
        // Set up animation
        NSMutableArray *planetAnimationFrames = [NSMutableArray array];
        SKTextureAtlas *planetAnimatedAtlas = [SKTextureAtlas atlasNamed:@"planet"];
        int numImages = planetAnimatedAtlas.textureNames.count;
        for (int i=1; i <= numImages; i++) {
            NSString *textureName = [NSString stringWithFormat:@"planet%d", i];
            SKTexture *temp = [planetAnimatedAtlas textureNamed:textureName];
            [planetAnimationFrames addObject:temp];
        }
        
        _customAction = [SKAction repeatActionForever:
                         [SKAction animateWithTextures:planetAnimationFrames
                                          timePerFrame:0.1f
                                                resize:NO
                                               restore:YES]];
        
        SKTexture *temp = planetAnimationFrames[0];
        _body = [SKSpriteNode spriteNodeWithTexture:temp];
        _body.name = @"planet";
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _body.physicsBody = physBody;
        
        // Planet Size
        _body.xScale = 0.1;
        _body.yScale = 0.1;
        
        [self addChild:_body];
        [self runCustomAction];
        
//        _labelNode = [SKLabelNode labelNodeWithFontNamed:@"bebasneue"];
//        _labelNode.name = @"label_name";
//        _labelNode.text = @"planet";
//        _labelNode.fontSize = 20;
        
//        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        _labelNode.physicsBody = physicsBody;
//        physicsBody.affectedByGravity = false;
//        [self addChild:_labelNode];
    }
    return self;
}

@end
