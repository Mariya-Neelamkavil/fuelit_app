//how to fetch mysql data in flutter?

Future<List<Profiles>> getSQLData() async {
    final List<Profiles> profileList = [];
    final Mysql db = Mysql();
    await db.getConnection().then((conn) async {
      String sqlQuery = 'select email, password from users';
      await conn.query(sqlQuery).then((results) {
        for (var res in results) {
          final profileModel =
              Profiles(email: res["email"], password: res["password"]);

          profileList.add(profileModel);
        }
      }).onError((error, stackTrace) {
        print(error);
        return null;
      });
      conn.close();
    });

    return profileList;
  }


