// Practice Queries
// Connection string: mongodb://root:password@localhost:27017/

const sampleUser = {
    _id: ObjectId('67b775d867d4d09a405c4497'),
    name: 'Alice',
    age: 32,
    city: 'Dallas',
    hobbies: [
      'swimming',
      'coding',
      'traveling'
    ],
    occupation: 'Doctor',
    is_active: true,
    account_balance: 7628.49,
    created_at: '2020-04-06'
  };



// Find a single document for a user named "Emma."
// Hint: Use findOne() to retrieve only one document.



// Retrieve all users who are 30 years old or older.
// Hint: Use $gte to filter users based on the age field.



// Find users who live in either "Chicago" or "Los Angeles."
// Hint: Use $or to filter for multiple city values.



// Find users who are not from "New York."
// Hint: Use $not or $ne to exclude a specific city.



// Find users who have an account balance greater than $5,000 but less than $9,000.
// Hint: Use $gt and $lt together in a query.



// Find users who like both "hiking" and "reading."
// Hint: Since hobbies are stored as an array, you need to check for both values inside it.



// Count the number of users who are currently active (is_active: true).
// Hint: Use .countDocuments().



// Sort all users by their account balance in descending order and return the top five.
// Hint: Use .sort() with -1 and .limit().



// Find all users who have a hobby that contains the word "coding."
// Hint: Use $text search if indexing is enabled, or a regex pattern.



// Retrieve the five oldest users, skipping the first three results.
// Hint: Use .sort() with -1 for age, .skip(), and .limit().


