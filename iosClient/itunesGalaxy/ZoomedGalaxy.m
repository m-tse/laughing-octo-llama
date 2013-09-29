//
//  ZoomedGalaxy.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ZoomedGalaxy.h"
#import "Label.h"

@implementation ZoomedGalaxy
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        
        SKSpriteNode* galaxy = [[SKSpriteNode alloc] initWithImageNamed:@"galaxy1.png"];
        galaxy.name = @"ZoomedGalaxy";
        galaxy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
        galaxy.xScale = 2.5;
        galaxy.yScale = 2.5;
        
//        SKEmitterNode * Sun;
//        NSString *galaxyPath = [[NSBundle mainBundle] pathForResource:@"Sun" ofType:@"sks"];
//        Sun = [NSKeyedUnarchiver unarchiveObjectWithFile:galaxyPath];
//        SKPhysicsBody * physBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        Sun.physicsBody = physBody;
//        [self addChild:Sun];
//        
////        SKLabelNode * label = [[Label alloc] initWithFontSize:30 onNode:self inScene:scene withText:@"Apps"];
//        
//        
//        SKLabelNode * label = [SKLabelNode labelNodeWithFontNamed:@"BebasNeue"];
//        label.name = @"label_name";
//        label.text = @"Apps";
//        label.fontSize = 30;
//        SKPhysicsBody *physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:CGSizeMake(50,50)];
//        label.physicsBody = physicsBody;
//        physicsBody.affectedByGravity = false;
//        [self addChild:label];
        

        [scene addChild:self];
        [self addChild:galaxy];
//        galaxy.physicsBody.angularVelocity = -1;
    }
    return self;
}
@end
