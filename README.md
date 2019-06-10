# IsepXchange Web App

Web Platform providing information to ISEP students on university exchange possibilities to achieve an international experience.

_Built for ISEP during a Software Engineering & Web Technologies project._

## Development

### Prerequisites

#### Java

You must have Java 8 (or higher) installed on your machine to use this project.

You can check your java version with `java --version`.

If you don't have it already, you can get it by following those steps:

- Download a Java JDK binary [here](https://jdk.java.net/8/)
- Extract it and add jdk-8.x.x/bin to your PATH
- Create a JAVA_HOME variable set to the jdk directory path

#### Apache Maven

You must have Maven 3 (or higher) installed on your machine to use this project.

You can check your maven version with `mvn -v`.

If you don't have it already, you can get it by following those steps:

- Download a Maven binary [here](https://maven.apache.org/download.cgi)
- Extract it and add apache-maven-x.x.x/bin to your PATH

#### MySQL

You must also have a MySQL Server 8 installed on your machine to use this project.

You can check your mysql service version with `mysqld --version`.

If you don't have it already, you can get it by following those steps:

- Download the MySQL Community MSI Installer [here](https://dev.mysql.com/downloads/windows/installer/8.0.html)
- Run it and use default installation steps

Note: If you are on another platform than windows, you can get a binary from [here](https://dev.mysql.com/downloads/mysql/) and install it manually. Just make sure to place it somewhere easy to access or add it to your path so you can run mysqld to start it when necessary.

### Installation

#### `Step 1` - Clone the repository

```bash
git clone git@github.com:Plakak1/isepxchange.git
```

#### `Step 2` - Move inside the repository

```bash
cd isepxchange
```

#### `Step 3` - Install dependencies

```bash
mvn clean install
```

#### `Step 4` - Import the database

Import the isepxchange.sql file in mysql and make sure the database is created successfully.

### Usage

Make sure you have a MySQL service (mysqld) running on port 3306.
The user and password variables in src/main/java/gl/servlet/DbDao.java should correspond to a valid user on your MySQL config.

To run the server in a development environment with automatic updates when the code changes, use the following command:

```bash
mvn tomcat7:run
```

## License

MIT License - see the [LICENSE](LICENSE) file for details.
