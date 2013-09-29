//
//  TestScene.h
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "AbstractSpaceScene.h"
#import <SpriteKit/SpriteKit.h>

@interface SongPlanetScene : AbstractSpaceScene

@property bool contentCreated;
@property SKScene *myParent;
@property NSString *myGenre;

-(void) createSceneContents;
-(id) initWithSize:(CGSize)size genreName:(NSString *)genreName;
@end
