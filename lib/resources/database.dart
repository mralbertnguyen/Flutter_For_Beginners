// Create private  constructor that can be used only inside the class
class DBProvider{
  DBProvider._();
  static final DBProvider db = DBProvider._();
}


