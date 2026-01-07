//
//  CellView.swift
//  NavigationApp
//
//  Created by hoang.nguyenh on 1/2/26.
//

import UIKit

final class BookCellView: UICollectionViewCell {

    static let identifier = "BookCellView"

    private let coverImageView = UIImageView()
    private let nameLabel = UILabel()
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    
    private var imageTask: URLSessionDataTask?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        contentView.backgroundColor = .secondarySystemBackground
        contentView.layer.cornerRadius = 12
        contentView.clipsToBounds = true

        // Image
        coverImageView.contentMode = .scaleAspectFill
        coverImageView.clipsToBounds = true
        coverImageView.image = UIImage(systemName: "photo")
        coverImageView.layer.cornerRadius = 8
        coverImageView.translatesAutoresizingMaskIntoConstraints = false

        // Labels
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)

        authorLabel.font = .systemFont(ofSize: 14)
        authorLabel.textColor = .secondaryLabel

        dateLabel.font = .systemFont(ofSize: 13)
        dateLabel.textColor = .tertiaryLabel

        let stack = UIStackView(arrangedSubviews: [
            coverImageView,
            nameLabel,
            authorLabel,
            dateLabel
        ])
        stack.axis = .vertical
        stack.alignment = .fill
        stack.spacing = 4
        stack.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(stack)

        NSLayoutConstraint.activate([
            coverImageView.heightAnchor.constraint(equalTo: coverImageView.widthAnchor, multiplier: 3.0/2.0),

            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()

        // Huỷ request cũ nếu cell bị reuse
        imageTask?.cancel()
        imageTask = nil

        // Reset image
        coverImageView.image = UIImage(systemName: "photo")
    }

    // Gán dữ liệu
    func configure(with book: Book) {
        loadImage(from: book.imageName)
        nameLabel.text = book.name
        authorLabel.text = book.author
        dateLabel.text = book.publishDate
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }

        imageTask = URLSession.shared.dataTask(with: url) { [weak self] data, _, _ in
            guard
                let self,
                let data,
                let image = UIImage(data: data)
            else { return }

            DispatchQueue.main.async {
                self.coverImageView.image = image
            }
        }

        imageTask?.resume()
    }
}


