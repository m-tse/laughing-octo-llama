//
//  iTunesRoot.h
//  itunesGalaxy
//
//  Created by Andrew Shim on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface iTunesCurrentNode : NSObject 

+(void) setCurrentScene:(SKScene *)scene;
+(SKScene *) getCurrentScene;
+(void) updateCurrentScene: (SKScene *)scene;
+(void) setPreviousScene:(SKScene *)scene;
+(SKScene *) getPreviousScene;

@end
