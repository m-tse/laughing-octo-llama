//
//  GalaxyScene.h
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "AbstractSpaceScene.h"

@interface GalaxyScene : AbstractSpaceScene

@property NSString *genre;
@property NSString *mediaType;

-(id)initWithSize:(CGSize)size genreName:(NSString *)genreName mediaType:(NSString*)mediaType;

@end
