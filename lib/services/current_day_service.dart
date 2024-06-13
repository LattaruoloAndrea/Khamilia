

class CurrentDayService{

  DateTime currentDate(){
    return DateTime.now();
  }
  int currentDay(){
    return DateTime.now().day;
  }
  int currentMonth(){
    return DateTime.now().month;
  }
  int currentYear(){
    return DateTime.now().year;
  }
  
}