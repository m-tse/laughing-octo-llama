//
//  DistantSuperCluster.m
//  itunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "DistantSuperCluster.h"

@implementation DistantSuperCluster
- (SKNode*) DistantSuperCluster{
    SKEmitterNode * galaxySpawner;
    NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
    galaxySpawner = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
    
    SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
    galaxySpawner.physicsBody = physBody;
    
    physBody.affectedByGravity = false;
    return galaxySpawner;
}
@end
