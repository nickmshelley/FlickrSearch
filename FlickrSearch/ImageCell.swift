
import UIKit
import SDWebImage

class ImageCell: UITableViewCell {
    let thumbnailImageView = UIImageView(frame: .zero)
    let titleLabel = UILabel(frame: .zero)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        thumbnailImageView.contentMode = .scaleAspectFill
        thumbnailImageView.clipsToBounds = true
        
        titleLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            thumbnailImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            thumbnailImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            thumbnailImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            thumbnailImageView.trailingAnchor.constraint(equalTo: titleLabel.leadingAnchor, constant: -12),
            thumbnailImageView.heightAnchor.constraint(equalToConstant: 75),
            thumbnailImageView.widthAnchor.constraint(equalToConstant: 75),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
            ])
    }
    
    func configure(url: URL?, title: String) {
        thumbnailImageView.sd_setImage(with: url, placeholderImage: nil)
        titleLabel.text = title
    }
}
