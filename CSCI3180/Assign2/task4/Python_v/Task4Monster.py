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

from Monster import Monster

class Task4Monster(Monster):
    def __init__(self, monster_id, health_capacity):
        super().__init__(monster_id, health_capacity)
    
    def add_drop_coin(self,soldier):
        soldier.add_coin()

    def fight(self, soldier):
        super().fight(soldier)

        if (super().get_health() <= 0):
            self.add_drop_coin(soldier)