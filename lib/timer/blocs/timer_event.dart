abstract class TimerEvent{
  const TimerEvent();
}

class TimeStarted extends TimerEvent{
  late final int duration;
  TimeStarted({required this.duration});
}

class TimerPause extends TimerEvent{
  TimerPause();
}

class TimerResume extends TimerEvent{
  TimerResume();
}

class TimerReset extends TimerEvent{
  TimerReset();
}

class TimerTicked extends TimerEvent{
  late final int? duration;
  TimerTicked({this.duration});
}