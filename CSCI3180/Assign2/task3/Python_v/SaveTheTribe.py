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

from Map import Map 
from Soldier import Soldier 
from Spring import Spring 
from Monster import Monster 
import random

class SaveTheTribe():
    def __init__(self):
        self.__map = Map()
        self.__soldier = Soldier()
        self.__spring = Spring()
        self.__monsters = [None for i in range(7)]
        self.__game_enabled = True

    def initialize(self):
        # 1-7 represent keys for correspoding caves, -1 for artifact
        self.__monsters[0] = Monster(1, random.randint(3, 7) * 10) 
        self.__monsters[0].set_pos(4, 1) 
        self.__monsters[0].add_drop_item(2) 
        self.__monsters[0].add_drop_item(3) 
    
        self.__monsters[1] = Monster(2, random.randint(3, 7) * 10) 
        self.__monsters[1].set_pos(3, 3) 
        self.__monsters[1].add_drop_item(3) 
        self.__monsters[1].add_drop_item(6) 
        self.__monsters[1].add_hint(1) 
        self.__monsters[1].add_hint(5) 

        self.__monsters[2] = Monster(3, random.randint(3, 7) * 10) 
        self.__monsters[2].set_pos(5, 3) 
        self.__monsters[2].add_drop_item(4) 
        self.__monsters[2].add_hint(1) 
        self.__monsters[2].add_hint(2) 

        self.__monsters[3] = Monster(4, random.randint(3, 7) * 10) 
        self.__monsters[3].set_pos(5, 5) 
        self.__monsters[3].add_hint(3) 
        self.__monsters[3].add_hint(6) 

        self.__monsters[4] = Monster(5, random.randint(3, 7) * 10) 
        self.__monsters[4].set_pos(1, 4) 
        self.__monsters[4].add_drop_item(2) 
        self.__monsters[4].add_drop_item(6) 

        self.__monsters[5] = Monster(6, random.randint(3, 7) * 10) 
        self.__monsters[5].set_pos(3, 5) 
        self.__monsters[5].add_drop_item(4) 
        self.__monsters[5].add_drop_item(7) 
        self.__monsters[5].add_hint(2) 
        self.__monsters[5].add_hint(5) 

        self.__monsters[6] = Monster(7, random.randint(3, 7) * 10) 
        self.__monsters[6].set_pos(4, 7) 
        self.__monsters[6].add_drop_item(-1) 
        self.__monsters[6].add_hint(6) 

        self.__map.add_object(self.__monsters) 

        self.__soldier.set_pos(1, 1) 
        self.__soldier.add_key(1) 
        self.__soldier.add_key(5) 

        self.__map.add_object(self.__soldier) 

        self.__spring.set_pos(7, 4) 

        self.__map.add_object(self.__spring) 

    def start(self):
        print("=> Welcome to the desert!")
        print("=> Now you have to defeat the monsters and find the artifact to save the tribe.%n")

        while self.__game_enabled:
            self.__map.display_map()
            self.__soldier.display_information()

            move = input("\n=> What is the next step? (W = Up, S = Down, A = Left, D = Right.) Input: ")

            pos = self.__soldier.get_pos()
            new_row = old_row = pos.get_row()
            new_column = old_column = pos.get_column()
            
            if move.strip().upper() == "W":
                new_row = old_row - 1
            elif move.strip().upper() == "S":
                new_row = old_row + 1
            elif move.strip().upper() == "A":
                new_column = old_column - 1
            elif move.strip().upper() == "D":
                new_column = old_column + 1
            else:
                print("=> Illegal move!\n")
                continue

            if self.__map.check_move(new_row, new_column):
                # report
                occupied_object = self.__map.get_occupied_object(new_row, new_column)
                
                if occupied_object:
                    # monster or spring
                    occupied_object.action_on_soldier(self.__soldier)
                else:
                    self.__soldier.move(new_row, new_column)
                    self.__map.update(self.__soldier, old_row, old_column, new_row, new_column)
                    print("\n")
            else:
                print("=> Illegal move!\n")

            if self.__soldier.get_health() <= 0:
                print("=> You died.")
                print("=> Game Over.\n")
                self.__game_enabled = False
                
            # check if the soldier has received the artifact
            if -1 in self.__soldier.get_keys():
                print("=> You found the artifact.")
                print("=> Game over.\n")
                self.__game_enabled = False
                

if __name__ == "__main__":
    game = SaveTheTribe()
    game.initialize()
    game.start()