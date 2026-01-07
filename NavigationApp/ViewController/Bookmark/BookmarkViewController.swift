//
//  BookmarkViewController.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/5/26.
//

import UIKit

final class BookmarkViewController: UIViewController, UICollectionViewDelegate {

    private var collectionView: UICollectionView!

    private var books: [Book] {
        BookStore.shared.allBooks
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmarks"
        view.backgroundColor = .systemBackground
        setupNavigationBar()
        setupCollectionView()
    }
    
    private func setupNavigationBar() {
        let addButton = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(didTapAdd)
        )
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func didTapAdd() {
        let vc = AddBookViewController()
        navigationController?.pushViewController(vc, animated: true)
    }


    private func setupCollectionView() {

        collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: createLayout()
        )
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .systemBackground

        collectionView.dataSource = self
        collectionView.delegate = self

        collectionView.register(
            BookCellView.self,
            forCellWithReuseIdentifier: BookCellView.identifier
        )

        view.addSubview(collectionView)

        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func createLayout() -> UICollectionViewLayout {

        // ITEM (1 cell)
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(260)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        // GROUP (3 column)
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(260)
        )

        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: groupSize,
            subitem: item,
            count: 3
        )

        group.interItemSpacing = .fixed(2)

        // SECTION
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(
            top: 8,
            leading: 8,
            bottom: 8,
            trailing: 8
        )

        return UICollectionViewCompositionalLayout(section: section)
    }
}



extension BookmarkViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        books.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: BookCellView.identifier,
            for: indexPath
        ) as! BookCellView

        let book = books[indexPath.item]
        cell.configure(with: book)

        return cell
    }
}
