//
//  Galaxy.m
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Galaxy.h"

@implementation Galaxy
- (SKNode*) Galaxy{
    SKEmitterNode * Sun;
    NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
    Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
    SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    Sun.physicsBody = physBody;
    

    
    SKEmitterNode * galaxyArm;
    NSString *galaxyArmPath = [[NSBundle mainBundle] pathForResource:@"GalaxyArm" ofType:@"sks"];
    galaxyArm = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyArmPath];

    SKPhysicsBody * GAphysBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    galaxyArm.physicsBody = GAphysBody;
    
    [Sun addChild:(galaxyArm)];
    
    
    
    
    return Sun;
}
@end
