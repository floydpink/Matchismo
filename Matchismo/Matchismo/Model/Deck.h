//
//  Deck.h
//  Matchismo
//
//  Created by Hari on 3/16/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

@import Foundation;
#import "Card.h"

@interface Deck : NSObject

- (void) addCard:(Card *)otherCard atTop: (BOOL)atTop;
- (void) addCard:(Card *)otherCard;

- (Card *)drawRandomCard;

@end
