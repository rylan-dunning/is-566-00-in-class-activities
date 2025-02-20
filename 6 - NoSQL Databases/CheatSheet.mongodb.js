// MongoDB Cheat Sheet (Sample commands)
// Connect to your MongoDB in docker using: mongodb://root:password@localhost:27017/

// In the following queries, assume a MongoDB collection named `books` containing documents with the following structure:
const sampleBook = {
    _id: new ObjectId("609d1b2f8a5b8b001b8b4567"),
    title: "The Art of Programming",
    author: "John Doe",
    published_year: 1995,
    genres: ["Technology", "Programming"],
    price: 39.99,
    stock: 12,
    is_available: true,
    rating: 4.7,
    published_date: new ISODate("1995-05-15T00:00:00Z")
};


// ## 1. Basic Queries
// Retrieve documents using basic queries.

db.books.findOne(); // Returns a single document
db.books.find() // Returns a cursor - shows 20 results by default
db.books.find().pretty() // Formats the output nicely

db.books.find({title: "The Art of Programming", author: "John Doe"}) // Implicit logical "AND"
db.books.find({published_date: ISODate("1995-05-15T00:00:00Z")}) // Find by exact date

// Analyze query performance
db.books.find({title: "The Art of Programming"}).explain("executionStats")

// Retrieve distinct author names
db.books.distinct("author")

// ## 2. Comparison Operators
// Retrieve books based on numerical comparisons.

db.books.find({published_year: {$gt: 2000}}) // Books published after 2000
db.books.find({published_year: {$gte: 1990}}) // Books published in or after 1990
db.books.find({published_year: {$lt: 1980}}) // Books published before 1980
db.books.find({published_year: {$lte: 1970}}) // Books published in or before 1970
db.books.find({published_year: {$ne: 2000}}) // Books NOT published in 2000
db.books.find({published_year: {$in: [1985, 1995, 2005]}}) // Books published in 1985, 1995, or 2005
db.books.find({published_year: {$nin: [1985, 1995, 2005]}}) // Books NOT published in these years



// ## 3. Logical Operators
// Combine multiple conditions using logical operators.


db.books.find({author: {$not: {$eq: "John Doe"}}}) // Books NOT authored by John Doe
db.books.find({$or: [{published_year: 1985}, {published_year: 1995}]}) // Books from 1985 OR 1995
db.books.find({$nor: [{price: 9.99}, {is_available: false}]}) // Books that are neither $9.99 nor unavailable

db.books.find({
    $and: [
        {$or: [{stock: {$lt: 5}}, {stock: {$gt: 50}}]}, // Low or very high stock
        {$or: [{is_available: true}, {price: {$lt: 10}}]} // Available or under $10
    ]
})



// ## 4. Text Search
// Search for keywords in indexed text fields.

db.books.createIndex({title: "text", genres: "text"}) // First, create a text index

db.books.find(
    {$text: {$search: "programming"}}, // Search for books with "programming"
    {score: {$meta: "textScore"}} // Return relevance score
).sort({score: {$meta: "textScore"}}) // Sort by relevance



// ## 5. Counting Documents
// Find out how many documents match a query.


db.books.countDocuments({published_year: 2000}) // Count books published in 2000
db.books.countDocuments({is_available: true}) // Count available books



// ## 6. Sorting, Skipping, and Limiting
// Control query results with sorting, skipping, and limiting.


db.books.find().sort({published_year: 1, rating: -1}) // Sort by year ascending, rating descending
db.books.find().skip(10).limit(5) // Skip the first 10 results and return the next 5
db.books.find().sort({price: -1}).limit(3) // Get the 3 most expensive books


