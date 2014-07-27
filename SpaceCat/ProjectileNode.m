//
//  ProjectileNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/19/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "ProjectileNode.h"
#import "Utils.h"

@implementation ProjectileNode

+(instancetype)projectileAtPosition:(CGPoint)position
{
    ProjectileNode *projectile = [self spriteNodeWithImageNamed:@"projectile_1"];
    projectile.position = position;
    projectile.name = @"Projectile";
    
    [projectile setupAnimation];
    [projectile setupPhysicsBody];
    
    return projectile;
}

-(void)setupPhysicsBody
{
    self.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:self.frame.size];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = CollisionCategoryProjectile;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = CollisionCategoryEnemy;
}


-(void) setupAnimation
{
    NSArray *textures = @[[SKTexture textureWithImageNamed:@"projectile_1"], [SKTexture textureWithImageNamed:@"projectile_2"], [SKTexture textureWithImageNamed:@"projectile_3"]];
    
    SKAction *animation = [SKAction animateWithTextures:textures timePerFrame:0.1];
    SKAction *repeatAnimation = [SKAction repeatActionForever:animation];
    [self runAction:repeatAnimation];

}

-(void)moveTowardsPosition:(CGPoint)position
{
    //slope = (Y3 - Y1) / (X3 - X1)
    float slope = (position.y - self.position.y) / (position.x - self.position.x);
    
    //if offscreen set x = -10
    //slope = (Y2-Y1) / (X2-X1)
    //Y2-Y1 = slope (X2-X1)
    //Y2 = slope * X2 - slope * X1 + Y1
    
    float offscreenX;
    
    //to figure out if x is offscreen or not
    //self.position.x is the point from the machine
    if (position.x < self.position.x)
    {
        //player press any point left to the machine
        offscreenX = -10;
    }
    else
    {
        //player press any point to the right of the machine
        offscreenX = self.parent.frame.size.width +10;
    }
    
    float offscreenY = slope *offscreenX - slope * self.position.x + self.position.y;
    
    CGPoint pointOffscreen = CGPointMake(offscreenX, offscreenY);
    
    //using Pythagoras Theoram to calculate distanceC DistanceC^2 = DistanceA^2 + Distance B^2
    float distanceA = pointOffscreen.y - self.position.y;
    
    float distanceB = pointOffscreen.x - self.position.x;
    
    float distanceC = sqrtf(powf(distanceA, 2) + powf(distanceB, 2));
    
    //distance = speed * time
    //time = distance / speed
    
    float time = distanceC / ProjectileSpeed;
    float waitToFade = time * 0.75;
    float fadeTime = time - waitToFade;
    
    SKAction *moveProjectile = [SKAction moveTo:pointOffscreen duration:time];
    [self runAction:moveProjectile];
    
    //sequence array created to execute several actions
    NSArray *sequence = @[[SKAction waitForDuration:waitToFade],
                          [SKAction fadeOutWithDuration:fadeTime],
                          [SKAction removeFromParent]];
    [self runAction:[SKAction sequence:sequence]];
    
}

@end
