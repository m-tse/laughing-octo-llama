//
//  Util.m
//  itunesGalaxy
//
//  Created by Matthew on 9/28/13.
//  Copyright (c) 2013 MTA. All rights reserved.
//

#import "Util.h"

@implementation Util
static inline CGFloat skRandf() {
    return rand() / (CGFloat) RAND_MAX;
}

+ (CGFloat)randFloatFrom:(CGFloat)low to:(CGFloat)high {
    return skRandf() * (high - low) + low;
}


+ (int)randIntFrom:(int)low to:(int)high{
    return (arc4random() % (high-low)) + low;

}

@end
