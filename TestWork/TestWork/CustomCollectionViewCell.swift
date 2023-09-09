import UIKit

class CustomCollectionViewCell: UICollectionViewCell {//создаем ячейку наследуясь от ячейки пользовательского интефейса

    enum Constants{
        enum Cell {
            enum Label {
                static let newsTitle = "Список новостоей"
                static let labelBackgroundColor = UIColor.white
                static let textTitleColor = UIColor.black
                static let heightLabel = 50 as CGFloat
                static let cornerRadiusLabel = 0 as CGFloat
                static let labelBotOffsetCell = 50 as CGFloat
                static let fontSize = 20 as CGFloat
            }
            enum Image {
                static let cornerRadiusImage = 20 as CGFloat
            }
            enum DatePublication {
                static let datePublicationText = "14"
                static let datePublicationBackgroundColor = UIColor.white
                static let textDatePublicationColor = UIColor.black
                static let widthDatePublication = 35 as CGFloat
                static let heightDatePublication = 50 as CGFloat
                static let cornerRadiusDatePublication = 20 as CGFloat
                static let rightOffsetDatePublication = 35 as CGFloat
            }
        }
    }
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Cell.Label.textTitleColor
        label.text = Constants.Cell.Label.newsTitle
        label.backgroundColor = Constants.Cell.Label.labelBackgroundColor
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: Constants.Cell.Label.fontSize)
        return label
    }()
    private let datePublication: UILabel = {
        let datePublicationNews = UILabel()
        datePublicationNews.text = Constants.Cell.DatePublication.datePublicationText
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
        collectionViewSetup()
        setupImageNews()
        //добавляем в ячейку картинку новости
    }
    
    private func collectionViewSetup() {
        contentView.addSubview(myImage)
        contentView.addSubview(myLabel)
        contentView.addSubview(datePublication)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //TODO: по аналогии картинку и количество просмотров
    func configure(articleForCells: Article) {
        myLabel.text = articleForCells.title
        guard var datePublished = articleForCells.publishedAt else {
            return
        }
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        guard let datePublishedDate = dateFormatter.date(from: datePublished) else { return }
        let dateComponentsFormatter = DateComponentsFormatter()
        let dateNow = Date()
        dateComponentsFormatter.allowedUnits = [NSCalendar.Unit.year, .month, .day, .hour, .minute]
        dateComponentsFormatter.maximumUnitCount = 1
        dateComponentsFormatter.unitsStyle = DateComponentsFormatter.UnitsStyle.full
        let timeDifference = dateComponentsFormatter.string(from: datePublishedDate, to: dateNow)

        datePublication.text = articleForCells.publishedAt
        
        var newsPicture3: String {
            articleForCells.urlToImage ?? " "
        }
        let imageUrlString = newsPicture3
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        myImage.loadImage(url: imageUrl)
        }
        
    private func setupImageNews() {
        
        myImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            myImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor,constant: 20 as CGFloat),
            myImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        myImage.layer.cornerRadius = Constants.Cell.Image.cornerRadiusImage //устанавливаем скругление картинки
        myImage.layer.masksToBounds = true
    }
    private func setupCellLabel() {
        addSubview(myImage)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myLabel.topAnchor.constraint(equalTo: myImage.topAnchor),
            myLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myLabel.rightAnchor.constraint(equalTo: myImage.leftAnchor,constant: -5 as CGFloat),
            myLabel.bottomAnchor.constraint(equalTo: myImage.bottomAnchor)
        ])
        myLabel.layer.cornerRadius = Constants.Cell.Label.cornerRadiusLabel
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
