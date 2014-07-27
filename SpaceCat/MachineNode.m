//
//  MachineNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "MachineNode.h"

@implementation MachineNode

+(instancetype) machineAtPosition:(CGPoint)position
{
    MachineNode *machine = [self spriteNodeWithImageNamed:@"machine_1"];
    //center on the x-axis, 12 above the y
    machine.position = position;
    machine.zPosition = 8;
    machine.anchorPoint = CGPointMake(0.5, 0);
    machine.name = @"Machine";
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"machine_1"],
                           [SKTexture textureWithImageNamed:@"machine_2"]];
    
    SKAction *machineAnimation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    
    SKAction *machineRepeatAnimation = [SKAction repeatActionForever:machineAnimation];
    
    [machine runAction:machineRepeatAnimation];
    
    return machine;
}

@end
