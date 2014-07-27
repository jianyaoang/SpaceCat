//
//  SpaceCatNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "SpaceCatNode.h"
@interface SpaceCatNode ()
@property (strong, nonatomic) SKAction *tapAction;

@end

@implementation SpaceCatNode

+ (instancetype) spaceCatAtPosition:(CGPoint)position
{
    SpaceCatNode *spaceCat = [self spriteNodeWithImageNamed:@"spacecat_1"];
    //center on the x-axis, 12 above the y
    spaceCat.position = position;
    spaceCat.anchorPoint = CGPointMake(0.5, 0);
    
    //giving spaceCat a unique name
    spaceCat.name = @"SpaceCat";
    return spaceCat;
}

-(void) performTap
{
    [self runAction:self.tapAction];
}

-(SKAction*) tapAction
{
    if (_tapAction != nil)
    {
        return _tapAction;
    }
    
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"spacecat_2"],
                          [SKTexture textureWithImageNamed:@"spacecat_1"]];
    
    _tapAction = [SKAction animateWithTextures:textures timePerFrame:0.25];
    
    return _tapAction;
}


@end
