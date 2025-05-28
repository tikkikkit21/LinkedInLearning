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
- To create a new document, can do something like this:
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
- We use a `writeConcern` to config the durability, which is passed as a 2nd param:
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
- For finds, we can specify a `readConcern`:
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
- Example with `$not`:
    ```js
    db.inventory.findOne({'variations.price': {$not: {$gt: 2000}}})
    ```

### Sort, Skip, Limit
- The `.sort()` method can be chained to a `.find()` to sort the results
    - Pass in the field
    - Use `1` or `-1` for ascending/descending
- Example:
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
- We can make a normal query with array fields like so:
    ```js
    db.movies.find({actors: 'Tom Holland'})
    ```
    - MongoDB will find all documents where `'Tom Holland'` is an element in the array `actors`
- There are some special operators we can use as well
    - `$all` all specified entries have to be present
    - `$elemMatch` checks different properties for a single array element
- Example with `$all`:
    ```js
    db.movies.find({genres: {$all: ['Comedy', 'Drama']}})
    ```
- Example with `$elemMatch`:
    ```js
    db.inventory.find({variations: {$elemMatch: {variation: 'Blue', quantity: {$gte: 8}}}})
    ```
- We can update arrays with
    - `$push` add element to array
    - `$pop` remove element from array
    - `$addToSet` adds only if element doesn't exist
- Example with `$push`:
    ```js
    db.movies.updateOne(
        {_id: ObjectId('123')},
        {$push: {genres: 'Action'}}
    )
    ```
