class Game {

  IntList deck = new IntList();
  int scene;
  //setting player
  Player player1;
  Player player2;  
  int subject;
  int trade;
  boolean player1Chose;
  boolean player2Chose;
  int round;
  int winFlag;
  boolean clickFlag = false;
  boolean has_done = false;
  boolean isEnd = false;
  int widthInterval = width/4;
  int heightInterval = height/3;

  //init 
  void init(int _round, int d, int num, Player p1, Player p2) {
    player1 = p1;
    player2 = p2;
    round = _round;
    makeDeck(d, num);
    scene = 0;
  }

  //make deck
  void makeDeck(int duplicates, int num_length) {
    for (int i = 1; i < duplicates * num_length+1; i++) {
      deck.append(int(i/duplicates));
    }
    deck.shuffle();
    println("The deck is" + deck);
  }

  //display
  void display() {
    //glid line
    for (int i = 1; i < 4; i++) {
      line(i * widthInterval, 0, i * widthInterval, height);
    }
    for (int i = 1; i < 3; i++) {
      line(0, i*heightInterval, width, i * heightInterval);
    }

    //deck display
    for (int i = 0; i < deck.size(); i++) {
      rect(10 + 2 * widthInterval +i, 10 + 1 * heightInterval + i, widthInterval-20, heightInterval-20);
    }
    fill(0);
    textSize(16);
    textAlign(CENTER);
    text("????", 2*widthInterval + widthInterval/ 2, 1* heightInterval + heightInterval /2 );
    fill(255);




    //P1 open
    rect(10 + widthInterval, 10 + 2 * heightInterval, widthInterval-20, heightInterval-20);
    fill(0);
    textSize(16);
    textAlign(CENTER);
    text(player1.myHand.get(0), widthInterval * 3 / 2, 2 * heightInterval + heightInterval /2 );
    fill(255);

    //P1 close
    rect(10 + 0 * widthInterval, 10 + 2 * heightInterval, widthInterval-20, heightInterval-20);
    fill(0);
    textSize(16);
    textAlign(CENTER);
    text(player1.myHand.get(1), 0*widthInterval + widthInterval/ 2, 2* heightInterval + heightInterval /2 );
    fill(255);

    //P2 open
    rect(10 + 2 * widthInterval, 10 + 0 * heightInterval, widthInterval-20, heightInterval-20);
    fill(0);
    textSize(16);
    textAlign(CENTER);
    text(player2.myHand.get(0), 2*widthInterval + widthInterval/ 2, 0* heightInterval + heightInterval /2 );
    fill(255);

    //P2 close
    rect(10 + 3 * widthInterval, 10 + 0 * heightInterval, widthInterval-20, heightInterval-20);
    fill(0);
    textSize(16);
    textAlign(CENTER);
    if (scene == 2) text(player2.myHand.get(1), 3*widthInterval + widthInterval/ 2, 0* heightInterval + heightInterval /2 );
    else text("????", 3*widthInterval + widthInterval/ 2, 0* heightInterval + heightInterval /2 );
    fill(255);


    //subject
    rect(10 + 1 * widthInterval, 10 + 1 * heightInterval, widthInterval-20, heightInterval-20);
    fill(0);
    textSize(16);
    textAlign(CENTER);
    text(subject, 1*widthInterval + widthInterval/ 2, 1* heightInterval + heightInterval /2 );
    fill(255);
  }

  //play one game
  void playOneGame() {
    int count = 0;
    //set hands
    if (scene == 0) {
      if (!has_done) {
        println("Now scene is "+scene);
        setOneRound(player1, player2);

        has_done = true;
      }
      clickOK();
    } else if (scene == 1) {
      //Players chose card they trade.
      if (!has_done) {
        clickFlag = true;
        println("Now scene is "+scene);
        //chose one card
        player1.UseCard(player1.choseCard);
        player2.playRandomOneCard(player2Chose);
        trade(player1, player2);
        has_done = true;
        clickOK();
        println(scene);
      }
    } else if (scene == 2) {
      if (!has_done) {

        //battle
        battle(player1, player2);
        println("winner is Player"+winFlag);
        has_done = true;
      }
      clickOK();
    } else {
      count ++;
    }   

    if (count == round) {
      isEnd = true;
      scene = -1;
      clickOK();
    }
  }


  //setting game
  void setOneRound(Player player1, Player player2) {
    player1.getOneCard(deck);
    player2.getOneCard(deck);
    subject = deck.get(0);
    deck.remove(0);
  }

  void trade(Player player1, Player player2) {
    trade = player1.trade;
    player1.myHand.append(player2.trade);
    player2.myHand.append(trade);
    println("Player1 has "+player1.myHand + ",and Player2 has "+ player2.myHand);
  }


  void battle(Player player1, Player player2) {
    int p0[] = {player1.myHand.get(0), player1.myHand.get(1)};
    int p1[] = {player2.myHand.get(0), player2.myHand.get(1)};
    int differenceP[] = {abs(p0[0]-p0[1]), abs(p1[0]-p1[1])};
    int addP[] = {p0[0] + p0[1], p1[0] + p1[1]};
    int conclusionP[] = {min(abs(subject-differenceP[0]), abs(subject-addP[0])), min(abs(subject-differenceP[1]), abs(subject-addP[1]))};
    println("P1 Conclusion is"+conclusionP[0] + " And P2 Conclusion is"+conclusionP[1]);
    if (conclusionP[0] < conclusionP[1]) winFlag = 1;
    else if (conclusionP[0] > conclusionP[1]) winFlag = 2;
    else winFlag = 3;
  }



  void clickOK() {
    if (clickFlag) {
      scene ++;
      println("clicked!");
      clickFlag = false;
      has_done = false;
    }
  }

  //player2がランダムに選択する場合の勝率期待値計算
  float randExpectedValue() {
    Game tempGame ;
    Player tempP1;
    Player tempP2;
    int p1Count = 0;
    
    println("--------------");    
    for (int p1Chose = 0; p1Chose <2; p1Chose ++) {
      for (int p2Chose = 0; p2Chose <2; p2Chose ++) {
        tempGame  = game;
        tempP1 = player1;
        tempP2 = player2;
        tempP1.trade = tempP1.myHand.get(p1Chose);
        tempP2.trade = tempP2.myHand.get(p2Chose);
        tempGame.trade(tempP1,tempP2);
        tempGame.battle(tempP1,tempP2);
        if(tempGame.winFlag == 1){
          println("If you chose "+ tempP1.trade+", you win");
          p1Count ++ ;
        }
      }
    }
    println("--------------");
    return p1Count / 4;
  }
}
