public class Task4Soldier extends Soldier{
	private int defense;
	private int numCoins;
	
	public Task4Soldier() {
		// Compiler constructs the super class automatically
		this.defense = 0;
		this.numCoins = 0;
	}
	
	@Override
	public boolean loseHealth() {
		int hurt = this.defense>=10? 0: 10-this.defense;
		super.health -= hurt;
		return super.health <= 0;
	}
	
	@Override
    public void displayInformation() {
		super.displayInformation();
		System.out.printf("Defense :%d.%n", this.defense);
		System.out.printf("Coins :%d.%n", this.numCoins);
   }
	
	public int getDefense() {
		return this.defense;
	}

	public void addDefense() {
		this.defense += 5;
	}
	
	public int getNumCoins() {
		return this.numCoins;
	}

	public void addCoin() {
		this.numCoins += 1;
	}

	public void useCoin(int usedNum) {
	    this.numCoins -= usedNum;
	}
}
