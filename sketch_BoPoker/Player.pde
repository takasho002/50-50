class Player extends Game {
  IntList myHand = new IntList();
  int trade;
  boolean choseZero;
  int choseCard;

  void getOneCard(IntList deck) {
    myHand.append(deck.get(0));
    myHand.append(deck.get(1));
    deck.remove(0);
    deck.remove(0);
    println("My hands are " + myHand+". The deck has" + deck);
  }
  
  void playRandomOneCard(boolean choseZero) {
    if (choseZero) {
      trade = myHand.get(0);
      myHand.remove(0);
    } else {
      trade = myHand.get(1);
      myHand.remove(1);
    }
    println("I chosed my trade card. It's " + trade + ". And now I have" + myHand);
  }
  
  void UseCard(int choseCard){
    trade = myHand.get(choseCard);
    myHand.remove(choseCard);
  }
  
  boolean choseOneCard(){
    //
    int rand = (int)random(0,2);
    if(rand/2 == 0){
      choseZero = true;
      print(myHand.get(0)+"was chosen!");
    }else{
      choseZero = false;
      print(myHand.get(1)+"was chosen!");
    }
    return choseZero;
  }  
}
