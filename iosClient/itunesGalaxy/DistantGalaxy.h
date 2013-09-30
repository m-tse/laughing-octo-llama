//
//  Galaxy.h
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DistantGalaxy : SKNode

@property NSString *myGenreName;
@property NSString *myMediaType;

-(id)initWithScene:(SKScene *)scene genreName:(NSString *)genreName mediaType:(NSString *)mediaType;

@end
