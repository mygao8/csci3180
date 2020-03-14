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

from Cell import Cell
from Pos import Pos

class Map():
    def __init__(self):
        self.__cells = [[Cell() for i in range(7)] for j in range(7)]

    def add_object(self,object):
        # report
        if isinstance(object, list):
            # object is Monster list
            for monster in object:
                pos = monster.get_pos()
                self.__cells[pos.get_row() - 1][pos.get_column() - 1].set_occupied_object(monster)
        else:
            # object is soldier or spring
            pos = object.get_pos()
            self.__cells[pos.get_row() - 1][pos.get_column() - 1].set_occupied_object(object)

    def display_map(self):
        print("   | 1 | 2 | 3 | 4 | 5 | 6 | 7 |")
        print("--------------------------------")
        for i in range(7):
            print(" {} |".format(i + 1),end="")
            for j in range(7):
                occupied_object = self.__cells[i][j].get_occupied_object()
                if (occupied_object != None):
                    print(" ",end="")
                    occupied_object.display_symbol()
                    print(" |",end="")
                else:
                    print("   |",end="")
            print()
            print("--------------------------------")
        print()

    def get_occupied_object(self,row, column):
        return self.__cells[row - 1][column - 1].get_occupied_object()
    
    def check_move(self,row, column):
        return ((row >= 1 and row <= 7) and (column >= 1 and column <= 7))

    def update(self,soldier, old_row, old_column, new_row, new_column):
        self.__cells[old_row - 1][old_column - 1].set_occupied_object(None)
        self.__cells[new_row - 1][new_column - 1].set_occupied_object(soldier)

