import UIKit

class CustomCollectionViewCell: UICollectionViewCell {
    
    enum Constants{
        enum Cell {
            enum Label {
                static let labelBackgroundColor = UIColor.white
                static let textTitleColor = UIColor.black
                static let fontSize = 20 as CGFloat
                static let rightOffsetImage = -5 as CGFloat
            }
            enum Image {
                static let cornerRadiusImage = 20 as CGFloat
                static let imageCenterRightOffset = 20 as CGFloat
            }
            enum DatePublication {
                static let datePublicationBackgroundColor = UIColor.white
                static let textDatePublicationColor = UIColor.black
            }
        }
    }
    static let identifier = "CustomCollectionViewCell"
    
    //UI
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Cell.Label.textTitleColor
        label.backgroundColor = Constants.Cell.Label.labelBackgroundColor
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.Cell.Label.fontSize)
        return label
    }()
    private let datePublication: UILabel = {
        let datePublicationNews = UILabel()
        datePublicationNews.backgroundColor = Constants.Cell.DatePublication.datePublicationBackgroundColor
        datePublicationNews.textColor = Constants.Cell.DatePublication.textDatePublicationColor
        return datePublicationNews
    }()
    
    private let myImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = (UIImage(systemName: "house")) //устанавливаем изображение
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //MARK: Private
    
    private func setupUI() {
        collectionViewSetup()
        setupImageNews()
    }
    private func collectionViewSetup() {
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(datePublication)
        contentView.clipsToBounds = true
    }
    
    func configure(articleForCells: Article) {
        myLabel.text = articleForCells.title
        datePublicationInstallation(dateString: articleForCells.publishedAt)
        var newsPicture3: String {
            articleForCells.urlToImage ?? " "
        }
        let imageUrlString = newsPicture3
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        myImage.loadImage(url: imageUrl)
    }
    
    private func datePublicationInstallation(dateString: String) {
        let publishDateString = dateString
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let publishDate = dateFormatter.date(from:publishDateString) else {
            return
        }
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .full
        let relativeDate = formatter.localizedString(for: publishDate, relativeTo: Date())
        datePublication.text = String(relativeDate)
    }
    
    private func setupImageNews() {
        myImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            myImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor,constant: Constants.Cell.Image.imageCenterRightOffset),
            myImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        myImage.layer.cornerRadius = Constants.Cell.Image.cornerRadiusImage
        myImage.layer.masksToBounds = true
    }
    private func setupCellLabel() {
        addSubview(myImage)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: myImage.topAnchor),
            myLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myLabel.rightAnchor.constraint(equalTo: myImage.leftAnchor,constant: Constants.Cell.Label.rightOffsetImage),
            myLabel.bottomAnchor.constraint(equalTo: myImage.bottomAnchor)
        ])
        myLabel.layer.masksToBounds = true
    }
    
    private func setupdatePublication() {
        addSubview(datePublication)
        addSubview(myImage)
        datePublication.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePublication.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            datePublication.rightAnchor.constraint(equalTo: myImage.leftAnchor),
            datePublication.bottomAnchor.constraint(equalTo: myImage.bottomAnchor)
        ])
        datePublication.layer.masksToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellLabel()
        setupdatePublication()
    }
}

extension  UIImageView {
    func loadImageForCell(url: URL) {
        DispatchQueue.global().async {
            [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
