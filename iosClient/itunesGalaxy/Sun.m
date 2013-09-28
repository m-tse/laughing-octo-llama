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
        
        SKSpriteNode *body;
        
//        // Set up animation
//        NSMutableArray *animationFrames = [NSMutableArray array];
//        SKTextureAtlas *sunAnimatedAtlas = [SKTextureAtlas atlasNamed:@"sunImages"];
//        int numImages = sunAnimatedAtlas.textureNames.count;
//        for (int i=1; i <= numImages; i++) {
//            NSString *textureName = [NSString stringWithFormat:@"sun%d", i];
//            SKTexture *temp = [sunAnimatedAtlas textureNamed:textureName];
//            [animationFrames addObject:temp];
//        SKTexture *temp = _sunAnimation[0];
//        body = [SKSpriteNode spriteNodeWithTexture:temp];
//
//        SKEmitterNode * Sun;
//        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
//        Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
//        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        Sun.physicsBody = physBody;
//        [self addChild:Sun];
//        
//        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
//        label.name = @"label_name";
//        label.text = @"Apps";
//        label.fontSize = 30;
//        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        label.physicsBody = physicsBody;
//        physicsBody.affectedByGravity = false;
//        [self addChild:label];
//        
//        SKEmitterNode * galaxyArm;
//        NSString *galaxyArmPath = [[NSBundle mainBundle] pathForResource:@"GalaxyArm" ofType:@"sks"];
//        galaxyArm = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyArmPath];
//        
//        SKPhysicsBody * GAphysBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(3,3)];
//        galaxyArm.physicsBody = GAphysBody;
        
//        [self addChild:galaxyArm];
    }
    return self;
}

@end
