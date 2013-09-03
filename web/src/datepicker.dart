part of success_tacker;

class DatePicker{
  Element _elem;
  Element _datetext;
  DateTime _current = new DateTime(1900);
  StreamController<DateTime> _sink = new StreamController.broadcast();
  
  Stream<DateTime> onDateChange;
  
  DatePicker([selector = "#datepic"]){
    onDateChange = _sink.stream;
    _elem = query(selector);
    _datetext = _elem.query("span");
    _elem.query(".mounth-inc").onClick.listen(_nextMonth);
    _elem.query(".mounth-dec").onClick.listen(_prevMonth);
    _elem.query(".day-inc").onClick.listen(_nextDay);
    _elem.query(".day-dec").onClick.listen(_prevDay);
  }
  
  update(DateTime day){
    day = new DateTime(day.year,day.month,day.day);
    if(!_current.isAtSameMomentAs(day)){
      _current = day;
      _sink.add(_current);
      _render();
    }
  }
  
  _render(){
    var sb = new StringBuffer();
    sb.write('<span>');
    sb.write(new DateFormat('EEEE').format(_current));
    sb.write('<br></span>');
    sb.write(new DateFormat('d. MMMM yyyy').format(_current));
    _datetext.innerHtml = sb.toString();
  }
  
  _nextDay(_){
    update(_current.add(new Duration(days:1)));
  }
  
  _prevDay(_){
    update(_current.add(new Duration(days:-1)));
  }
  
  _nextMonth(_){
    var date = new DateTime(_current.year,_current.month + 1, _current.day);
    update(date);
  }
  
  _prevMonth(_){
    var date = new DateTime(_current.year,_current.month - 1, _current.day);
    update(date);
  }
}