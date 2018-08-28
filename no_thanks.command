#!/usr/bin/env python

import random

deck_min = 3
deck_max = 35
whole_deck = range(deck_min,deck_max+1)
player_list = {}

# Create a new deck of 24 cards. Returns an ordered list of cards in the deck
def new_deck():
    remove_cards = []
    # Remove 9 random cards from a complete deck
    for x in range(9):
        while True:
            new_remove_card = random.randint(deck_min,deck_max+1)
            if new_remove_card in remove_cards:
                continue
            else:
                remove_cards.append(new_remove_card)
                break
    play_deck = [x for x in whole_deck if x not in remove_cards]
    return play_deck

def shuffle(deck):
    random.shuffle(deck)
    return deck

# Draw the next card from a deck in play and remove from the deck
# Returns the card drawn, and the deck after removing the card
def next_card(deck):
    card = deck[0]
    del deck[0]
    return card, deck

# Class for new player objects, initialised with score, cards, token count, and play order
class Player:
    def __init__(self):
        self.score = 0
        self.cards = []
        self.tokens = 0
        self.play_order = 0

# Give each player 11 tokens, to start the game
def give_tokens():
    for key in player_list:
        player_list[key].tokens = 11
    return

# Randomise play order, do at the start of the game
def choose_play_order():
    order = range(len(player_list))
    random.shuffle(order)
    for key in player_list:
        player_list[key].play_order = order[0]
        del order[0]
    return

# Offer a card to a player, accept response whether they take it or pass and pay a token
# Returns
def offer_card(card,card_tokens,player_name):
    while True:
        accept_card = raw_input("Will you (t)ake the {0} card, or (p)ass and pay one token? ".format(card))
        if accept_card in ("t","p"):
            break
        else:
            print "Please respond either 't' or 'p'"
    if accept_card == "t":
        player_list[player_name].tokens += card_tokens
        player_list[player_name].cards.append(card)
        return True, 0, 0
    elif accept_card == "p":
        player_list[player_name].tokens -= 1
        return False, card, card_tokens+1

player_list["Daniel"] = Player()

current_deck = shuffle(new_deck())
current_card = offer_card(next_card(current_deck)[0],0,"Daniel")
print "The current card is {0} and it has {1} tokens".format(current_card[1],current_card[2])
