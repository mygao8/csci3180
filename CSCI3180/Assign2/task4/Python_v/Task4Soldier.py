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

from Soldier import Soldier

class Task4Soldier(Soldier):
    def __init__(self):
        super().__init__()
        self.defense = 0
        self.num_coins = 0
        
    def lose_health(self):
        hurt = 0 if self.defense >= 10 else 10 - self.defense
        self._health -= hurt
        return self._health <= 0
        
    def display_information(self):
        super().display_information()
        print("Defense :{}".format(self.defense))
        print("Coins :{}".format(self.num_coins))

    def get_defense(self):
        return self.defense
    
    def add_defense(self):
        self.defense += 5
        
    def get_num_coins(self):
        return self.num_coins
    
    def add_coin(self):
        self.num_coins += 1
        
    def use_coin(self, used_num):
        self.num_coins -= used_num
