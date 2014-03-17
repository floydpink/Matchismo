//
//  Card.h
//  Matchismo
//
//  Created by Hari on 3/16/14.
//  Copyright (c) 2014 floydpink. All rights reserved.
//

@import Foundation;

@interface Card : NSObject

@property (strong, nonatomic) NSString *contents;

@property (nonatomic, getter = isChosen) BOOL chosen;
@property (nonatomic, getter = isMatched) BOOL matched;

- (int) match: (NSArray *)otherCards;

@end
