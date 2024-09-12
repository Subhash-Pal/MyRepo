#include <QCoreApplication>
#include <QSqlDatabase>
#include <QSqlError>
#include <QSqlQuery>
#include <QDebug>
int main(int argc, char *argv[])
{
    QCoreApplication a(argc, argv);

    // Initialize the database connection
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");  // QPSQL is the driver for PostgreSQL
    db.setHostName("localhost");
    db.setDatabaseName("postgres");  // Replace with your database name
    db.setPort(5432);                 // Default PostgreSQL port
    db.setUserName("postgres");       // Username
    db.setPassword("root");           // Password

    // Open the connection
    if (!db.open()) {
        qDebug() << "Error: Unable to connect to the database!" << db.lastError();
        return -1;
    }

    qDebug() << "Connected to the database successfully!";

    // Step 1: Create a table
    QSqlQuery createTableQuery;
    QString createTableSQL = R"(
        CREATE TABLE IF NOT EXISTS users (
            id SERIAL PRIMARY KEY,
            name VARCHAR(50),
            age INT
        )
    )";

    if (!createTableQuery.exec(createTableSQL)) {
        qDebug() << "Table creation error:" << createTableQuery.lastError();
        return -1;
    } else {
        qDebug() << "Table 'users' created successfully!";
    }

    // Step 2: Insert data into the table
    QSqlQuery insertDataQuery;
    QString insertDataSQL = R"(
        INSERT INTO users (name, age)
        VALUES ('Alice', 30), ('Bob', 25), ('Charlie', 28)
    )";

    if (!insertDataQuery.exec(insertDataSQL)) {
        qDebug() << "Data insertion error:" << insertDataQuery.lastError();
        return -1;
    } else {
        qDebug() << "Data inserted successfully!";
    }

    // Step 3: Display the data
    QSqlQuery selectQuery;
    if (selectQuery.exec("SELECT * FROM users")) {
        qDebug() << "ID | Name    | Age";
        while (selectQuery.next()) {
            int id = selectQuery.value("id").toInt();
            QString name = selectQuery.value("name").toString();
            int age = selectQuery.value("age").toInt();
            qDebug() << id << "| " << name << "| " << age;
        }
    } else {
        qDebug() << "Query error:" << selectQuery.lastError();
    }

    // Close the connection
    db.close();

    return a.exec();
}
