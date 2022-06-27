import 'package:ballskin/api/service.dart';
import 'package:ballskin/pages/team_standings/team_standings_widget.dart';
import 'package:ballskin/style/style.dart';
import 'package:flutter/material.dart';

class LegauesWidget extends StatefulWidget {
  const LegauesWidget(
      {Key? key, required this.countryId, required this.countryName})
      : super(key: key);

  final countryId;
  final String countryName;

  @override
  State<LegauesWidget> createState() => _CountriesState();
}

class _CountriesState extends State<LegauesWidget> {
  final apiClient = ApiClient();

  @override
  void initState() {
    super.initState();
    widget.countryName;
    apiClient.fetchLeagues(widget.countryId);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: apiClient.fetchLeagues(widget.countryId),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              return Scaffold(
                appBar: AppBar(
                  backgroundColor: Color.fromRGBO(28, 27, 31, 1),
                  title: Text('${widget.countryName} - все лиги'),
                  centerTitle: true,
                ),
                backgroundColor: Colors.black,
                body: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data.length,
                      itemBuilder: (BuildContext context, index) {
                        return GestureDetector(
                          /*onTap: () =>
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => TeamStandingWidget(
                                        leagueId:
                                            snapshot.data[index].league.id,
                                        leagueName:
                                            snapshot.data[index].league.name,
                                      )))*/
                          child: Card(
                            borderOnForeground: true,
                            shape: RoundedRectangleBorder(
                                side: BorderSide(color: Colors.white, width: 2),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10.0))),
                            color: Color.fromRGBO(28, 27, 31, 1),
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10.0),
                                bottomLeft: Radius.circular(10.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(35.0),
                                child: Row(
                                  children: [
                                    Flexible(
                                        child: Text(
                                      "${snapshot.data[index]["name"]}",
                                      style: leaguesStyle(),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              );
            } else {
              return Center(
                child: Text('Нет данных'),
              );
            }
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else {
            return Center(
              child: Icon(
                Icons.error,
                color: Colors.white,
              ),
            );
          }
        });
  }
}
