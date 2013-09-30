//
//  Planet.m
//  iTunesGalaxy
//
//  Created by Tianyu Shi on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Planet.h"
#import "Util.h"

@implementation Planet

-(id)init {
    if(self = [super init]){
        
        // Set up galaxy
        int planetType = [Util randIntFrom:1 to:14];
        int speed = [Util randIntFrom:10 to:30];
        
        SKTextureAtlas *planetAtlas = [SKTextureAtlas atlasNamed:@"planet"];
        NSString *textureName = [NSString stringWithFormat:@"planet%d", planetType];
        SKTexture *temp = [planetAtlas textureNamed:textureName];
        _body = [SKSpriteNode spriteNodeWithTexture:temp];
        _body.name = @"planet";
        
        CGFloat angle = [Util randFloatFrom:-5 to:5];
        _customAction = [SKAction repeatActionForever:
                         [SKAction rotateByAngle:angle duration:speed]];
        
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
        _body.physicsBody = physBody;
        
        // Planet Size
        _body.xScale = 0.75;
        _body.yScale = 0.75;
        
        [self addChild:_body];
        [self runCustomAction];
    }
    return self;
}

@end
