public class Cell {
  private Object occupiedObject;

  public Cell() {
    this.occupiedObject = null;
  }

  public Object getOccupiedObject() {
    return occupiedObject;
  }

  public void setOccupiedObject(Object occupiedObject) {
    this.occupiedObject = occupiedObject;
  }
}