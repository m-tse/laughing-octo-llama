//
//  iTunesNode.h
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface iTunesNode : NSObject

@property NSArray *mediaTypes;
@property iTunesNode *parent;
@property NSMutableArray *children;
@property SKScene *myScene;
@property NSString *myName;

-(id) init:(SKScene *)scene name:(NSString *)name;
-(void) addChild:(iTunesNode *)child;
-(void) presentScene:(SKView *)view;


@end
