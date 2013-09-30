//
//  AppPlanetScene.h
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AppPlanetScene : SKScene

@property bool contentCreated;
@property SKScene *myParent;
@property NSString *myGenre;
@property NSString *myGenreId;
@property SKLabelNode *songNameLabel;
@property SKLabelNode *songArtistLabel;
@property SKSpriteNode *songImage;

-(void) createSceneContents;
-(id) initWithSize:(CGSize)size genreName:(NSString *)genreName;

@end
