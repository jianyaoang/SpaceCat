//
//  GroundNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/26/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "GroundNode.h"

@implementation GroundNode

+(instancetype) groundWithSize:(CGSize)size
{
    GroundNode *ground = [self spriteNodeWithColor:[SKColor greenColor] size:size];
    ground.name = @"Ground";
    ground.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:size];
    ground.position = CGPointMake(size.width/2, size.height/2);
    ground.physicsBody.affectedByGravity = NO;
    return  ground;
}
@end
