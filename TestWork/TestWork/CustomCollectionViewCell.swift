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
            }
            enum Image {
                static let cornerRadiusImage = 20 as CGFloat
            }
            enum ViewsCount {
                static let viewsCountText = "14"
                static let viewsCountBackgroundColor = UIColor.blue
                static let textViewsCountColor = UIColor.black
                static let widthViewsCount = 35 as CGFloat
                static let heightViewsCount = 50 as CGFloat
                static let cornerRadiusViewsCount = 20 as CGFloat
                static let rightOffset = 35 as CGFloat
            }
        }
    }
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Cell.Label.textTitleColor
        label.text = Constants.Cell.Label.newsTitle
        label.backgroundColor = Constants.Cell.Label.labelBackgroundColor
        return label
    }()
    private let viewsCount: UILabel = {
        let viewsCount = UILabel()
        viewsCount.text = Constants.Cell.ViewsCount.viewsCountText
        viewsCount.backgroundColor = Constants.Cell.ViewsCount.viewsCountBackgroundColor
        viewsCount.textColor = Constants.Cell.ViewsCount.textViewsCountColor
        return viewsCount
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
        contentView.addSubview(viewsCount)
        contentView.clipsToBounds = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //TODO: по аналогии картинку и количество просмотров
    func configure(articleForCells: Article) {
        myLabel.text = articleForCells.title
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
            myImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.centerXAnchor),
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
            myLabel.topAnchor.constraint(equalTo: myImage.topAnchor,constant: -150 as CGFloat),
            myLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myLabel.rightAnchor.constraint(equalTo: myImage.leftAnchor),
            myLabel.bottomAnchor.constraint(equalTo: myImage.bottomAnchor)
        ])
        myLabel.layer.cornerRadius = Constants.Cell.Label.cornerRadiusLabel
        myLabel.layer.masksToBounds = true
        
    }
    private func setupCellViewsCount() {
//        viewsCount.frame = CGRect(x: contentView.frame.size.width - Constants.Cell.ViewsCount.rightOffset,
//                                  y: 0,
//                                  width: Constants.Cell.ViewsCount.widthViewsCount,
//                                  height: Constants.Cell.ViewsCount.heightViewsCount)
        viewsCount.layer.cornerRadius = Constants.Cell.ViewsCount.cornerRadiusViewsCount
        viewsCount.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellLabel()
        setupCellViewsCount()
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
