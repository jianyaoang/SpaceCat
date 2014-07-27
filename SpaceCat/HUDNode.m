//
//  HUDNode.m
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/27/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import "HUDNode.h"
#import "Utils.h"

@implementation HUDNode

+(instancetype)hudAtPosition:(CGPoint)position frame:(CGRect)frame;
{
    HUDNode *hud = [self node];
    hud.position = position;
    hud.zPosition = 10;
    
    SKSpriteNode *catHead = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_cat_1"];
    catHead.position = CGPointMake(30, -10);
    [hud addChild:catHead];
    
    hud.lives = MaxLives;

    SKSpriteNode *lastLifeBar;
    
    for (int i =0 ; i < hud.lives; i++)
    {
        SKSpriteNode *lifeBar = [SKSpriteNode spriteNodeWithImageNamed:@"HUD_life_1"];
        lifeBar.name = [NSString stringWithFormat:@"Life%d", i+1];
        [hud addChild:lifeBar];
        
        if (lastLifeBar == nil)
        {
            lifeBar.position = CGPointMake(catHead.position.x+30, catHead.position.y);
        }
        else
        {
            lifeBar.position = CGPointMake(lastLifeBar.position.x+10, lastLifeBar.position.y);
        }
        //setting position relative to lifebar
        lastLifeBar = lifeBar;
    }
    
    SKLabelNode *scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Futura-CondensedExtraBold"];
    scoreLabel.name = @"Score";
    scoreLabel.text = @"0";
    scoreLabel.fontSize = 25;
    scoreLabel.position = CGPointMake(frame.size.width - 20, -10);
    [hud addChild:scoreLabel];
    
    
    return hud;
}


@end
