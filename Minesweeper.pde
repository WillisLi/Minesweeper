import de.bezier.guido.*;
public final static int NUM_ROWS = 20;
public final static int NUM_COLS = 20;
public final static int NUM_BOMBS = 20;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs = new ArrayList <MSButton>(); //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(400, 400);
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    
    //your code to initialize buttons goes here
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    for(int r = 0; r < NUM_ROWS; r++)
      for(int c = 0; c < NUM_COLS; c++)
        buttons[r][c] = new MSButton(r, c);
    setBombs();
}
public void setBombs()
{
    while(bombs.size() < NUM_BOMBS){
    int r = (int)(Math.random() * 20);
    int c = (int)(Math.random() * 20);
    if(!bombs.contains(buttons[r][c])){
      bombs.add(buttons[r][c]);
      System.out.println(r + ", " + c);
      }
    }
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
}
public boolean isWon()
{
    int winCount = 0;
    for(int i = 0; i < bombs.size(); i++)
      if(bombs.get(i).isMarked() == true){
        winCount = winCount + 1;
        if(winCount == bombs.size())
          return true;
        }
    return false;
}
public void displayLosingMessage()
{
    for(int i = 0; i < bombs.size(); i++){
      bombs.get(i).clicked = true;
      bombs.get(i).setLabel(">:)");
    }
}
public void displayWinningMessage()
{
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS;c++){
        buttons[r][c].setLabel(":)");
}

public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
    
    public MSButton ( int rr, int cc )
    {
        width = 400/NUM_COLS;
        height = 400/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    // called by manager
    
    public void mousePressed () 
    {
        clicked = true;
        if(mouseButton == RIGHT)
          marked = true;
        if(mouseButton == RIGHT && marked == false){
          clicked = false;
        }else if(bombs.contains(this)){
          displayLosingMessage();
        }else if(countBombs(r, c) > 0){
          label = "" + countBombs(r, c);
        }else{
          buttons[r][c - 1].mousePressed();
        }
    }

    public void draw () 
    {    
        if (marked)
            fill(0);
        else if( clicked && bombs.contains(this) ) 
          fill(255,0,0);
        else if(clicked)
            fill( 200 );
        else 
            fill( 100 );

        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
        if(r >= 0 && r < 10 && c >=0 && c < 10)
          return true;
         else
           return false;
    }
    public int countBombs(int row, int col)
    {
        int numBombs = 0;
        
        return numBombs;
    }
}
