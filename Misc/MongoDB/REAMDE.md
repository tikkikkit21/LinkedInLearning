# MongoDB Essential Training
https://www.linkedin.com/learning/mongodb-essential-training/features-of-mongodb

## Install MongoDB (Windows)
1. Install *MongoDB* from https://www.mongodb.com/try/download/community
    - Don't install as service
    - Add binary to the system PATH (ex: `C:\Program Files\MongoDB\Server\8.0\bin`)
    - To test if installed, run `mongod --version`
2. Install *MongoDB Shell* from https://www.mongodb.com/try/download/shell
    - Stick with default settings
    - Can run `mongosh --version` to check if installed
3. Install *MongoDB CL Database Tools* tools from https://www.mongodb.com/try/download/database-tools
    - Use default settings
    - Add binary path to the system PATH as well
    - Test with a tool like `mongoimport`

## Set Up Database
### `mongod`
- `mongod` is a daemon process for MongoDB
    - Handles data requests from shell or drivers
    - Performs background management operations
- You can launch the process with `mongod --dbpath [directory]`
    - Listens to port 27017 by default
    - Default `dbpath` is `/data/db`
- To launch the shell, run `mongosh` in a different terminal
    - Can also use Compass to explore database with a GUI

### Replica Set
- Typically we never run `mongod` as our production database
    - Single process is unreliable
    - If something goes wrong the entire DB is down
- MongoDB uses <u>replica sets</u> to improve robustness
- A replica set consists of several nodes
    - Each node maintains it's own copy of the the database
- One node is the "primary" node that handles all write operations
    - The rest are called "secondary" nodes
- When the primary node is down, then an election is held to vote for a new primary
- Best practices
    - At least 3 replica set members
    - Use uneven number of voting replica set members

### Replica Set w/ CLI
- First create a folder for our replica set (ex: `replica_set_cli`)
- Then create a key file with `openssl rand -base64 755 > keyfile`
    - Basic authentication
    - Production should use something more secure
- Next we create 3 folders with `mkdir -p m{1,2,3}/db`
    - This creates `m1`, `m2`, `m3`
- To create each replica set, we run `mongod --replSet myReplSet --dbpath ./m1/db --logpath ./m1/mongodb.log --port 27017 --keyFile ./keyfile`
    - `--replSet` name of replica set
    - `--dbpath` path to data dir
    - `--logpath` log file
    - `--port` port to listen to
    - `--keyFile` path to the key file we created
- We can use the shell to start up the replica sets
    - `rs.initiate()` launch the replica sets
    - `use admin` switch to `admin` database
- Nex we create our first user
    - This is the only time we can create a user without authentication
    - In order to create future users, we need to authenticate with the user we created
    - Therefore it's important to ensure the first user has proper permissions to create future users
- We can use the command `db.createUser({user: 'tikki', pwd: passwordPrompt(), roles: ['root']})`
    - `passwordPrompt()` hides the password we type
- To authenticate as this user, we run `db.getSiblingDB('admin').auth('tikki', passwordPrompt())`
- Next, we add the other 2 replica set members with `rs.add('localhost:PORT')`
    - Use the port specified with the `--port` option
- We can check the replica set status with `rs.status()`

### Replica Set w/ Config Files
- Config files are the recommended way for setting up replica sets in production
    - Easier to manage
    - Can be used in version control
- Follow the same CLI steps for creating folders and a key file
- Then we create our first config file as `m1.conf`
    ```yaml
    storage:
        dbPath: m1/db
    net:
        bindIp: localhost
        port: 27017
    security:
        authorization: enabled
        keyFile: keyfile
    systemLog:
        destination: file
        path: m1/mongod.log
    replication:
        replSetName: mongodb-rs
    ```
- To use the config file, we just have to run `mongod -f m1.conf`
- In the shell, we can launch the replica sets with:
    1. `config = {_id: 'mongodb-rs', members: [{_id: 0, host: 'localhost:27017'}, {_id: 1, host: 'localhost:27018'}, {_id: 2, host: 'localhost:27019'}]}`
    2. `rs.initiate(config)`

### Import Sample Data
- The *MongodB Database Tools* that we installed contains several useful commands
    - `mongostat` stats on a running `mongod` instance
    - `mongodump` exports dump files to BSON
    - `mongorestore` import dump files from BSON
    - `mongoexport` exports data to JSON/CSV
    - `mongoimport` imports data from JSON/CSV
- To import sample data from a file, we can run `mongoimport --username='tikki' --authenticationDatabase='admin' --db=sample_data inventory.json`

### Debugging
- Check log files for error messages
- Disable fork option
    - Brings the error message straight to terminal
- Check oplog
    - `use local`
    - `db.oplog.rs.find({'o.msg': {$ne:'periodic noop'}}).sort({$natural:-1}).limit(1).pretty()`
- Increase log level
    - `db.getLogComponents()`
    - `db.adminCommand({setParameter: 1, LogLevel: 2})`
- Stack Overflow or ChatGPT

## Working With MongoDB
### The Document Model
- MongoDB works very well with JSON documents
- Technically uses BSON under the hood
    - Can store things like timestamps, longs, and images
    - More efficient
- General structure of a MongoDB database deployment
    - Deployment has 1+ databases
    - Each database has 1+ collections
    - Each collection has 1+ documents
- We use the `use` command to switch between databases (ex: `use users`)
- To create a new document, can do something like this `db.authors.insertOne({name: 'Tikki Cui'})`
    - If successful, will return new doc with a unique object ID

### MongoDB Query Language (MQL)
- MQL is a tool to access data in MongoDB
- Also called MongoDB Query API
- Performs CRUD (create, read, update, delete) operations
- JavaScript-based

### Indexes
- Each query needs to scan the database and check every document
    - Very inefficient
    - Each separate query requires a complete sweep of the collection
- MongoDB uses <u>indexes</u> to help organize data
    - Indexex stores a subset of the data
    - Contains pointers back to the full record
    - Much more efficient
- Drawbacks of indexes
    - Need to be regularly maintained
    - Trades off faster read for slower write
- Indexes are a good idea when:
    - You frequently query the same fields
    - You frequently perform range-based queries
    - Queries are the most common query patterns
    - You have have enough RAM to store the index
- Types of indexes
    - Single field
    - Partial
    - Compound (multiple fields)
    - Multikey
    - Text
    - Wildcard
    - Geospatial
    - Hashed
- 
