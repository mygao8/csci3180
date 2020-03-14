# CSCI3180 Principles of Programming Languages
# --- Declaration ---
# I declare that the assignment here submitted is original except for source
# material explicitly acknowledged. I also acknowledge that I am aware of
# University policy and regulations on honesty in academic work, and of the
# disciplinary guidelines and procedures applicable to breaches of such policy
# and regulations, as contained in the website
# http://www.cuhk.edu.hk/policy/academichonesty/

# Assignment 2
# Name : GAO Ming Yuan
# Student ID : 1155107738
# Email Addr : 1155107738@link.cuhk.edu.hk

from Pos import Pos

class Task4Merchant():
    def __init__(self):
        self.elixir_price = 1
        self.shield_price = 2
        self.pos = Pos()
        
    def action_on_soldier(self, soldier):
        sell_continued = True
        while (sell_continued):
            choice = input("Merchant$: Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ")
            
            if choice.strip() == "1":
                self.sell(soldier, self.elixir_price)
                sell_continued = False
            elif choice.strip() == "2":
                self.sell(soldier, self.shield_price)
                sell_continued = False
            elif choice.strip() == "3":
                sell_continued = False
            else:
                print("=> Illegal choice!\n")

    def enough_coins(self, soldier, price):
        return soldier.get_num_coins() >= price
    
    def sell(self, soldier, price):
        if self.enough_coins(soldier, price):
            if price == self.elixir_price:
                soldier.add_elixir()
            elif price == self.shield_price:
                soldier.add_defense()

            soldier.use_coin(price)
            return True
        else:
            print("Merchant$: You don't have enough coins.\n")
            return False

    def get_pos(self):
        return self.pos

    def set_pos(self, row, column):
        self.pos.set_pos(row, column)
        
    def display_symbol(self):
        print("$", end="")