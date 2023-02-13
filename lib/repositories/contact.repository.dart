import 'package:contacts/models/contact.model.dart';
import 'package:contacts/settings.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ContactRepository {
  Future<Database> _getDataBase() async {
    return openDatabase(
      join(
        await getDatabasesPath(),
        DATABASE_NAME,
      ),
      onCreate: (db, version) async {
        await db.execute(CREATE_CONTACTS_TABLE_SCRIPT);
      },
      version: DATABASE_VERSION,
    );
  }

  Future create(ContactModel contactModel) async {
    try {
      final Database db = await _getDataBase();

      await db.insert(
        TABLE_NAME,
        contactModel.toMap()..removeWhere((key, value) => key == 'id'),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  Future<List<ContactModel>> getContacts() async {
    try {
      final Database db = await _getDataBase();
      final List<Map<String, dynamic>> mapsContacts =
          await db.query(TABLE_NAME);

      return List.generate(
        mapsContacts.length,
        (index) => ContactModel.fromMap(
          mapsContacts[index],
        ),
      );
    } catch (e) {
      print(e);
      return <ContactModel>[];
    }
  }

  Future<List<ContactModel>> searchContacts(String param) async {
    try {
      final Database db = await _getDataBase();
      final List<Map<String, dynamic>> mapsContacts = await db.query(
        TABLE_NAME,
        where: 'name LIKE ?',
        whereArgs: [
          '%$param%',
        ],
      );

      return List.generate(
        mapsContacts.length,
        (index) => ContactModel.fromMap(
          mapsContacts[index],
        ),
      );
    } catch (e) {
      print(e);
      return <ContactModel>[];
    }
  }

  Future<ContactModel?> getContact(int id) async {
    try {
      final Database db = await _getDataBase();
      final List<Map<String, dynamic>> mapContact = await db.query(
        TABLE_NAME,
        where: 'id = ?',
        whereArgs: [
          id,
        ],
      );

      return ContactModel.fromMap(mapContact[0]);
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future update(ContactModel contactModel) async {
    try {
      final Database db = await _getDataBase();

      await db.update(
        TABLE_NAME,
        contactModel.toMap(),
        where: 'id = ?',
        whereArgs: [
          contactModel.id,
        ],
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  Future delete(ContactModel contactModel) async {
    try {
      final Database db = await _getDataBase();

      await db.delete(
        TABLE_NAME,
        where: 'id = ?',
        whereArgs: [
          contactModel.id,
        ],
      );
    } catch (e) {
      print(e);
      return;
    }
  }

  Future updateImage(int id, String imagePath) async {
    try {
      final Database db = await _getDataBase();

      final ContactModel? contactModel = await getContact(id);

      if (contactModel != null) {
        await db.update(
          TABLE_NAME,
          contactModel.toMap(),
          where: 'id = ?',
          whereArgs: [
            contactModel.id,
          ],
        );
      }
    } catch (e) {
      print(e);
      return;
    }
  }
}
