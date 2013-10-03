part of success_tacker;

class Day{
  final Element elem = new Element.div();
  
  int day;
  int successes;
  bool get focus => elem.classes.contains('big');
  set focus(bool f) => elem.classes.toggle('big', f);
}