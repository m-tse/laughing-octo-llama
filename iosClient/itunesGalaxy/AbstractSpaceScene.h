//
//  AbstractSpaceScene.h
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface AbstractSpaceScene : SKScene
-(void)applyBrownianMotionInScene:(SKScene*) scene withNodeNames:(NSString*) name;
@end
