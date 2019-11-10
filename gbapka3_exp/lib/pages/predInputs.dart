import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gbapka3/pages/dictionaries/dictionaries.dart';
import 'package:gbapka3/pages/prediction.dart';

class PredInputsPage extends StatefulWidget {
  const PredInputsPage({
    Key key,
    @required this.user
  }) : super(key: key);
  final FirebaseUser user;

  @override
  _PredInputsPageState createState() => _PredInputsPageState();
}

class _PredInputsPageState extends State<PredInputsPage> {
  List<DoW_dict> _Days = DoW_dict.getDoW_dict();   List<DropdownMenuItem<DoW_dict>> _ddItems_Days;   DoW_dict _selectedDay;
  List<Season_dict> _Seasons = Season_dict.getSeason_dict();   List<DropdownMenuItem<Season_dict>> _ddItems_Seasons;   Season_dict _selectedSeason;
  List< ToD_dict > _ToD = ToD_dict.getToD_dict();   List<DropdownMenuItem<ToD_dict>> _ddItems_ToD;   ToD_dict _selectedToD;
  List< Airline_dict > _Airline = Airline_dict.getAirline_dict();   List<DropdownMenuItem< Airline_dict >> _ddItems_Airline;   Airline_dict _selectedAirline;
  List< Destination_dict> _Destination = Destination_dict.getDestination_dict();   List<DropdownMenuItem< Destination_dict>> _ddItems_Destination;   Destination_dict _selectedDestination;
  List< Destination_dict> _From = Destination_dict.getDestination_dict();   List<DropdownMenuItem< Destination_dict>> _ddItems_From;   Destination_dict _selectedFrom;

//  ScrollController _scrollController = new ScrollController();
  @override
  void initState() {
    _ddItems_Days = build_ddItems_Days(_Days);
    _ddItems_Seasons= build_ddItems_Seasons(_Seasons);
    _ddItems_ToD= build_ddItems_ToD(_ToD);
    _ddItems_Airline= build_ddItems_Airline(_Airline);
    _ddItems_From= build_ddItems_Destination(_Destination);
    _ddItems_Destination= build_ddItems_Destination(_Destination);

    _selectedFrom = _ddItems_From[216].value;
    _selectedDestination = _ddItems_Destination[268].value;
    _selectedAirline = _ddItems_Airline[0].value;
    _selectedSeason = _ddItems_Seasons[3].value;
    _selectedDay = _ddItems_Days[0].value;
    _selectedToD = _ddItems_ToD[0].value;
    super.initState();
  }

  // Creat drop down lists
  List<DropdownMenuItem<DoW_dict>> build_ddItems_Days(List days) {
    List<DropdownMenuItem<DoW_dict>> items = List(); for (DoW_dict day in days) { items.add(DropdownMenuItem(value: day, child: Text(day.name, style: TextStyle(color: Colors.deepOrange, fontSize: 18, fontWeight: FontWeight.bold)), ), ); }
    return items; }

  List<DropdownMenuItem<Season_dict>> build_ddItems_Seasons(List seasons) {
    List<DropdownMenuItem<Season_dict>> items = List(); for (Season_dict season in seasons) { items.add(DropdownMenuItem(value: season, child: Text(season.name, style: TextStyle(color: Colors.deepOrange, fontSize: 18, fontWeight: FontWeight.bold)), ), ); }
    return items; }

  List<DropdownMenuItem<ToD_dict>> build_ddItems_ToD(List ToDs) {
    List<DropdownMenuItem<ToD_dict>> items = List(); for (ToD_dict ToD in ToDs) { items.add(DropdownMenuItem(value: ToD, child: Text(ToD.name, style: TextStyle(color: Colors.deepOrange, fontSize: 18, fontWeight: FontWeight.bold)), ), ); }
    return items; }

  List<DropdownMenuItem<Airline_dict>> build_ddItems_Airline(List Airlines) {
    List<DropdownMenuItem<Airline_dict>> items = List(); for (Airline_dict Airline in Airlines) { items.add(DropdownMenuItem(value: Airline, child: Text(Airline.name, style: TextStyle(color: Colors.deepOrange, fontSize: 18, fontWeight: FontWeight.bold)), ), ); }
    return items; }

