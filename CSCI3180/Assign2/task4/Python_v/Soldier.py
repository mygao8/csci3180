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
import random

class Soldier():
    def __init__(self):
        self._health = 100
        self.__num_elixirs = 2
        self.__pos = Pos()
        self.__keys = set()  #use set to remove duplicated keys

    def get_health(self):
        return self._health

    def lose_health(self):
        self._health -= 10
        return self._health <= 0

    def recover(self, healing_power):
        total_health = healing_power + self._health
        self._health = 100 if total_health >= 100 else total_health
        
    def get_pos(self):
        return self.__pos

    def set_pos(self, row, column):
        self.__pos.set_pos(row, column)

    def move(self, row, column):
        self.set_pos(row, column)

    def get_keys(self):
        return self.__keys

    def add_key(self, key):
        self.__keys.add(key)

    def get_num_elixirs(self):
        return self.__num_elixirs
    
    def add_elixir(self):
        self.__num_elixirs += 1
        
    def use_elixir(self):
        self.recover(random.randint(15, 20))
        self.__num_elixirs -= 1
        
    def display_information(self):
        print("Health: {}.".format(self._health))
        print("Position (row, column): ({}, {}).".format(self.__pos.get_row(), self.__pos.get_column()))
        print("Keys: {}.".format(self.__keys))
        print("Elixirs: {}.".format(self.__num_elixirs))

    def display_symbol(self):
        print("S", end="")