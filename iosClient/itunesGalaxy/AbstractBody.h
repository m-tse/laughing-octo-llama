//
//  AbstractBody.h
//  iTunesGalaxy
//
//  Created by Tianyu Shi on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import <CoreGraphics/CGBase.h>
#import <SpriteKit/SpriteKit.h>
#import <Foundation/Foundation.h>

@interface AbstractBody : SKNode {
    SKSpriteNode *_body;
    SKAction *_customAction;
    SKLabelNode * _labelNode;
}

- (void)setLabel:(NSString *)label;
- (void)runCustomAction;
- (void)setxScale:(CGFloat)xScale yScale:(CGFloat)yScale;

@end
