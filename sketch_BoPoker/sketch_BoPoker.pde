Game game;
Player p1;
Player p2;
int round;
int num_length;
int dup;


void setup() {
  size(600, 600);
  game = new Game();
  p1 = new Player();
  p2 = new Player();
  round = 1;
  num_length = 6;
  dup = 1;
  game.init(round,dup,num_length,p1,p2);
  
}
void mousePressed(){
  game.clickFlag = true;
  if(game.scene == 1){
    if(10 + game.widthInterval <= mouseX && mouseX <=2*game.widthInterval-20 && 10 + 2 * game.heightInterval <= mouseY){
      p1.choseCard = 0;
    }else if(10 <= mouseX && mouseX <= game.widthInterval-20 && 10 + 2 * game.heightInterval <= mouseY){
      p1.choseCard = 1;
    }else game.clickFlag = false;
  }
}
void draw(){
  background(255);
  if (!game.isEnd) game.playOneGame();
  game.display();
}
