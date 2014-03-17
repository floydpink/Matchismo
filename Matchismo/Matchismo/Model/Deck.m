//
//  Deck.m
//  Matchismo
//
//  Created by Hari on 3/16/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

#import "Deck.h"

@interface Deck ()
@property (strong, nonatomic) NSMutableArray *cards; // of Card
@end

@implementation Deck

- (NSMutableArray *)cards
{
    if (!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

- (void) addCard:(Card *)otherCard atTop:(BOOL)atTop
{
    if (atTop) {
        [self.cards insertObject:otherCard atIndex:0];
    } else {
        [self.cards addObject:otherCard];
    }
}

- (void) addCard:(Card *)otherCard
{
    return [self addCard:otherCard atTop:NO];
}

- (Card *)drawRandomCard {
    Card *randomCard = nil;
    
    if ([self.cards count]) {
        unsigned index = arc4random() % [self.cards count];
        randomCard = self.cards[index];
        [self.cards removeObjectAtIndex:index];
    }
    
    return randomCard;
}

@end
