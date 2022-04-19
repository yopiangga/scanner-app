part of 'helper.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'document.db';

    //create, read databases
    var todoDatabase = openDatabase(path, version: 1, onCreate: _createDb);

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE `document` (
  `id` int(11) NOT NULL,
  `title` varchar(255) NOT NULL,
  `time` varchar(255) NOT NULL,
  `uid` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE `document_detail` (
  `id_doc_det` int(11) NOT NULL,
  `id_doc` int(11) NOT NULL,
  `text` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

ALTER TABLE `document`
  ADD PRIMARY KEY (`id`);

  ALTER TABLE `document_detail`
  ADD PRIMARY KEY (`id_doc_det`);

  ALTER TABLE `document`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

  ALTER TABLE `document_detail`
  MODIFY `id_doc_det` int(11) NOT NULL AUTO_INCREMENT;

  ALTER TABLE `document_detail`
  ADD CONSTRAINT `document_detail_ibfk_1` FOREIGN KEY (`id_doc_det`) REFERENCES `document` (`id`);
COMMIT;
    ''');
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }

  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('document', orderBy: 'id');
    return mapList;
  }

//create databases
  Future<int> insert(DocumentModelDB object) async {
    Database db = await this.database;
    int count = await db.insert('document', object.toMap());
    return count;
  }

//update databases
  Future<int> update(DocumentModelDB object) async {
    Database db = await this.database;
    int count = await db.update('document', object.toMap(),
        where: 'id=?', whereArgs: [object.id]);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    Database db = await this.database;
    int count = await db.delete('document', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<DocumentModelDB>> getContactList() async {
    var contactMapList = await select();
    int count = contactMapList.length;
    List<DocumentModelDB> contactList = List<DocumentModelDB>();
    for (int i = 0; i < count; i++) {
      contactList.add(DocumentModelDB.fromMap(contactMapList[i]));
    }
    return contactList;
  }
}
