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

class Cell():
    def __init__(self):
        self.__occupied_object = None
    
    def get_occupied_object(self):
        return self.__occupied_object

    def set_occupied_object(self,occupied_object):
        self.__occupied_object = occupied_object
