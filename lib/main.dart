import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tic_tok_toe/constants/constants.dart';

void main() {
  runApp(const Game());
}

class Game extends StatefulWidget {
  const Game({super.key});

  @override
  State<Game> createState() => _GameState();
}

class _GameState extends State<Game> {
  var icon = true;
  var Player = 'X';
  List<String> xOrOGame = ['', '', '', '', '', '', '', '', ''];
  String winner = '';
  int full = 0;
  bool gameStatus = false;
  int PlayerXScore = 0;
  int PlayerOScore = 0;
  bool drawGame = false;
  int winnerStatus = 0;

  void changeTurn() {
    setState(() {
      this.Player = this.Player == 'X' ? 'O' : 'X';
    });
  }

  void changeGame(item, Player) {
    setState(() {
      if (xOrOGame[item].isEmpty) {
        xOrOGame[item] = Player;
        full += 1;
        changeTurn();
        showWinner();
      }
    });
  }

  Widget ButtonGameRestart() {
    return Visibility(
      visible: gameStatus ? true : false,
      child: OutlinedButton(
        onPressed: () {
          setState(() {
            gameStatus = false;
            drawGame = false;
            winner = '';
            winnerStatus = 0;
            this.xOrOGame = [];
            this.xOrOGame = ['', '', '', '', '', '', '', '', ''];
            this.full = 0;
          });
        },
        child: drawGame
            ? Text(
                'Draw , Click to restart',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: icon ? Colors.orange[900] : Colors.white,
                        fontWeight: FontWeight.w800,
                        fontSize: 18)),
              )
            : Text(
                winnerStatus == 1
                    ? 'winner is ' + winner + '' + ', Click to restart'
                    : '' + 'Click to restart',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: icon ? AppBarLightColor : Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 18)),
              ),
        style: OutlinedButton.styleFrom(
            side: BorderSide(
                color: icon ? AppBarLightColor : Colors.white,
                style: BorderStyle.solid),
            minimumSize: Size(150, 50)),
      ),
    );
  }

  void clearGame() {
    setState(() {
      this.xOrOGame = [];
      this.xOrOGame = ['', '', '', '', '', '', '', '', ''];
      this.full = 0;
      this.PlayerOScore = 0;
      this.PlayerXScore = 0;
      this.gameStatus = false;
    });
  }

  void changeIcon() {
    setState(() {
      this.icon = this.icon ? false : true;
    });
  }

  Widget makeGame() {
    return Expanded(
      child: SizedBox(
        width: 400,
        child: GridView.builder(
          itemCount: 9,
          gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
          itemBuilder: (BuildContext context, int index) {
            return makeBlock(index);
          },
        ),
      ),
    );
  }

  void see(int num1, int num2, int num3) {
    if (xOrOGame[num1] == xOrOGame[num2] &&
        xOrOGame[num1] == xOrOGame[num3] &&
        xOrOGame[num1] != '') {
      setState(() {
        this.winner = xOrOGame[num1];
        xOrOGame[num1] == 'X' ? PlayerXScore += 1 : PlayerOScore += 1;
        this.gameStatus = true;
        this.winnerStatus = 1;
      });
      return;
    }
    if (full == 9) {
      this.drawGame = true;
      this.gameStatus = true;
    }
  }

  void showWinner() {
    see(0, 1, 2);
    see(3, 4, 5);
    see(6, 7, 8);
    see(0, 4, 8);
    see(2, 4, 6);
    see(0, 3, 6);
    see(1, 4, 7);
    see(2, 5, 8);
  }

  String showPlayer(item) {
    return xOrOGame[item];
  }

  Widget makeBlock(int index) {
    return Padding(
      padding: EdgeInsets.all(5),
      child: GestureDetector(
        onTap: gameStatus == false
            ? () {
                changeGame(index, Player);
              }
            : null,
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                showPlayer(index),
                style: TextStyle(
                    color: xOrOGame[index] == 'X' ? PlayerX : PlayerO,
                    fontSize: 49,
                    fontWeight: FontWeight.w900),
              ),
            ],
          ),
          width: 100,
          height: 100,
          decoration: icon
              ? BoxDecoration(color: Colors.grey[300])
              : BoxDecoration(color: Colors.white54),
        ),
      ),
    );
  }

  Widget turnUser() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      SizedBox(
        height: gameStatus ? 100 : 150,
      ),
      Container(
        width: 140,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
              color: icon ? AppBarLightColor : Colors.white, width: 2),
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              'Player $Player',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                    color: icon ? AppBarLightColor : Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 27),
              ),
            ),
          ),
        ),
      ),
      SizedBox(
        height: 80,
      )
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: icon ? lightTheme : darkTheme,
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: icon ? AppBarLightColor : null,
            elevation: icon ? 0 : 10,
            centerTitle: true,
            actions: [
              IconButton(
                  onPressed: () {
                    clearGame();
                  },
                  icon: Icon(Icons.replay_outlined)),
            ],
            leading: IconButton(
                onPressed: () {
                  changeIcon();
                },
                icon: Icon(
                  this.icon ? Icons.sunny : Icons.nights_stay,
                  color: this.icon ? Colors.yellowAccent : Colors.grey,
                )),
            title: Text('Tik Tak Toe',
                style: GoogleFonts.roboto(
                    textStyle: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.w900))),
          ),
          body: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                    left: 10,
                    right: 10,
                    top: 22,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Image.asset('assets/1.png'),
                              radius: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Player O',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: PlayerO, fontSize: 22))),
                                SizedBox(height: 10,),

                            Text('$PlayerOScore',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: icon ? PlayerO : Colors.white,
                                        fontSize: 22))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Image.asset('assets/2.png'),
                              radius: 30,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text('Player X',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: PlayerX, fontSize: 22))),
                                SizedBox(height: 10,),
                         
                            Text('$PlayerXScore',
                                style: GoogleFonts.roboto(
                                    textStyle: TextStyle(
                                        color: icon ? PlayerX : Colors.white,
                                        fontSize: 22))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20,),
                ButtonGameRestart(),
                SizedBox(
                  height: 20,
                ),
                makeGame(),
                turnUser()
              ],
            ),
          ),
        ));
  }
}
