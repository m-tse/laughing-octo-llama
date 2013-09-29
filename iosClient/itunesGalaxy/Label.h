//
//  Label.h
//  itunesGalaxy
//
//  Created by Matthew on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface Label : SKLabelNode
-(id)initWithFontSize:(int)fontSize onNode:(SKNode*) node inScene:(SKScene*) scene;
-(id)initWithFontSize:(int)fontSize onNode:(SKNode*) node inScene:(SKScene*) scene withText:(NSString*) text;

@end
