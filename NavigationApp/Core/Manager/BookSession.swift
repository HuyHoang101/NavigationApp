//
//  BookSession.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/5/26.
//

class BookStore {
    static let shared = BookStore()

    private init() {}

    // "Database" sách
    var allBooks: [Book] = [
        Book(
            name: "Clean Code",
            author: "Robert C. Martin",
            publishDate: "2008",
            imageName: "https://images-na.ssl-images-amazon.com/images/I/41xShlnTZTL._SX374_BO1,204,203,200_.jpg"
        ),
        Book(
            name: "The Pragmatic Programmer",
            author: "Andrew Hunt",
            publishDate: "1999",
            imageName: "https://images-na.ssl-images-amazon.com/images/I/51A8l+FxFNL._SX380_BO1,204,203,200_.jpg"
        ),
        Book(
            name: "Swift Programming",
            author: "Apple Inc.",
            publishDate: "2023",
            imageName: "https://developer.apple.com/assets/elements/icons/swift/swift-64x64_2x.png"
        ),
        Book(
            name: "Design Patterns",
            author: "Erich Gamma",
            publishDate: "1994",
            imageName: "https://images-na.ssl-images-amazon.com/images/I/51kuc0iWoRL._SX379_BO1,204,203,200_.jpg"
        ),
        Book(
            name: "Refactoring",
            author: "Martin Fowler",
            publishDate: "2018",
            imageName: "https://images-na.ssl-images-amazon.com/images/I/51k+e8v4xQL._SX397_BO1,204,203,200_.jpg"
        ),
        Book(
            name: "iOS Programming",
            author: "Big Nerd Ranch",
            publishDate: "2022",
            imageName: "https://images-na.ssl-images-amazon.com/images/I/41YyO6pQm6L._SX396_BO1,204,203,200_.jpg"
        ),
        Book(
            name: "You Don’t Know JS",
            author: "Kyle Simpson",
            publishDate: "2015",
            imageName: "https://images-na.ssl-images-amazon.com/images/I/51B7KU8JQ-L._SX331_BO1,204,203,200_.jpg"
        )
    ]

}

extension BookStore {

    func addBook(_ book: Book) {
        allBooks.append(book)
    }
}
