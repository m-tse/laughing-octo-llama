//
//  AbstractBody.m
//  iTunesGalaxy
//
//  Created by Tianyu Shi on 9/29/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "AbstractBody.h"

@implementation AbstractBody

- (void)setLabel:(NSString *)label {
    _labelNode.text = label;
}

-(void)runCustomAction {
    [_body runAction: _customAction];
    return;
}

- (void)setxScale:(CGFloat)xScale
              yScale:(CGFloat)yScale {
    _body.xScale = xScale;
    _body.yScale = yScale;
}

@end
