//
//  UserSession.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/2/26.
//



class UserSession {
    static let shared = UserSession()
    
    // Trạng thái đăng nhập
    var isLoggedIn: Bool = false
    
    // Thông tin user đang đăng nhập
    var currentUser: User?
    
    // Danh sách "DB" User hệ thống
    var allUsers: [User] = [
        User(userName: "admin", name:"Alice Managet", email: "admin@gmail.com", phone: "09123", address: "VietNam, Hanoi", sex: "Male", age: 25, favoriteBooks: []),
        User(userName: "gemini", name: "Robot 01", email: "gemini@ai.com", phone: "09999", address: "Cloud", sex: "Female", age: 1, favoriteBooks: ["Swift Programming"]),
        User(userName: "user1", name:"John Warwick", email: "user1@gmail.com", phone: "01234", address: "USA, Texas", sex: "Male", age: 20, favoriteBooks: []),
        User(userName: "user2", name:"Hoang Nguyen Huy", email: "user2@gmail.com", phone: "01234", address: "VietNam, HCM City", sex: "Male", age: 20, favoriteBooks: []),
        User(userName: "user3", name:"Han Pham Gia", email: "user3@gmail.com", phone: "01234", address: "VietNam, Da Nang", sex: "Female", age: 20, favoriteBooks: []),
        User(userName: "user4", name:"Alexandra", email: "user4@gmail.com", phone: "01234", address: "Australia, Melbourne", sex: "Female", age: 20, favoriteBooks: [])
    ]
    
    private init() {}
    
    // Hàm bổ sung sách vào danh sách yêu thích của user đang đăng nhập
    func addFavorite(bookName: String) {
        if let index = allUsers.firstIndex(where: { $0.userName == currentUser?.userName }) {
            allUsers[index].favoriteBooks.append(bookName)
            currentUser = allUsers[index] // Cập nhật lại bản hiển thị hiện tại
        }
    }
}
