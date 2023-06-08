class BookingModel {
  String? movieName;
  String? bookingDate;
  String? userName;
  String? email;
  String? contact;
  String? date;
  String? totalTickets;
  String? timeSlot;

  BookingModel({
      this.movieName, 
      this.bookingDate, 
      this.userName, 
      this.email, 
      this.contact, 
      this.date, 
      this.totalTickets, 
      this.timeSlot, 
     });

  BookingModel.fromJson(dynamic json) {
    movieName = json['movie_name'];
    bookingDate = json['booking_date'];
    userName = json['user_name'];
    email = json['email'];
    contact = json['contact'];
    date = json['date'];
    totalTickets = json['total_tickets'];
    timeSlot = json['time_slot'];
  }


  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['movie_name'] = movieName;
    map['booking_date'] = bookingDate;
    map['user_name'] = userName;
    map['email'] = email;
    map['contact'] = contact;
    map['date'] = date;
    map['total_tickets'] = totalTickets;
    map['time_slot'] = timeSlot;
    return map;
  }

}