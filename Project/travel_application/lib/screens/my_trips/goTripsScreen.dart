import 'package:flutter/material.dart';
import 'package:travel_application/server/trips_server.dart';

import '../../models/trip.dart';
import '../../widgets/tripCard.dart';



class GoTripsScreen extends StatefulWidget {
  const GoTripsScreen({super.key});

  @override
  State<GoTripsScreen> createState() => _GoTripsScreenState();
}

class _GoTripsScreenState extends State<GoTripsScreen> {
  static List<Trip>? goTrips;

  @override
  void initState() {
    loadGoTripsFromServer();
    super.initState();
  }
  @override
  void didUpdateWidget(GoTripsScreen oldWidget) {
      super.didUpdateWidget(oldWidget);
      loadGoTripsFromServer();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoTrips'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: (goTrips == null)
      ? const Center(child: CircularProgressIndicator())
      : goTrips!.isEmpty
        ? const Center(
            child: Text('Актуальных поездок пока нет'),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: goTrips?.length,
            itemBuilder: (context, index) {
              return TripCard(trip: goTrips![index], loadDataFromServer: loadGoTripsFromServer);
            },
      ),
        
    );
  }

  Future<void> loadGoTripsFromServer() async{
    goTrips = await ServerTrips().getAllTripsFromServer(2);
    setState(() {});
  }
}