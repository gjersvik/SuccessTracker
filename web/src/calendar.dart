part of success_tacker;

class Calendar{
  Element _elem;
  DateTime _date;
  
  Calendar([selector = "#success"]){
    _elem = query(selector);
  }
  
  updateDate(DateTime day){
    _date = day;
    render();
  }
  
  render(){
    const day = const Duration(days: 1);
    var sb = new StringBuffer();
    sb.write('<div class="hbox head"><div>Monday</div><div>Tuesday</div><div>Wednesday</div><div>Thursday</div><div>Friday</div><div>Saturday</div><div>Sunday</div></div>');
    var month = _date.month;
    var date = new DateTime(_date.year,_date.month,1);
    date = date.add(new Duration(days: (date.weekday - 1) * -1));
    while(date.month <= month){
      sb.write('<div class="hbox">');
      for(var i = 0; i < 7; i += 1){
        if(date.month == month){
          sb.write(_day(date.day, date.isAtSameMomentAs(_date)));
        }else{
          sb.write(_day());
        }
        date = date.add(day);
      }
      sb.write('</div>');
    }
    _elem.innerHtml = sb.toString();
  }
  
  String _day([int day = 0, big = false]){
    var sb = new StringBuffer();
    sb.write('<div');
    if(day != 0){
      sb.write(' id="');
      sb.write(day);
      sb.write('"');
    }
    sb.write(' class="');
    if(day != 0){
      sb.write('day');
    }else{
      sb.write('empty');
    }
    if(big){
      sb.write(' big');
    }
    sb.write('">');
    if(day != 0){
      sb.write(day);
      sb.write(': ');
    }
    sb.write('</div>');
    return sb.toString();
  }
}