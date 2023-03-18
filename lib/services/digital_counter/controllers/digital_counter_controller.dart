class DigitalCounterController {
  int _counter = 0;
  int _turn = 0;
  int _totalCounter = 0;

  int get totalCounter => _totalCounter;
  int get counter => _counter;
  int get turn => _turn;

  //=========================================================================
  //=========================================================================
  //=============================== Functions ===============================
  void increment() {
    if (!_checkTurn()) _counter++;
    _totalCounter++;
  }

  bool _checkTurn() {
    if (_counter == 32) {
      _turn++;
      _counter = 0;
      return true;
    }
    return false;
  }

  void reset() {
    _counter = 0;
    _totalCounter = 0;
    _turn = 0;
  }
}
