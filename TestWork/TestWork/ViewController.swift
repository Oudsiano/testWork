import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    
    enum Constants{
        enum CollectionView {
            static let title = "Список новостоей"
            static let backgroundColor = UIColor.green
            static let titleColor = UIColor.black
            static let centerYCollectionViewCenterScreen = -40 as CGFloat
            static let widthCollectionView = 200 as CGFloat
            static let heightCollectionView = 60 as CGFloat
            static let rightOffset = 30 as CGFloat
            static let leftOffset = 30 as CGFloat
            static let topOffset = 30 as CGFloat
            static let bottomOffset = 30 as CGFloat
        }
    }
    let news = ["news1","news2","news3","news4","news5"]
    
    var collectionVIew: UICollectionView! //для создания коллекции сначала нужен ее экземпляр
    
    override func viewDidLoad() {
        setupCollectionView()
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout() //макет представления типа
        collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout) //инициализируем представление коллекции с помощью рамки и макета представления коллекции
        view.addSubview(collectionVIew)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false //снимаем заводские констрейнты
        collectionVIew.backgroundColor = Constants.CollectionView.backgroundColor
        //ставим кастомные
        NSLayoutConstraint.activate([
            collectionVIew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.CollectionView.topOffset),
            collectionVIew.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionVIew.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        collectionVIew.register(CustomCell.self, forCellWithReuseIdentifier: "cell")//регистрируем ячейку
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->  Int { //Получаем точное количество элементов в разделе или сколько ячеек мы хотим отобразить в коллекции
        return news.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell //создаем экземпляр ячейки с использованием многоразовой ячейки с идентификатором из списка представления коллекции
        //используем в withReuseIdentifier зарегистрированный идентификатор
        //в withReuseIdentifier указываем путь
        cell.newsImageView.image = UIImage(named: news[indexPath.row])
        return cell
    }
}

class CustomCell: UICollectionViewCell {//создаем ячейку наследуясь от ячейки пользовательского интефейса
    let newsImageView = UIImageView() //инициализируем Картинку новости
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(newsImageView) //добавляем в ячейку картинку новости
        
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            newsImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            newsImageView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            newsImageView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

