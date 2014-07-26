//
//  GroundNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/26/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "GroundNode.h"
#import "Utils.h"

@implementation GroundNode

+(instancetype) groundWithSize:(CGSize)size
{
    GroundNode *ground = [self spriteNodeWithColor:[SKColor greenColor] size:size];
    ground.name = @"Ground";
    ground.position = CGPointMake(size.width/2, size.height/2);
    [ground setupPhysicsBody];
    return  ground;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    
    //stating that physics has no effect on it
    self.physicsBody.dynamic = NO;
    
    self.physicsBody.categoryBitMask = CollisionCategoryGround;
    self.physicsBody.collisionBitMask = CollisionCategoryDebris;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}
@end
