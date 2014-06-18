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
            if (self.threeCardsMode) {
                NSMutableArray *otherCards = [[NSMutableArray alloc] init];
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        [otherCards addObject:otherCard];
                    }
                }
                if ([otherCards count] == 2){
                    int matchScore = [card match:otherCards];
                    Card *secondCard = (Card *)[otherCards firstObject];
                    Card *thirdCard = (Card *)[otherCards lastObject];
                    if(matchScore) {
                        NSInteger matchScoreWithBonus = matchScore * MATCH_BONUS;
                        self.score += matchScoreWithBonus;
                        card.matched = YES;
                        secondCard.matched = YES;
                        thirdCard.matched = YES;
                        self.operation = [NSString stringWithFormat:@"Matched %@, %@ and %@ for %ld points", card, secondCard, thirdCard, (long)matchScoreWithBonus];
                    } else {
                        self.score -= MISMATCH_PENALTY;
                        secondCard.chosen = NO;
                        thirdCard.chosen = NO;
                        self.operation = [NSString stringWithFormat:@"%@, %@ and %@ don't match! %d point penalty!", card, secondCard, thirdCard, MISMATCH_PENALTY];
                    }
                }
            } else {
                for (Card *otherCard in self.cards) {
                    if (otherCard.isChosen && !otherCard.isMatched) {
                        int matchScore = [card match:@[otherCard]];
                        if (matchScore) {
                            NSInteger matchScoreWithBonus = matchScore * MATCH_BONUS;
                            self.score += matchScoreWithBonus;
                            card.matched = YES;
                            otherCard.matched = YES;
                            self.operation = [NSString stringWithFormat:@"Matched %@ %@ for %ld points", card, otherCard, (long)matchScoreWithBonus];
                        } else {
                            self.score -= MISMATCH_PENALTY;
                            otherCard.chosen = NO;
                            self.operation = [NSString stringWithFormat:@"%@ %@ don't match! %d point penalty!", card, otherCard, MISMATCH_PENALTY];
                        }
                        break;
                    }
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
