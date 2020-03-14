import java.util.Scanner;

public class Merchant {
  private int elixirPrice;
  private int shieldPrice;
  private Pos pos;

  public Merchant() {
    // TODO: Initialization.
	  this.elixirPrice = 1;
	  this.shieldPrice = 2;
	  this.pos = new Pos();
  }

  public void actionOnSoldier(Task4Soldier soldier) {
    this.talk("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ");

    // TODO: Main logic.

    // If the soldier doesn't have enough coins to buy what (s)he wants, the merchant will say "You don't have enough coins.%n%n".
    // Then, the soldier will automatically leave.

    // After the soldier successfully buys an item from the merchant, (s)he will also automatically leave.
    boolean sellContinued = true;
    while (sellContinued) {
    	Scanner sc = new Scanner(System.in);
    	
    	String choice = sc.nextLine();
    	
    	if (choice.equalsIgnoreCase("1")) {
    		this.sell(soldier, this.elixirPrice);
    		sellContinued = false;
    	}
    	else if (choice.equalsIgnoreCase("2")) {
    		this.sell(soldier, this.shieldPrice);
    		sellContinued = false;
    	}
    	else if (choice.equalsIgnoreCase("3")) {
    		sellContinued = false;
    	}
    	else {
    		System.out.printf("=> Illegal choice!%n%n");
    		this.talk("Do you want to buy something? (1. Elixir, 2. Shield, 3. Leave.) Input: ");
    	}
    }


  }

  public void talk(String text) {
    System.out.printf("Merchant$: " + text);
  }

  // TODO: Other functions.
  public boolean enoughCoins(Task4Soldier soldier, int price) {
	  return soldier.getNumCoins() >= price;
  }

  public boolean sell(Task4Soldier soldier, int price) {
	  if (enoughCoins(soldier, price)) {
	  	if (price == this.elixirPrice) {
	  		soldier.addElixir();
	  	}
	  	else if (price == this.shieldPrice) {
	  		soldier.addDefense();
	  	}
		
		soldier.useCoin(price);
		return true;
	  }
	  else {
		this.talk("You don't have enough coins.%n%n");
		return false;
	  }
  }
  
  public Pos getPos() {
	    return this.pos;
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }
  
  public void displaySymbol() {
    System.out.printf("$");
  }
}