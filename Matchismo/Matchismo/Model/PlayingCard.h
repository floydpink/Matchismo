//
//  PlayingCard.h
//  Matchismo
//
//  Created by Hari on 3/17/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong, nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
