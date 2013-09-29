//
//  ZoomedSolarSystem.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ZoomedSolarSystem.h"
#import "Sun.h"

@implementation ZoomedSolarSystem
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        
        
        SKNode* sun = [[Sun alloc] init];
        sun.position = CGPointMake(0.5, 0.5);
        [self addChild:sun];
        
        
//        SKEmitterNode * Sun;
//        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
//        Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
//        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        Sun.physicsBody = physBody;
//        [self addChild:Sun];
//        
//        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"BebasNeue"];
//        label.name = @"label_name";
//        label.text = @"Apps";
//        label.fontSize = 30;
//        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        label.physicsBody = physicsBody;
//        physicsBody.affectedByGravity = false;
//        [self addChild:label];
        
        
        //    SKEmitterNode *asdf;
        
        
        //    SKEmitterNode * galaxyArm;
        //    NSString *galaxyArmPath = [[NSBundle mainBundle] pathForResource:@"GalaxyArm" ofType:@"sks"];
        //    galaxyArm = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyArmPath];
        //
        //    SKPhysicsBody * GAphysBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(3,3)];
        //    galaxyArm.physicsBody = GAphysBody;
        //    [self addChild:galaxyArm];
        [scene addChild:self];
        
        
    }
    return self;
}
@end
