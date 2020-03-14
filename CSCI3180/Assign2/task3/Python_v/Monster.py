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

class Monster():
    def __init__(self, monster_id, health_capacity):
        self.__monster_id = monster_id
        self.__health_capacity = health_capacity
        self.__health = health_capacity
        self.__pos = Pos()
        self.__drop_item_list = []  # int list
        self.__hint_list = []  #int list
        
    def add_drop_item(self, key):
        self.__drop_item_list.append(key)
    
    def add_hint(self, monster_id):
        self.__hint_list.append(monster_id)

    def get_monster_id(self):
        return self.__monster_id
    
    def get_pos(self):
        return self.__pos

    def set_pos(self, row, column):
        self.__pos.set_pos(row, column)
    
    def get_health_capacity(self):
        return self.__health_capacity

    def get_health(self):
        return self.__health

    def lose_health(self):
        self.__health -= 10
        return self.__health <= 0
        
    def recover(self, healing_power):
        self.__health = healing_power
    
    def action_on_soldier(self, soldier):
        if self.__health <= 0:
            self.talk("You had defeated me.\n\n")
        else:
            if self.require_key(soldier.get_keys()):
                self.fight(soldier)
            else:
                self.display_hints()
            
    def require_key(self, keys: set): 
        return self.__monster_id in keys

    def display_hints(self):
        self.talk("Defeat Monster {} first.\n\n".format(self.__hint_list))

    def fight(self, soldier):
        fight_enabled = True
        
        while fight_enabled:
            print("       | Monster{} | Soldier |".format(self.__monster_id))
            print("Health | {:8d} | {:7d} |\n".format(self.__health, soldier.get_health()))
            choice = input("=> What is the next step? (1 = Attack, 2 = Escape, 3 = Use Elixir.) Input: ")
            if choice.strip() == "1":
                #soldier attack
                if self.lose_health():
                    print("=> You defeated Monster{}.\n".format(self.__monster_id))
                    self.drop_items(soldier)
                    fight_enabled = False
                elif soldier.lose_health():
                    self.recover(self.__health_capacity)
                    fight_enabled = False
            elif choice.strip() == "2":
                # soldier escape, monster recovers full HP
                self.recover(self.__health_capacity)
                fight_enabled = False
            elif choice.strip() == "3":
                # soldier use elixir
                if soldier.get_num_elixirs() == 0:
                    print("=> You have run out of elixirs.\n")
                else:
                    soldier.use_elixir()
            else:
                print("=> Illegal choice!\n")

    def drop_items(self, soldier):
        for item in self.__drop_item_list:
            soldier.add_key(item)
    
    def talk(self, text):
        print("Monster{}: {}".format(self.__monster_id, text), end="")
        
    def display_symbol(self):
        print("M", end="")