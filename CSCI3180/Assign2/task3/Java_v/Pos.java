public class Pos {
  private int row;
  private int column;

  public Pos() {

  }

  public Pos(int row, int column) {
    this.row = row;
    this.column = column;
  }

  public void setPos(int row, int column) {
    this.row = row;
    this.column = column;
  }

  public int getRow() {
    return this.row;
  }

  public int getColumn() {
    return this.column;
  }
}