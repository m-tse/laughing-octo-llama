//
//  HeavenlyBodies.m
//  itunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "HeavenlyBodies.h"

@implementation HeavenlyBodies

- (SKEmitterNode *)galaxy
{
    SKEmitterNode * galaxySpawner;
    NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    galaxySpawner = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
    
    SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(100,100)];
    galaxySpawner.physicsBody = physBody;
    
    [physBody applyAngularImpulse:50];
    physBody.affectedByGravity = false;
    galaxySpawner.name = @"rotating_galaxy";
    return galaxySpawner;
}

- (SKLabelNode *)galaxyLabel
{
    SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    label.name = @"label_name";
    label.text = @"Apps";
    label.fontSize = 30;
    SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    label.physicsBody = physicsBody;
    physicsBody.affectedByGravity = false;
    return label;
}
@end
