//
//  AddBookViewController.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/5/26.
//

import UIKit

final class AddBookViewController: UIViewController {

    private let nameField = UITextField()
    private let authorField = UITextField()
    private let yearField = UITextField()
    private let imageURLField = UITextField()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Add Book"
        view.backgroundColor = .systemBackground

        setupUI()
        setupSaveButton()
    }
    
    private func setupUI() {
        nameField.placeholder = "Book name"
        nameField.backgroundColor = .systemGray6
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.heightAnchor.constraint(equalToConstant: 40).isActive = true
    
        
        
        authorField.placeholder = "Author"
        authorField.backgroundColor = .systemGray6
        authorField.translatesAutoresizingMaskIntoConstraints = false
        authorField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        yearField.placeholder = "Publish year"
        yearField.backgroundColor = .systemGray6
        yearField.translatesAutoresizingMaskIntoConstraints = false
        yearField.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        
        
        imageURLField.placeholder = "Image URL"
        imageURLField.backgroundColor = .systemGray6
        imageURLField.translatesAutoresizingMaskIntoConstraints = false
        imageURLField.heightAnchor.constraint(equalToConstant: 40).isActive = true

        
        
        let stack = UIStackView(arrangedSubviews: [
            nameField,
            authorField,
            yearField,
            imageURLField
        ])
        stack.axis = .vertical
        stack.spacing = 12
        stack.translatesAutoresizingMaskIntoConstraints = false

        view.addSubview(stack)

        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            stack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }
    
    private func setupSaveButton() {
        let saveButton = UIBarButtonItem(
            title: "Save",
            style: .prominent,
            target: self,
            action: #selector(didTapSave)
        )
        navigationItem.rightBarButtonItem = saveButton
    }
    
    @objc private func didTapSave() {
        guard
            let name = nameField.text, !name.isEmpty,
            let author = authorField.text, !author.isEmpty,
            let year = yearField.text, !year.isEmpty,
            let imageURL = imageURLField.text, !imageURL.isEmpty
        else { return }

        let book = Book(
            name: name,
            author: author,
            publishDate: year,
            imageName: imageURL
        )

        BookStore.shared.addBook(book)

        navigationController?.popViewController(animated: true)
    }

}
