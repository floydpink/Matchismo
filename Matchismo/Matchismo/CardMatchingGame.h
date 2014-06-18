//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Hari on 3/17/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong, readonly) NSString *operation;
@property (nonatomic) BOOL threeCardsMode;

@end
