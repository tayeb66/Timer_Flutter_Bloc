import 'dart:async';

import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:timer_bloc/ticker.dart';
import 'package:timer_bloc/timer/blocs/timer_event.dart';
import 'package:timer_bloc/timer/blocs/timer_state.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker1 _ticker1;
  static const int _duration = 60;

  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker1 ticker1})
      : _ticker1 = ticker1,
        super(TimerInitial(_duration)) {
    on<TimeStarted>(_onStarted);
    on<TimerTicked>(_onTick);
    on<TimerPause>(_onPaused);
    on<TimerResume>(_onResumed);
    on<TimerReset>(_onReset);
  }

  @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

  void _onStarted(TimeStarted? event, Emitter<TimerState> emit) {
    emit(TimerRunningProcess(event!.duration!));
    _tickerSubscription?.cancel();
    _tickerSubscription =
        _ticker1.tick(ticks: event.duration).listen((duration) {
      add(TimerTicked(duration: duration));
    });
  }

  void _onPaused(TimerPause? event, Emitter<TimerState>emit){
    if(state is TimerRunningProcess){
      _tickerSubscription!.pause();
      emit(TimerRunPause(state.duration));
    }
  }
  
  void _onResumed(TimerResume resume, Emitter<TimerState>emit){
    if(state is TimerPause){
      _tickerSubscription!.resume();
      emit(TimerRunningProcess(state.duration));
    }
  }

  void _onReset(TimerReset event, Emitter<TimerState>emit){
    _tickerSubscription!.cancel();
    emit(TimerInitial(state.duration));
  }

  void _onTick(TimerTicked? event, Emitter<TimerState> emit) {
    emit(event!.duration! > 0
        ? TimerRunningProcess(event.duration ?? 0)
        : TimerRunComplete());
  }
}
