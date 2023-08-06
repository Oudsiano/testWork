import UIKit

class ViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
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
        collectionVIew.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.CollectionView.topOffset).isActive = true
            collectionVIew.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20).isActive = true
            collectionVIew.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
            collectionVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 10).isActive = true

        
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        collectionVIew.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)//регистрируем ячейку
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->  Int { //Получаем точное количество элементов в разделе или сколько ячеек мы хотим отобразить в коллекции
        return news.count
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell //создаем экземпляр ячейки с использованием многоразовой ячейки с идентификатором из списка представления коллекции
        //используем в withReuseIdentifier зарегистрированный идентификатор
        //в withReuseIdentifier указываем путь
        cell.newsImageView.image = UIImage(named: news[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - 40, height: 200)
    }//устанавливаем размер ячейки
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("news \(indexPath.row + 1) is tapped")
    }
}






