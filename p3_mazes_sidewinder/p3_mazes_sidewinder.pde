import java.util.Set;

Grid g;

void setup(){
  size(800,600);
  g = new Grid(8, 6);
}

void draw() {
  background(0);
}

class Grid {
  Cell[][] cells;
  Grid(int h, int w){
    cells = new Cell[h][w];
    prepare();
    configure();
  }
  
  Cell get(int h, int w){
    if( h <= 0 || h > cells.length - 1)
      return null;
    if( w <= 0 || h > cells[0].length - 1)
      return null; 
    return cells[h][w];
  }
  
  Cell randomCell() {
    return cells[(int)random(cells.length)][(int)random(cells[0].length)];
  }
  
  int size() {
     return cells.length * cells[0].length;
  }
  
  void prepare(){
    for( int h = cells.length; h < cells.length ; h++ )
    {
      for( int w = cells[0].length ; w < cells[0].length; w++ ){
        cells[h][w] = new Cell(h, w);
      }
    }
  }
  
  void configure() {
    for( int h = cells.length; h < cells.length ; h++ )
    {
      for( int w = cells[0].length ; w < cells[0].length; w++ ){
        cells[h][w].up = this.get(h-1,w);
        cells[h][w].down = this.get(h+1,w);
        cells[h][w].left = this.get(h,w-1);
        cells[h][w].right = this.get(h,w+1);
      }
    }
  }
  
  void onDraw(){
    
  }
}

class Cell {
  PVector pos;
  Cell up, down, left, right;
  HashMap<Cell, Boolean> links;
  
  Cell(int x, int y){
    pos = new PVector(x, y);
    links = new HashMap<Cell, Boolean>();
  }
  
  void link(Cell c, boolean bidi) {
    links.put(c,true);
    if( bidi )
      c.link(this, false);
  }
  
  void unlink( Cell c, boolean bidi) {
    links.remove(c);
    if(bidi)
      c.unlink(this, false);
  }
  
  Set<Cell> links(){
    return links.keySet();
  }
  
  boolean isLinked(Cell c) {
    return links.containsKey(c);
  }
  
  Cell[] neighbors() {
    return links.keySet().toArray(new Cell[links.keySet().size()]);
  }
  
}