- Example with `$pop`:
    ```js
    db.movies.updateOne(
        {_id: ObjectId('123')},
        {$pop: {genres: 1}}
    )
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
- Example:
    ```js
    db.sales.find({$expr: {$gt: ['$price', '$cost']}})
    ```
    - Compares the `price` and `cost` fields
    - Note that we have to prefix with `$` to indicate it's a field name and not a string literal
    - Returns all documents where `price` is greater than `cost`

## Aggregation Pipelines
### Overview of Stages
- <u>Aggregations</u> lets us create pipelines for multiple queries
- Provides advanced data manipulation and search
- Each pipeline consists of 1+ stages
    - Some stages may need to wait for process to complete before passing results
    - Others can pass results as they finish
- We use the `db.<collection>.aggregate([stage1, stage2])` command

### `$group`
- `$group` lets us group data according to certain criteria
- Requires specifying a field to use as the unique `_id`
- Example:
    ```js
    db.inventory.aggregate([{$group: {_id: '$source'}}])
    ```
    - Finds each unique `source` value
    - Creates corresponding groups with the source as the ID
- A more complex example
    ```js
    db.inventory.aggregate([{$group: {
        _id: '$source',
        count: {$sum: 1},
        items: {$push: '$name'},
        avg_price: {$avg: '$price'}
    }}])
    ```
    - Creates a group for each unique `source` value
    - Counts the number of docs with that value
    - Pushes each doc `name` into a list of `items`
    - Calculates the average price for the group

### `$bucket`
- `$bucket` is a more flexible version of `$group`
- Instead of matching an exact value, you can specify a range of values or criteria
- Example:
    ```js
    db.inventory.aggregate([{$bucket: {
        groupBy: '$year',
        boundaries: [1980, 1990, 2000, 2010, 2020],
        default: 'Other',
        output: {
            count: {$sum: 1},
            cars: {$push: {name: '$name', model: '$model'}}
        }
    }}])
    ```
    - This creates 4 buckets of 10-year intervals
    - The default group of `Other` is for any doc that doesn't fall into a bucket
    - We use `output` to customize what is placed into the buckets
- A variation is `$bucketAuto`
    - Automatically defines boundaries
    - We specify the number of buckets and it'll try to make them as evenly distributed as possible
- Example:
    ```js
    db.inventory.aggregate([{$bucketAuto: {
        groupBy: '$year',
        buckets: 5
    }}])
    ```
### `$unwind`
- If we have an array of documents, we can use `$unwind` to create a new document for each array element
- Let's say we have a sample document that looks like this:
    ```js
    {
        _id: '320939006-1',
        name: 'Scion',
        model: 'xB',
        year: 2008,
        price: 2828.45,
        source: 'Meemm',
        sale_frequency: 'Yearly',
        variations: [
            { variation: 'Purple', quantity: 28 },
            { variation: 'Violet', quantity: 8 }
        ]
    }
    ```
- We can create a new document for each variation like this:
    ```js
    db.inventory.aggregate([{$unwind: '$variations'}])
    ```
- This will result in 2 new documents like this:
    ```js
    [
        {
            _id: '320939006-1',
            name: 'Scion',
            model: 'xB',
            year: 2008,
            price: 2828.45,
            source: 'Meemm',
            sale_frequency: 'Yearly',
            variations: { variation: 'Purple', quantity: 28 }
        },
        {
            _id: '320939006-1',
            name: 'Scion',
            model: 'xB',
            year: 2008,
            price: 2828.45,
            source: 'Meemm',
            sale_frequency: 'Yearly',
            variations: { variation: 'Violet', quantity: 8 }
        }
    ]
    ```
- We can add a `$match` operator to specify which documents to aggregate:
    ```js
    db.inventory.aggregate([
        {$match: 'variations.variation': 'Purple'},
        {$unwind: '$variations'},
        {$match: 'variations.variation': 'Purple'}
    ])
    ```
    - This creates a new doc for each purple order
    - The first match filters out documents that don't have a purple variation
    - Then we can unwind each doc
    - Finally, we do another match to only select the purple unwound docs

### `$merge` and `$out`
- `$out` lets us store the results of a pipeline in a new collection
- We just need to add it to our existing pipeline:
    ```js
    db.inventory.aggregate([
        {$match: 'variations.variation': 'Purple'},
        {$unwind: '$variations'},
        {$match: 'variations.variation': 'Purple'},
        {$out: {db: 'sample_data', coll: 'new_collection'}}
    ])
    ```
- Very useful feature
    - Can store results of aggregation instead of calling it over and over again
    - Creates new set of data without modifying original collection
- `$merge` is similar to `$out` but it lets you merge into existing collection
    ```js
    db.inventory.aggregate([
        {$match: 'variations.variation': 'Purple'},
        {$unwind: '$variations'},
        {$match: 'variations.variation': 'Purple'},
        {$merge: {
            into: 'new_collection',
            on: '_id',
            whenMatched: 'keepExisting',
            whenNotMatched: 'insert'
        }}
    ])
    ```
    - `into` name of collection to merge into
    - `on` the property to check for duplicates
    - `whenMatched` what to do if duplicate found (we keep existing)
    - `whenNotMatched` what to do if no duplicate found (we insert the doc)

### `$function`
- The `$function` operator lets us code custom JS functions to operate on document fields
    ```js
    db.movies.aggregate([
        {
            $project: {
                title: 1,
                actors: {
                    $function: {
                        body: 'function(actors) { return actors.sort(); }',
                        args: [ '$actors' ],
                        lang: 'js'
                    }
                }
            }
        }
    ])
    ```
- We use the `$project` stage to keep only the `title` and `actors` field
- The `$function` operator takes in 3 arguments
    - `body` the JS function itself
    - `args` any arguments to pass into the function
    - `lang` what language 

### `$lookup`
- `$lookup` lets us perform joins by pulling in data from another collection with matching field values
    ```js
    db.orders.aggregate([
        {$lookup: {
                from: 'inventory',
                localField: 'car_id',
                foreignField: '_id',
                as: 'car_id'
        } }
    ])
    ```
    - `from` collection we're pulling data from
    - `localField` the field in `orders`
    - `foreignField` the field in `inventory`
    - `as` what to name the resulting field 
- Important notes
    - `foreignField` should have an index if this join happens often
    - Common query patterns should rarely require joins
    - MongoDB's model is that all relevant data should be in the same document

### Performance
- Aggregation pipelines are useful but also more computationally expensive
- Keep an eye on performance issues especially if:
    - Amount of data is large
    - Operation runs frequently
    - Operation needs to be fast
    - We can use `.explain('executionStats')` to view performance metrics
    ```js
    db.movies.explain('executionStats').aggregate( [
        { $project: {
            release_year: {$year: '$release_year'},
            title: 1
        } },
        { $lookup: {
            from: 'inventory',
            localField: 'release_year',
            foreignField: 'year',
            as: 'year'
        } }
    ] )
    ```
- MongoDB comes up with several <u>query plans</u> on how to fetch the data
    - It'll run each one and find the fastest one
    - Then it uses the winner on the rest of the data
- You can check for slow queries with this command:
    ```js
    db.setProfilingLevel(1, {slowms: 20})
    ```
    - Finds queries that execute slower than the specified `slowms` threshold
    - Stores its findings in `system.profile` database
    - Access these logs with `db['system.profile'].find()`
- Common aggregation optimizations
    - Use `$sort` and `$limit`
    - `$project` should be the final stage
    - Use hinting (ex: `db.collection.aggregate(pipeline, {hint: 'index_name'})` to manually specify the index to use)
    - Analytic nodes
    - Kill slow/blocking operations with
        ```js
        > db.currentOp(true)
        > db.adminCommand({'killOp': 1, 'op': <OP_NUMBER>})
        ```
