//
//  Galaxy.h
//  iTunesGalaxy
//
//  Created by Matthew on 9/27/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface DistantGalaxy : SKNode {
    SKSpriteNode *_galaxy;
}

@property NSString *myGenreName;

-(id)initWithScene:(SKScene *)scene genreName:(NSString *)genreName;
-(int)getRandomNumberBetween:(int)from to:(int)to;

@end
