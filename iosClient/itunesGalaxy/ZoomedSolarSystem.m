//
//  ZoomedSolarSystem.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ZoomedSolarSystem.h"
#import "Sun.h"
#import "Planet.h"
#import "Util.h"
#import "AbstractBody.h"

@implementation ZoomedSolarSystem
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        

        
        SKEmitterNode * Sun;
        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
        Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithCircleOfRadius:100];
        Sun.physicsBody = physBody;
        [self addChild:Sun];

        
        for(int i = 0;i<5;i++){
//            SKSpriteNode* planet = [[SKSpriteNode alloc] initWithImageNamed:@"planet6.png"];
//            planet.color = [SKColor redColor];
//            planet.colorBlendFactor = 0.5;

            AbstractBody* planet = [[Planet alloc] init];
            CGFloat randomScale = [Util randFloatFrom:0.1 to:0.5];
            [planet setColor:[SKColor colorWithRed:[Util randFloatFrom:0 to:1] green:[Util randFloatFrom:0 to:1] blue:[Util randFloatFrom:0 to:1] alpha:[Util randFloatFrom:0 to:1]]];
            [planet setColorScaleFactor:[Util randFloatFrom:0 to:1]];

            [planet setScale:randomScale];
            int maxDistance = 385;
            CGPoint randPosition = CGPointMake([Util randFloatFrom:-maxDistance to:maxDistance],[Util randFloatFrom:-maxDistance to:maxDistance]);
            planet.position = randPosition;
            [self addChild:planet];

        }
        [scene addChild:self];
    }
    return self;
}
@end
