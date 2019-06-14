首次运行时，首先运行StartDB.bat运行数据库，然后运行MigrateUp.bat，初始化Nakama数据库的表结构，最后运行StartNakama.bat运行服务器。
再次运行时，只需先运行StartDB.bat，再运行StartNakama.bat，无需运行MigrateUp.bat。
ClearDatabase.bat将会清空数据库的所有数据，清空后运行服务器步骤同首次运行的步骤。