  List<DropdownMenuItem<Destination_dict>> build_ddItems_Destination(List Destinations) {
    List<DropdownMenuItem<Destination_dict>> items = List(); for (Destination_dict Destination in Destinations) { items.add(DropdownMenuItem(value: Destination, child: Text(Destination.name, style: TextStyle(color: Colors.deepOrange, fontSize: 18, fontWeight: FontWeight.bold)), ), ); }
    return items; }

// On change functions for Drop Down lists
  onChange_ddItems_Days(DoW_dict selectedDay) { setState(() { _selectedDay = selectedDay; }); }
  onChange_ddItems_Seasons( Season_dict selectedSeason) { setState(() { _selectedSeason = selectedSeason; }); }
  onChange_ddItems_ToDs( ToD_dict selectedToD) { setState(() { _selectedToD = selectedToD; }); }
  onChange_ddItems_Airlines( Airline_dict selectedAirline) { setState(() { _selectedAirline = selectedAirline; }); }
  onChange_ddItems_From( Destination_dict selectedFrom) { setState(() { _selectedFrom = selectedFrom; }); }
  onChange_ddItems_Destination( Destination_dict selectedDestination) { setState(() { _selectedDestination = selectedDestination; }); }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar( title: Text('Inputs', textAlign: TextAlign.left)
        ),
      body: ListView(
        children: <Widget>[
          Container(
            transform: Matrix4.translationValues(0.0, 10.0, 0.0),
            child: Center(child: Text('Flight Details', textAlign: TextAlign.center, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)),
            ),
          Container(
            transform: Matrix4.translationValues(0.0, 5.0, 0.0),
            child: ListTile(leading: Icon(Icons.flight_takeoff  , color: Colors.deepOrange),title: Text('Flight From:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
                ),  ),
          Container(
            transform: Matrix4.translationValues(15.0, -10.0, 0.0),
            child: Center(child: DropdownButton( value: _selectedFrom, items: _ddItems_From, onChanged: onChange_ddItems_From, iconEnabledColor: Colors.blue,  iconSize: 36,),),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: ListTile(leading: Icon(Icons.flight_land  , color: Colors.deepOrange),title: Text('Flight To:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
          ), ),
          Container(
            transform: Matrix4.translationValues(15.0, -20.0, 0.0),
            child: Center( child: DropdownButton( value: _selectedDestination, items: _ddItems_Destination, onChanged: onChange_ddItems_Destination, iconEnabledColor: Colors.blue, iconSize: 36,),),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: ListTile(leading: Icon(Icons.local_airport  , color: Colors.deepOrange),title: Text('Airline:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
          ), ),
          Container(
            transform: Matrix4.translationValues(15.0, -20.0, 0.0),
            child: Center( child: DropdownButton( value: _selectedAirline, items: _ddItems_Airline, onChanged: onChange_ddItems_Airlines, iconEnabledColor: Colors.blue, iconSize: 36,),),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: ListTile(leading: Icon(Icons.local_florist  , color: Colors.deepOrange),title: Text('Season:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
          ), ),
          Container(
            transform: Matrix4.translationValues(-85.0, -20.0, 0.0),
            child: Center( child: DropdownButton( value: _selectedSeason, items: _ddItems_Seasons, onChanged: onChange_ddItems_Seasons, iconEnabledColor: Colors.blue, iconSize: 36,),),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: ListTile(leading: Icon(Icons.today  , color: Colors.deepOrange),title: Text('Day of Week:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
          ), ),
          Container(
            transform: Matrix4.translationValues(-75.0, -20.0, 0.0),
            child: Center( child: DropdownButton( value: _selectedDay, items: _ddItems_Days, onChanged: onChange_ddItems_Days, iconEnabledColor: Colors.blue, iconSize: 36,),),
          ),
          Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: ListTile(leading: Icon(Icons.brightness_4  , color: Colors.deepOrange),title: Text('Time of Day:', textAlign: TextAlign.left, style: TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),)
            ), ),
          Container(
            transform: Matrix4.translationValues(-25.0, -20.0, 0.0),
            child: Center( child: DropdownButton( value: _selectedToD, items: _ddItems_ToD, onChanged: onChange_ddItems_ToDs, iconEnabledColor: Colors.blue, iconSize: 36,),),
          ),
//          Text('\n'),
          Container(
            transform: Matrix4.translationValues(0.0, 0.0, 0.0),
            child: RaisedButton( onPressed: toPrediction, child: Text('Predict',style: TextStyle(color: Colors.white, fontSize: 28)), color: Colors.lime[600],  textColor: Colors.white, ),
          ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
  void toPrediction(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PredictionPage(user: widget.user,
        in_from: _selectedFrom.name,
        in_to: _selectedDestination.name,
        in_airline: _selectedAirline.name,
        in_season: _selectedSeason.name,
        in_DoW: _selectedDay.name,
        in_ToD: _selectedToD.name,
        in_id_from: _selectedFrom.id,
        in_id_to: _selectedDestination.id,
        in_id_airline: _selectedAirline.id,
        in_id_season: _selectedSeason.id,
        in_id_DoW: _selectedDay.id,
        in_id_ToD: _selectedToD.id
    )));
  }

}