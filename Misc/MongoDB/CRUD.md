## Create
`db.<collection>.insertOne(values)` create a doc where `values` is JS object with property names and values

`db.<collection>.insertMany([values1, values2, ...])` is the same but with an array of JS objects

## Read
`db.<collection>.findOne()` returns the first doc in the collection

`db.<collection>.find()` returns all docs in collection

`db.<collection>.find({name: 'My Name'})` returns all docs that match the filter


## Update
`db.<collection>.updateOne({name: 'My Name'}, {$set: {newField: 'new value'}})` finds first matching doc with the filter and then calls `$set` to create new field

`db.<collection>.updateMany({name: 'My Name'}, {$set: {newField: 'new value'}})` finds all matching docs with the filter and then calls `$set` to create new field

`db.<collection>.updateMany({}, {$set: {newField: 'new value'}})` empty filter applies to all docs

## Delete
`db.authors.deleteOne({name: 'My Name'})` deletes first doc that matches filter

`db.authors.deleteMany({})` deletes all docs

## Navigation
`use <database>` switches to database

`show collections` lists out the collections in database

## Others
`db.authors.createIndex({name:1})` creates an index on the `name` field
