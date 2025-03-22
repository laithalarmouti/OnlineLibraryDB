

use OnlineLibraryplayground;
db.createCollection("books");

db.books.insertMany([
    {
        "title": "The Da Vinci Code",
        "author": "Dan Brown",
        "category_id": 4,
        "available": false,
        "currentHolder": {"user_id": 4, "due_date": "2025-04-04T13:03:39.624015"},
        "requesters": [{'user_id': 4, 'requested_at': '2025-02-21T13:03:39.624053'}, {'user_id': 1, 'requested_at': '2025-03-15T13:03:39.624061'}]
    },
    {
        "title": "Clean Code",
        "author": "Robert C. Martin",
        "category_id": 5,
        "available": false,
        "currentHolder": {"user_id": 5, "due_date": "2025-04-18T13:03:39.624076"},
        "requesters": []
    },
    {
        "title": "Becoming",
        "author": "Michelle Obama",
        "category_id": 6,
        "available": false,
        "currentHolder": {"user_id": 5, "due_date": "2025-04-16T13:03:39.624087"},
        "requesters": [{'user_id': 1, 'requested_at': '2025-03-07T13:03:39.624094'}]
    },
    {
        "title": "The Hobbit",
        "author": "J.R.R. Tolkien",
        "category_id": 7,
        "available": true,
        "currentHolder": null,
        "requesters": [{'user_id': 4, 'requested_at': '2025-03-17T13:03:39.624105'}, {'user_id': 1, 'requested_at': '2025-03-12T13:03:39.624109'}]
    },
    {
        "title": "Atomic Habits",
        "author": "James Clear",
        "category_id": 8,
        "available": false,
        "currentHolder": {"user_id": 2, "due_date": "2025-03-28T13:03:39.624117"},
        "requesters": [{'user_id': 2, 'requested_at': '2025-02-21T13:03:39.624124'}, {'user_id': 3, 'requested_at': '2025-03-14T13:03:39.624131'}]
    },
    {
        "title": "Pride and Prejudice",
        "author": "Jane Austen",
        "category_id": 9,
        "available": false,
        "currentHolder": {"user_id": 2, "due_date": "2025-04-12T13:03:39.624140"},
        "requesters": [{'user_id': 4, 'requested_at': '2025-03-10T13:03:39.624147'}, {'user_id': 4, 'requested_at': '2025-03-05T13:03:39.624151'}]
    },
    {
        "title": "Dune",
        "author": "Frank Herbert",
        "category_id": 10,
        "available": false,
        "currentHolder": {"user_id": 5, "due_date": "2025-04-14T13:03:39.624160"},
        "requesters": [{'user_id': 1, 'requested_at': '2025-03-02T13:03:39.624166'}, {'user_id': 3, 'requested_at': '2025-03-10T13:03:39.624170'}, {'user_id': 1, 'requested_at': '2025-03-04T13:03:39.624174'}]
    },
    {
        "title": "Rich Dad Poor Dad",
        "author": "Robert Kiyosaki",
        "category_id": 11,
        "available": false,
        "currentHolder": {"user_id": 3, "due_date": "2025-04-15T13:03:39.624186"},
        "requesters": [{'user_id': 2, 'requested_at': '2025-03-10T13:03:39.624193'}, {'user_id': 4, 'requested_at': '2025-03-02T13:03:39.624197'}]
    },
    {
        "title": "Lonely Planet Japan",
        "author": "Lonely Planet",
        "category_id": 12,
        "available": false,
        "currentHolder": {"user_id": 6, "due_date": "2025-04-08T13:03:39.624206"},
        "requesters": [{'user_id': 4, 'requested_at': '2025-03-18T13:03:39.624216'}, {'user_id': 6, 'requested_at': '2025-02-24T13:03:39.624223'}]
    },
    {
        "title": "The Odyssey",
        "author": "Homer",
        "category_id": 1,
        "available": true,
        "currentHolder": null,
        "requesters": [{'user_id': 4, 'requested_at': '2025-03-05T13:03:39.624238'}, {'user_id': 6, 'requested_at': '2025-02-25T13:03:39.624242'}]
    }
]);


//                          AGGREGATION     

    //Most requested book
db.books.aggregate([
    { $project: { title: 1, requestCount: { $size: "$requesters" } } },
    { $sort: { requestCount: -1 } },
    { $limit: 5 }
  ]);

    //taken books
db.books.aggregate([
    { $match: { currentHolder: { $ne: null } } },
    { $project: { title: 1, "currentHolder.user_id": 1, "currentHolder.due_date": 1 } }
    ]);

    //available books
    db.books.aggregate([
        { $match: { available: true } },
        { $project: { title: 1, available: 1 } }
    ]);
    

    //books in each category -> refer to SQL to check which category is which ID
db.books.aggregate([
    { $group: { _id: "$category_id", totalBooks: { $sum: 1 } } },
    { $sort: { totalBooks: -1 } }
    ]);
      
    //users that requests the most
    db.books.aggregate([
        { $unwind: "$requesters" },     //learned it in class, breaks array into documents    
        { $group: { _id: "$requesters.user_id", totalRequests: { $sum: 1 } } },  //grp by user id,
        { $sort: { totalRequests: -1 } },
        { $limit: 5 }
      ]);

    //total number of requests
    db.books.aggregate([
        { $unwind: "$requesters" },
        { $group: { _id: null, totalRequests: { $sum: 1 } } }
    ]);
    
    //books with no requesters
    db.books.aggregate([
        { $match: { requesters: { $size: 0 } } },
        { $project: { title: 1} }
    ]);
    
    //category with most requests
    db.books.aggregate([
        { $unwind: "$requesters" },
        { $group: { _id: "$category_id", totalRequests: { $sum: 1 } } },
        { $sort: { totalRequests: -1 } }
    ]);
    
    //most recent request descending for each book
    db.books.aggregate([
        { $unwind: "$requesters" },
        { $sort: { "requesters.requested_at": -1 } },
        { $limit: 5 }
    ]);
      
      

