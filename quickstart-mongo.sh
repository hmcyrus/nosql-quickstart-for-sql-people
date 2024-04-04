# connect to a mongo database (todo)

show databases

use databaseX

# equivalent of count(*)
db.collectionX.countDocuments() 

# equivalent of select * from dbX 
db.goals.find().limit(10)

# equivalent of 
# `select owner, previous 
#       from goal 
#       where name = 'goal-5' and owner = 'user1'
#       offset 100
#       limit next 10 rows only`

db.goals.find({name : 'goal-5',owner : 'user1'}, {owner: 1, previous : 1}).skip(100).limit(10)

# example of join
# equivalent of `SELECT
#   c1.col1,
#   c1.col2,
#   c2.*
# FROM
#   collection1 c1
#   LEFT JOIN collection2 c2 ON c1.field_in_collection1 = c2.field_in_collection2
# WHERE
#   c1.propertyName >= 45;`

db.collection1.aggregate([
  {
    $lookup: {
      from: "collection2",
      localField: "field_in_collection1",
      foreignField: "field_in_collection2",
      as: "joined_data"
    }
  },
  {
    $match: {
      "propertyName": { $gte: 45 }
    }
  },
  {
    $project: {
      col1: 1,
      col2: 1,
      joined_data: 1
    }
  }
])