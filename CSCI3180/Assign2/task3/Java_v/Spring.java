import java.util.Scanner;

public class Spring {
  private int numChance;
  private int healingPower;
  private Pos pos;

  public Spring() {
    this.numChance = 1;
    this.healingPower = 100;
    this.pos = new Pos();
  }

  public void setPos(int row, int column) {
    this.pos.setPos(row, column);
  }

  public Pos getPos() {
    return this.pos;
  }

  public void actionOnSoldier(Soldier soldier) {
    this.talk();
    if (this.numChance == 1) {
      soldier.recover(this.healingPower);
      this.numChance -= 1;
    }
  }

  public void talk() {
    System.out.printf("Spring@: You have %d chance to recover 100 health.%n%n", this.numChance);
  }

  public void displaySymbol() {
    System.out.printf("@");
  }
}