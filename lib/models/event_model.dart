class EventModel{
  String? sport;
  String? location;
  String? city;
  int? participantsNumber;
  int? maxAge;
  int? minAge;
  List<dynamic>? participants;
  String? creatorUid;

  EventModel({this.sport,this.location,this.city,this.participantsNumber,this.maxAge,this.minAge,this.participants,this.creatorUid});

  factory EventModel.fromMap(map){
    return EventModel(
        sport: map['sport'],
        location: map['location'],
        city: map['city'],
        participantsNumber: map['participantsNumber'],
        maxAge: map['maxAge'],
        minAge: map['minAge'],
        participants: map['participants'],
        creatorUid: map['creatorUid']
    );
  }
  Map<String,dynamic> toMap(){
    return {
      'sport' : sport,
      'location' : location,
      'city' : city,
      'participantsNumber': participantsNumber,
      'maxAge': maxAge,
      'minAge': minAge,
      'participants': participants,
      'creatorUid' : creatorUid
    };
  }

  @override
  String toString() {
    return 'EventModel{sport: $sport, location: $location, city: $city, participantsNumber: $participantsNumber, maxAge: $maxAge, minAge: $minAge, participants: $participants, creatorUid: $creatorUid}';
  }
}