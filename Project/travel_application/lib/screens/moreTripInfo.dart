import 'package:flutter/material.dart';
import 'package:travel_application/server/trips_server.dart';
import '../models/trip.dart';
import '../widgets/longInfo.dart';
import '../widgets/shortInfo.dart';

class TripMoreInfoScreen extends StatefulWidget {
  final Trip trip;
  final VoidCallback loadDataFromServer;
  const TripMoreInfoScreen({Key? key, required this.trip, required this.loadDataFromServer}) : super(key: key);

  @override
  State<TripMoreInfoScreen> createState() => _TripMoreInfoScreenState();
}

class _TripMoreInfoScreenState extends State<TripMoreInfoScreen> {
  String participation = "";
  late Trip trip;
  @override
  void initState() {
    trip = widget.trip;
    loadSubscribeInfoFromServer();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: const Text('Trip details'),
      ),
      body: participation == ""
      ? const Center(child: CircularProgressIndicator())
      :Expanded(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.network(
                            trip.imageUrl,
                            width: 400,
                            height: 150,
                            fit: BoxFit.cover,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Text(
                  trip.title,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
              const SizedBox(height: 30),
              NewsDetailsShort(
                labelText: 'Destination',
                valueText: trip.destination,
              ),
              NewsDetailsShort(
                labelText: 'Number of days',
                valueText: trip.numberOfDays.toString(),
              ),
              NewsDetailsShort(
                labelText: 'Number of people',
                valueText: trip.numberOfPeople.toString(),
              ),
              const SizedBox(height: 50),
              NewsDetailsLong(
                labelText: 'Description',
                valueText: trip.description,
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () async {
            if (participation == "Отсоединиться"){
              await ServerTrips().sendUnRegistrTripInfo(trip.id);
              participation = "Присоединиться";
            }
            else{
              await ServerTrips().sendRegistrTripInfo(trip.id);
              participation = "Отсоединиться";
            }
            widget.loadDataFromServer();
            setState(() {});
          },
          child: Text(participation),
        ),
      ),
    );
  }

  Future<void> loadSubscribeInfoFromServer() async{
    bool result = await ServerTrips().getSubscribeInfo(trip.id);
    if (result){
      participation = "Отсоединиться";
    }
    else{
      participation = "Присоединиться";
    }
    setState(() {});
  }
}
