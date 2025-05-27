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
- To create a new document, can do something like this
    ```js
    db.authors.insertOne({name: 'Tikki Cui'})
    ```
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

## CRUD Operations
### `insertOne` and `insertMany`
- <u>Durability</u> is a property that guarantees acknowledged writes are permanently stored in DB
    - Even if DB is unavailable after
    - Can be configured to be high (slower writes) or low (faster writes)
- We use a `writeConcern` to config the durability, which is passed as a 2nd param
    ```js
    db.authors.insertOne(
        {name: 'Tikki'},
        {
            w: 'majority',
            j: 'true',
            wtimeout: 100
        }
    )
    ```
    - `w` number of mongod instances to acknowledge a write before it's marked as success
    - `j` if true, doc must be fully written to disk before success (if false, it'll be success once it reaches the journal memory)
    - `wtimeout` how long (ms) write can block
- `writeConcern` options
    - If loss of data cannot happen, use `w: 'majority'`
    - If loss of data is inconvenient but OK, use `w: 1` (success once primary finishes)

### `findOne` and `find`
- We can access nested sub-properties like this:
    ```js
    db.movies.findOne({'ratings.imdb': 10})
    ```
- We can access array elements like this:
    ```js
    db.movies.findOne({'genres.0': 'Musical'})
    ```
- For finds, we can specify a `readConcern`
    ```js
    db.authors.find({}).readConcern('majority')
    ```
    - Only see data that is majority committed
    - Can be `local`, `available`, `majority`, `linerizable`
- We can also speed up reads with `readPreference`
    - `primary`, `primaryPreferred`, `secondary`, `secondaryPreferred`, and `nearest`
    - Risks reading stale data from secondaries
    - Fine for analytics
    - Don't use for increasing capacity for general traffic

### Comparison Operators
- There are 8 comparison operators
- The first 6 are pretty straightforward
    - `$eq` ($=$)
    - `$gt` ($$)
    - `$gte` ($\ge$)
    - `$lt` ($\lt$)
    - `$lte` ($\le$)
    - `$ne` ($\ne$)
    - `$in` ($\in$) - field can match 1 of the provided values
    - `$nin` ($\notin$) - field can't be any of the provided values
- Example with `$gte`:
    ```js
    db.inventory.findOne({'variations.quantity': {$gt: 8}})
    ```
    - Finds first document where `variations.quantity` is >8
- Example with `$in`:
    ```js
    db.inventory.findOne({'variations.variation': {$in: ['Blue', 'Red']}})
    ```
    - Finds the first doc where all the variations are either blue or red
    - If we used `$nin`, then it finds first doc where none of the variations are blue nor red
- Note that `$nin` and `$ne` will match properties that don't exist
- We can use `$exists: true` to ensure property is present

### Logic Operators
- There are 4 logic operators
    - `$and` matches all conditions
    - `$or` matches at least 1 condition
    - `$nor` not or
    - `$not` negates
- These operators take in an array of conditions except for `$not`
- Example with `$and`:
    ```js
    db.inventory.findOne({$and: [{'variations.quantity': {'$ne': 0}}, {'variations.quantity': {$exists: true}}]})
    ```
- Example with `$not`
    ```js
    db.inventory.findOne({'variations.price': {$not: {$gt: 2000}}})
    ```

### Sort, Skip, Limit
- The `.sort()` method can be chained to a `.find()` to sort the results
    - Pass in the field
    - Use `1` or `-1` for ascending/descending
- Example
    ```js
    db.movies.find({}).sort({title: 1})
    ```
- The `.skip(n)` method will skip the first `n` documents from the results
- The `.limit(n)` method will limit results to the first `n` results
- If sorting data is a common query, then an index is a lot more efficient
    - Otherwise, sort and limit is good
- Note that MongoDB will always perform sort, skip, limit in that order
    - Regardless of how the query was initially written

### `updateOne` and `updateMany`
- Update methods take 2 parameters
    - A filter for the documents to update
    - What to change
- Some useful operators
    - `$set` to create a new field
    - `$unset` to delete a field
    - `$inc` increase/decrease fields
    - `$mul` multiply field 
    - `$max` caps values at max
    - `$min` caps values at min
- Example with `$set` that creates a new field `message`:
    ```js
    db.authors.updateMany({}, {$set: {message: 'Hello'}})
    ```

### Arrays
- We can make a normal query with array fields
    ```js
    db.movies.find({actors: 'Tom Holland'})
    ```
    - MongoDB will find all documents where `'Tom Holland'` is an element in the array `actors`
- There are some special operators we can use as well
    - `$all` all specified entries have to be present
    - `$elemMatch` checks different properties for a single array element
- Example with `$all`
    ```js
    db.movies.find({genres: {$all: ['Comedy', 'Drama']}})
    ```
- Example with `$elemMatch`
    ```js
    db.inventory.find({variations: {$elemMatch: {variation: 'Blue', quantity: {$gte: 8}}}})
    ```
- We can update arrays with
    - `$push` add element to array
    - `$pop` remove element from array
    - `$addToSet` adds only if element doesn't exist
- Example with `$push`
    ```js
    db.movies.updateOne({_id: ObjectId('123')}), {$push: {genres: 'Action'}}
    ```
- Example with `$pop`
    ```js
    db.movies.updateOne({_id: ObjectId('123')}), {$push: {genres: 1}}
    ```
    - We specify `-1` or `1` for first/last element in array

### Transactions
- Reads and writes are both atomic operations for a single document
- However, it doesn't work for multiple documents
    - Person A writes changes to a bunch of documents
    - Person B reads the documents and sees some that are changed and some that aren't
- In order to guarantee atomicity across multiple docs, use <u>multi-doc transactions</u>
    - Returns all docs as they were when read begins
    - Either all writes happened or they didn't
- Sample transaction process
    ```shell
    > session = db.getMongo().startSession({readPreference: {mode: 'primary'}})
    > session.startTransaction()
    > session.getDatabase('blog').authors.updateMany({}, {$set: {message: 'Transaction'}})
    > session.commitTransaction()
    > session.endSession()
    ```
- Warnings with transactions
    - Only use when absolutely necessary
    - Overuse can lead to performance degradation
    - Check data model if lots of transactions are needed

### `$expr`
- Basic queries can only compare a field value with a constant
- `$expr` lets us compare multiple fields
- Example
    ```js
    db.sales.find({$expr: {$gt: ['$price', '$cost']}})
    ```
    - Compares the `price` and `cost` fields
    - Note that we have to prefix with `$` to indicate it's a field name and not a string literal
    - Returns all documents where `price` is greater than `cost`
