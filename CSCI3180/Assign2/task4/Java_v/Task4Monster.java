
public class Task4Monster extends Monster{

	public Task4Monster(int monsterID, int healthCapacity) {
		super(monsterID, healthCapacity);
	}
	
	public void addDropCoin(Task4Soldier soldier) {
		soldier.addCoin();
	}
	
	@Override
	public void fight(Soldier soldier) {
		super.fight(soldier);
		
		if (super.getHealth() <= 0) {
			this.addDropCoin((Task4Soldier)soldier);
		}
	}
}
