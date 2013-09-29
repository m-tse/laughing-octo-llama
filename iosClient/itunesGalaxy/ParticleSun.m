//
//  ParticleSun.m
//  itunesGalaxy
//
//  Created by Matthew on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ParticleSun.h"

@implementation ParticleSun

-(id)init {
    if(self = [super init]){
        NSString *clusterPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
        self = [NSKeyedUnarchiver unarchiveObjectWithFile:clusterPath];
    }
//    return cluster;
    return self;
}

@end
