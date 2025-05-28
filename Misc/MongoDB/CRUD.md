## Create
`db.<collection>.insertOne({ <document> })` create a doc where `{ <document> }` is JS object with property names and values

`db.<collection>.insertMany([{ <document1> }, { <document2 }, ...])` creates multiple docs from array of JS objects

## Read
`db.<collection>.findOne()` returns the first doc in the collection

`db.<collection>.findOne({ <document> })` returns the first doc in the collection that matches the filter

`db.<collection>.find()` returns all docs in collection

`db.<collection>.find({ <document> })` returns all docs that match the filter

## Update
`db.<collection>.updateOne({ <document> }, {$set: {newField: 'new value'}})` finds first matching doc with the filter and then calls `$set` to create new field

`db.<collection>.updateMany({ <document> }, {$set: {newField: 'new value'}})` finds all matching docs with the filter and then calls `$set` to create new field

`db.<collection>.updateMany({}, {$set: {newField: 'new value'}})` empty filter applies to all docs

## Delete
`db.<collection>.deleteOne({ <document> })` deletes first doc that matches filter

`db.<collection>.deleteMany({})` deletes all docs

## Navigation
`show dbs` lists all databases

`use <database>` switches to database

`show collections` lists out the collections in database

## Others
`db.<collection>.createIndex({name:1})` creates an index on the `name` field
