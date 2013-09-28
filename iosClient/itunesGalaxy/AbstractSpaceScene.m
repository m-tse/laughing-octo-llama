//
//  AbstractSpaceScene.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "AbstractSpaceScene.h"

@implementation AbstractSpaceScene
-(id)initWithSize:(CGSize) size {
    
    if(self = [super initWithSize:size]){
        self.backgroundColor = [SKColor colorWithRed:0.05 green:0.05 blue:0.1 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, 0);
        
        // Create background particles
        NSString *backgroundPath = [[NSBundle mainBundle] pathForResource:@"Background" ofType:@"sks"];
        SKEmitterNode * spawnBackground;
        spawnBackground = [NSKeyedUnarchiver unarchiveObjectWithFile:backgroundPath];
        spawnBackground.position = CGPointMake(500, 500);
        [self addChild:spawnBackground];
    }
    return self;
}
@end
