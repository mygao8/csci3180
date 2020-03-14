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

class Spring():
    def __init__(self):
        self.__num_chance = 1
        self.__healing_power = 100
        self.__pos = Pos()

    def set_pos(self, row, column):
        self.__pos.set_pos(row, column)

    def get_pos(self):
        return self.__pos

    def action_on_soldier(self, soldier):
        self.talk()
        if self.__num_chance == 1:
            soldier.recover(self.__healing_power)
            self.__num_chance -= 1
    
    def talk(self):
        print("Spring@: You have {} chance to recover 100 health.\n".format(self.__num_chance))
    
    def display_symbol(self):
        print("@", end="")