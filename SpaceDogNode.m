//
//  SpaceDogNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/26/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "SpaceDogNode.h"
#import "Utils.h"

@implementation SpaceDogNode

+(instancetype) spaceDogOfType:(SpaceDogType)type;
{
    SpaceDogNode *spaceDog;
    
    NSArray *textures;
    
    if (type == SpaceDogTypeA)
    {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_A_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_A_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_A_3"]];
    }
    else if (type == SpaceDogTypeB)
    {
        spaceDog = [self spriteNodeWithImageNamed:@"spacedog_B_1"];
        textures = @[[SKTexture textureWithImageNamed:@"spacedog_B_1"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_2"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_3"],
                     [SKTexture textureWithImageNamed:@"spacedog_B_4"]];
    }
    
    // dividing 100.0f gives us a float number
    float scaleSpaceDogSize = [Utils randomWithMin:85 max:100] / 100.0f;
    spaceDog.xScale = scaleSpaceDogSize;
    spaceDog.yScale = scaleSpaceDogSize;
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    [spaceDog runAction:[SKAction repeatActionForever:animation]];
    
    [spaceDog setupPhysicsBody];
    
    return spaceDog;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryEnemy;
    self.physicsBody.collisionBitMask = 0;
    
    //0010 | 1000 = 1010
    self.physicsBody.contactTestBitMask = CollisionCategoryProjectile | CollisionCategoryGround;
}

@end
