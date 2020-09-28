import 'package:flutter/material.dart';
import 'package:music_player/music_player.dart';

class Songplay1 extends StatefulWidget {
  String song_name,song_url,image_url,artist_name;
  Songplay1({
    this.artist_name,this.image_url,this.song_name,this.song_url
  });
  @override
  _Songplay1State createState() => _Songplay1State();
}

class _Songplay1State extends State<Songplay1>{

  MusicPlayer musicplayer;
  bool isplaying=false;
  
  @override
  void initState() {
    super.initState();
    initPlateformState();
  }

  @override
  Future<void> initPlateformState() async{
    musicplayer = MusicPlayer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("song player"),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.song_name,
              style: TextStyle(fontSize: 30.0),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              widget.artist_name,
              style: TextStyle(fontSize: 15.0),
            ),
            Card(
              child: Image.network(widget.image_url,height: 240.0,),
              elevation: 25.0,
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 50.0,
                ),
                Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        isplaying=true;
                      });
                      musicplayer.play(
                        MusicItem(
                          url: widget.song_url,
                          trackName: widget.song_name,
                          artistName: widget.artist_name,
                          albumName: widget.song_name,
                          coverUrl: widget.image_url,
                          duration: Duration(seconds:255),
                          )
                      );
                    }, 
                    child: Icon(
                      Icons.play_arrow,
                      size: 25.0,
                      color: isplaying==true?Colors.blue:Colors.black12,
                      ),
                    )   
                 ),
                 Expanded(
                  child: FlatButton(
                    onPressed: (){
                      setState(() {
                        isplaying=false;
                      });
                      musicplayer.stop();
                    }, 
                    child: Icon(
                      Icons.stop,
                      size: 25.0,
                      color: isplaying==false?Colors.blue:Colors.black12,
                      ),
                    )   
                 ),
                 SizedBox(
                  width: 50.0,
                ),
              ],
            ),
          ],
        ),


        

      ),
    );
  }
}