import UIKit

class CustomCollectionViewCell: UICollectionViewCell {//создаем ячейку наследуясь от ячейки пользовательского интефейса
    enum Constants{
        enum Cell {
            enum Label {
                static let newsTitle = "Список новостоей"
                static let labelBackgroundColor = UIColor.blue
                static let textTitleColor = UIColor.red
                static let heightLabel = 50 as CGFloat
                static let cornerRadiusLabel = 20 as CGFloat
                static let labelBotOffsetCell = 50 as CGFloat
            }
            enum Image {
                static let cornerRadiusImage = 20 as CGFloat
            }
            enum ViewsCount {
                static let viewsCountText = "14"
                static let viewsCountBackgroundColor = UIColor.blue
                static let textViewsCountColor = UIColor.black
            }
        }
    }
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.textColor = Constants.Cell.Label.textTitleColor
        label.text = Constants.Cell.Label.newsTitle
        label.backgroundColor = Constants.Cell.Label.labelBackgroundColor
        label.textAlignment = .center
        return label
    }()
    private let viewsCount: UILabel = {
        let viewsCount = UILabel()
        viewsCount.text = Constants.Cell.ViewsCount.viewsCountText
        viewsCount.backgroundColor = Constants.Cell.ViewsCount.viewsCountBackgroundColor
        viewsCount.textColor = Constants.Cell.ViewsCount.textViewsCountColor
        viewsCount.textAlignment = .center
        return viewsCount
    }()
    
    private let myImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = (UIImage(systemName: "house")) //устанавливаем изображение
        imageView.contentMode = .scaleAspectFit
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
    private func setupImageNews() {
        
        myImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            myImage.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            myImage.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            myImage.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            myImage.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        myImage.layer.cornerRadius = Constants.Cell.Image.cornerRadiusImage //устанавливаем скругление картинки
        myImage.layer.masksToBounds = true
    }
    private func setupCellLabel() {
        
        myLabel.frame = CGRect(x: 0,
                               y: contentView.frame.size.height - Constants.Cell.Label.labelBotOffsetCell ,
                               width: contentView.frame.size.width,
                               height: Constants.Cell.Label.heightLabel)
        myLabel.layer.cornerRadius = Constants.Cell.Label.cornerRadiusLabel
        myLabel.layer.masksToBounds = true
        
    }
    private func setupCellViewsCount() {
        viewsCount.frame = CGRect(x: contentView.frame.size.width - 35,
                                  y: 0,
                                  width: 35,
                                  height: 50)
        viewsCount.layer.cornerRadius = 20
        viewsCount.layer.masksToBounds = true
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        setupCellLabel()
        setupCellViewsCount()
    }
}

//@objc private func didTapMenuButton() {
//    let vc = SecondViewController()
//    vc.view.backgroundColor = Constants.View.backgroundColor
//    navigationController?.pushViewController(vc, animated: true)
//    let loger = Logger()
//    loger.log(event: LogInfo(line: #line, file: #file, function: #function))
//    }
//}

