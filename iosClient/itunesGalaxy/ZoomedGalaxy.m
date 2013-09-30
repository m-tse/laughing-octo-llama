//
//  ZoomedGalaxy.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "ZoomedGalaxy.h"
#import "Label.h"
#import "DistantSolarSystem.h"
#import "Util.h"

@implementation ZoomedGalaxy
-(id)initWithScene:(SKScene *)scene {
    if(self = [super init]){
        
        SKSpriteNode* galaxy = [[SKSpriteNode alloc] initWithImageNamed:@"galaxy_large.png"];
        galaxy.name = @"ZoomedGalaxy";
        galaxy.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:350];
        galaxy.xScale = 0.6;
        galaxy.yScale = 0.6;
        
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
        

//        SKNode* distantSolarSystem = [[DistantSolarSystem alloc] init];
        for(int i = 0;i<8;i++){
            SKLabelNode* label = [[SKLabelNode alloc] initWithFontNamed:@"bebasneue"];
            label.fontSize = 23;
            NSString *myText = @"Cluster ";
            int randNum = [Util randIntFrom:1 to:10000];
            NSString *myTextWithNum = [myText stringByAppendingString:[NSString stringWithFormat:@"%d", randNum]];
            label.name = @"galaxyLabel";
            label.text= myTextWithNum;
            int range = 350;
            CGPoint randomPosition = CGPointMake([Util randIntFrom:-range to:range], [Util randIntFrom:-range to:range]);
            label.position = randomPosition;
    //        label.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:1];
            [galaxy addChild:label];
        }
        //        spring.maxLength = 100;
        //        [self.scene.physicsWorld addJoint:spring];
        
        
        [scene addChild:self];
        [self addChild:galaxy];
//        galaxy.physicsBody.angularVelocity = -1;
        CGPoint galaxyposition = [galaxy.scene convertPoint:galaxy.position fromNode:galaxy.parent];
//        CGPoint distantPosition = [distantSolarSystem.scene convertPoint:distantSolarSystem.position fromNode:distantSolarSystem.parent];

//        CGPoint galaxyposition = galaxy.position;
//        CGPoint distantPosition = distantSolarSystem.position;
//        SKPhysicsJointSpring *spring = [SKPhysicsJointSpring jointWithBodyA:galaxy.physicsBody bodyB:distantSolarSystem.physicsBody anchorA:galaxyposition anchorB:distantPosition];
//        spring.maxLength = 100;
//        [self.scene.physicsWorld addJoint:spring];
    }
    return self;
}
@end
