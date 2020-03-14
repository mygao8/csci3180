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

class Pos():
    def __init__(self, row=0, column=0):
        # use default parameters to keep consistent with empty constructor in Java sample
        self.__row = row
        self.__column = column
    
    def set_pos(self, row, column):
        self.__row = row
        self.__column = column

    def get_row(self):
        return self.__row
    
    def get_column(self):
        return self.__column
        
    