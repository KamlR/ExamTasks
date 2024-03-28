import 'package:flutter/material.dart';
import 'package:travel_application/server/trips_server.dart';

import '../models/trip.dart';
import '../widgets/tripCard.dart';

class AllTripsScreen extends StatefulWidget {
  const AllTripsScreen({super.key});

  @override
  State<AllTripsScreen> createState() => _AllTripsScreenState();
}

class _AllTripsScreenState extends State<AllTripsScreen> {
  static List<Trip>? allTrips;

  @override
  void initState() {
    loadTripsFromServer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: (allTrips == null)
      ? const Center(child: CircularProgressIndicator())
      : allTrips!.isEmpty
        ? const Center(
            child: Text('Актуальных поездок пока нет'),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: allTrips?.length,
            itemBuilder: (context, index) {
              return TripCard(trip: allTrips![index], loadDataFromServer: loadTripsFromServer);
            },
      ),
        
    );
  }

  Future<void> loadTripsFromServer() async{
    allTrips = await ServerTrips().getAllTripsFromServer(1);
    setState(() {});
  }
}