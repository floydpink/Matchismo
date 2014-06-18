//
//  PlayingCard.m
//  Matchismo
//
//  Created by Hari on 3/17/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents {
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

@synthesize suit = _suit; // because we provide both setter AND getter

+ (NSArray *)validSuits {
    return @[@"♥",@"♦",@"♠",@"♣"];
}

+ (NSArray *)rankStrings {
    return @[@"?",@"A",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"J",@"Q",@"K"];
}

+ (NSUInteger)maxRank {
    return [[self rankStrings] count] - 1;
}

- (NSString *)suit {
    return _suit ? _suit : @"?";
}

- (void)setSuit:(NSString *)suit {
    if ([[PlayingCard validSuits] containsObject:suit]) {
        _suit = suit;
    }
}

- (void)setRank:(NSUInteger)rank {
    if (rank <= [PlayingCard maxRank]) {
        _rank = rank;
    }
}

-(int)match:(NSArray *)otherCards {
    int score = 0;
    
    if ([otherCards count] == 1) {
        PlayingCard *otherCard = [otherCards firstObject];
        if (otherCard.rank == self.rank) {
            score = 16;  // 1 out of 3
        } else if ([otherCard.suit isEqualToString:self.suit]) {
            score = 4;  // 1 out of 12
        }
    } else if ([otherCards count] == 2) {
        PlayingCard *secondCard = [otherCards firstObject];
        PlayingCard *thirdCard = [otherCards lastObject];
        if (secondCard.rank == self.rank && thirdCard.rank == self.rank) {
            score = 64;  // 2 out of 3
        } else if (secondCard.suit == self.suit && thirdCard.suit == self.suit) {
            score = 16;  // 2 out of 12
        } else if (secondCard.rank == self.rank || thirdCard.rank == self.rank || secondCard.rank == thirdCard.rank) {
            score = 4;  // 1 out of 6
        } else if (secondCard.suit == self.suit || thirdCard.suit == self.suit || secondCard.suit == thirdCard.suit) {
            score = 1;  // 1 out of 24
        }
    }
    
    return score;
}

@end
