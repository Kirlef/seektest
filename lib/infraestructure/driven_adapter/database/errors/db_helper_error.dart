class DbHelperError implements Exception{

  @override
  String toString(){
    return 'Error in process of database';
  }
}