//
//  iTunesNode.m
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "iTunesNode.h"

@implementation iTunesNode

@synthesize parent;
@synthesize children;
@synthesize myScene;
@synthesize myName;

-(id) init:(SKScene *)scene name:(NSString *)name {
    if (self = [super init]) {
        [self initMediaTypesArray];
        [self setMyScene:scene];
        [self setMyName:name];
        return self;
    }
    return nil;
}


-(void) initMediaTypesArray {
    self.mediaTypes = [[NSArray alloc] initWithObjects:@"Apps", @"Songs", @"TV Shows", nil];
}

-(void) addChild:(iTunesNode *)child {
    [child setParent:self];
    [[self children] addObject:child];
}

-(void) presentScene:(SKView *)view {
    [view presentScene:[self myScene]];
}

@end
