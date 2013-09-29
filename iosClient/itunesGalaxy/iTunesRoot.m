//
//  iTunesRoot.m
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "iTunesRoot.h"

@implementation iTunesRoot

static iTunesNode *singletonRootNode;

-(id) init:(SKScene *)scene name:(NSString *)name {
    if (self = [super init]) {
        [self setMyScene:scene];
        [self setMyName:name];
        return self;
    }
    return nil;
}


+(id) iTunesRootNode:(SKScene *)mainScene {
    singletonRootNode = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        singletonRootNode = [[iTunesNode alloc] init];
        [singletonRootNode setMyScene:mainScene];
        [singletonRootNode setMyName:@"root"];
    });
    return singletonRootNode;
}

@end
