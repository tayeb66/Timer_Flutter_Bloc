import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable{
   final int duration;
  TimerState(this.duration);

  @override
  List<int> get props => [duration!];
}

class TimerInitial extends TimerState{
  TimerInitial(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunningProcess extends TimerState{
   TimerRunningProcess(super.duration);

   @override
  String toString() => "TimerInRunningProcess {duration: $duration}";

}

class TimerRunPause extends TimerState {
   TimerRunPause(super.duration);

  @override
  String toString() => 'TimerRunPause { duration: $duration }';
}

class TimerRunComplete extends TimerState{
  TimerRunComplete() : super(0);
}