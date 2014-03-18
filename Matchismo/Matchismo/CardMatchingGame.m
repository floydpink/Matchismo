//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Hari on 3/17/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame ()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong, readwrite) NSString *operation;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards {
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck {
    
    self = [super init]; // super's designated initializer
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if (card) {
                [self.cards addObject:card];
            } else {
                self = nil;
                break;
            }
        }
    }
    
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    self.operation = @"";
    Card *card = [self cardAtIndex:index];
    if (!card.isMatched) {
        if (card.isChosen) {
            card.chosen = NO;
            self.operation = [NSString stringWithFormat:@"Unchose card %@", card];
        } else {
            // match against other chosen cards
            for (Card *otherCard in self.cards) {
                if (otherCard.isChosen && !otherCard.isMatched) {
                    int matchScore = [card match:@[otherCard]];
                    if (matchScore) {
                        NSInteger matchScoreWithBonus = matchScore * MATCH_BONUS;
                        self.score += matchScoreWithBonus;
                        card.matched = YES;
                        otherCard.matched = YES;
                        self.operation = [NSString stringWithFormat:@"Card %@ matched card %@ for  a score of %d", card, otherCard, matchScoreWithBonus];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        otherCard.chosen = NO;
                        self.operation = [NSString stringWithFormat:@"Card %@ did not match card %@. Penalty of %d", card, otherCard, MISMATCH_PENALTY];
                    }
                    break;
                }
            }
            if ([self.operation isEqualToString:@""]) {
                self.operation = [NSString stringWithFormat:@"Chose card %@. Cost of %D", card, COST_TO_CHOOSE];
            }
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }
    }
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index<[self.cards count]) ? self.cards[index] : nil;
}

@end
