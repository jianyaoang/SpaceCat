//
//  SpaceDogNode.h
//  SpaceCat
//
//  Created by Jian Yao Ang on 7/26/14.
//  Copyright (c) 2014 Jian Yao Ang. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>


//enumerated type. Keywords associated with number
typedef NS_ENUM(NSUInteger, SpaceDogType)
{
    SpaceDogTypeA = 0,
    SpaceDogTypeB = 1,
};

@interface SpaceDogNode : SKSpriteNode
+(instancetype) spaceDogOfType:(SpaceDogType)type;


@end
