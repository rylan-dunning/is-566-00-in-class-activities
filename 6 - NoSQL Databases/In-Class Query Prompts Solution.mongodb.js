// # Query Prompts for Students

// Find a single document for a user named "Emma."
// Hint: Use findOne() to retrieve only one document.

db.users.findOne({ name: "Emma" })

// Retrieve all users who are 30 years old or older.
// Hint: Use $gte to filter users based on the age field.

db.users.find({ age: { $gte: 30 } })

// Find users who live in either "Chicago" or "Los Angeles."
// Hint: Use $or to filter for multiple city values.

db.users.find({ $or: [{ city: "Chicago" }, { city: "Los Angeles" }] })

// Find users who are not from "New York."
// Hint: Use $not or $ne to exclude a specific city.

db.users.find({ city: { $ne: "New York" } })
db.users.find({ city: { $not: { $eq: "New York" } } })


// Find users who have an account balance greater than $5,000 but less than $9,000.
// Hint: Use $gt and $lt together in a query.

db.users.find({ account_balance: { $gt: 5000, $lt: 9000 } })

// Find users who like both "hiking" and "reading."
// Hint: Since hobbies are stored as an array, you need to check for both values inside it.

db.users.find({ hobbies: { $all: ["hiking", "reading"] } })

// Count the number of users who are currently active (is_active: true).
// Hint: Use .countDocuments().

db.users.countDocuments({ is_active: true })

// Sort all users by their account balance in descending order and return the top five.
// Hint: Use .sort() with -1 and .limit().

db.users.find().sort({ account_balance: -1 }).limit(5)

// Find all users who have a hobby that contains the word "coding."
// Hint: Use $text search if indexing is enabled, or a regex pattern.

db.users.find({ $text: { $search: "coding" } })

// Retrieve the five oldest users, skipping the first three results.
// Hint: Use .sort() with -1 for age, .skip(), and .limit().

db.users.find().sort({ age: -1 }).skip(3).limit(5)
