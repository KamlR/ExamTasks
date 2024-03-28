import 'package:flutter/material.dart';
import 'package:travel_application/server/trips_server.dart';

import '../../models/trip.dart';
import '../../widgets/tripCard.dart';



class CreatedTripsScreen extends StatefulWidget {
  const CreatedTripsScreen({super.key});

  @override
  State<CreatedTripsScreen> createState() => _CreatedTripsScreenState();
}

class _CreatedTripsScreenState extends State<CreatedTripsScreen> {
  static List<Trip>? createdTrips;

  @override
  void initState() {
    loadCreatedTripsFromServer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoTrips'),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: (createdTrips == null)
      ? const Center(child: CircularProgressIndicator())
      : createdTrips!.isEmpty
        ? const Center(
            child: Text('Актуальных поездок пока нет'),
          )
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: createdTrips?.length,
            itemBuilder: (context, index) {
              return TripCard(trip: createdTrips![index], loadDataFromServer: loadCreatedTripsFromServer);
            },
      ),
        
    );
  }

  Future<void> loadCreatedTripsFromServer() async{
    createdTrips = await ServerTrips().getAllTripsFromServer(3);
    setState(() {});
  }
}