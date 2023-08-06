import UIKit

class CustomCollectionViewCell: UICollectionViewCell {//создаем ячейку наследуясь от ячейки пользовательского интефейса
    let newsImageView = UIImageView() //инициализируем Картинку новости
    
    static let identifier = "CustomCollectionViewCell"
    
    private let myLabel: UILabel = {
        let label = UILabel()
        label.text = "custom"
        label.backgroundColor = .white
            return label
    }()
    private let viewsCount: UILabel = {
        let label = UILabel()
        label.text = "14"
        label.backgroundColor = .white
            return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(newsImageView)
        contentView.addSubview(myLabel)
        contentView.addSubview(viewsCount)
        //добавляем в ячейку картинку новости
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        newsImageView.layer.cornerRadius = 20 //устанавливаем скругление картинки
        newsImageView.layer.masksToBounds = true
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        myLabel.frame = CGRect(x: 0,
                               y: contentView.frame.size.height - 50,
                               width: contentView.frame.size.width,
                               height: 50)
        myLabel.layer.cornerRadius = 20
        myLabel.layer.masksToBounds = true
        
        viewsCount.frame = CGRect(x: contentView.frame.size.width - 35,
                               y: 0,
                               width: 35,
                               height: 50)
        viewsCount.layer.cornerRadius = 20
        viewsCount.layer.masksToBounds = true
    }
}
