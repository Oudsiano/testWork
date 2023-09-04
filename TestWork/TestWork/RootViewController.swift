import UIKit

class RootViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var newsArticles: [Article] = []
    
//    var newsDescriptions: [String] = []
//    var newsHeadings: [String] = []
//    var newsDates: [String] = []
//    var newsLinkToSources: [String] = []
//    var newsPictures: [String] = []
//
//
//    var newsDescription = ""
//    var newsHeading = ""
//    var newsDate = ""
//    var newsLinkToSource = ""
//    var newsImageIndex: String = ""
//    var newsPicture = ""
    
//    var indexNews = 0
//    var newsCount: Int = 20
    enum Constants{
        enum CollectionView {
            static let title = "Список новостоей"
            static let backgroundColor = UIColor.green
            static let titleColor = UIColor.black
            static let centerYCollectionViewCenterScreen = -40 as CGFloat
            static let widthCollectionView = 200 as CGFloat
            static let heightCollectionView = 60 as CGFloat
            static let rightOffset = -10 as CGFloat
            static let leftOffset = 10 as CGFloat
            static let topOffset = 30 as CGFloat
            static let bottomOffset = 30 as CGFloat
            static let horizontalDistanceCell = 30 as CGFloat
            static let hightCell = 200 as CGFloat
            static let cellCount = 20
        }
    }
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared//подключение к сети
    let decoder = JSONDecoder() //переводчик на swift с Json
    //TODO: убрать форс анврапинг
    var collectionVIew: UICollectionView! //для создания коллекции сначала нужен ее экземпляр
    
    override func viewDidLoad() {
        obtainPosts()
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
        collectionVIew.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.CollectionView.leftOffset).isActive = true
        collectionVIew.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.CollectionView.rightOffset).isActive = true
        collectionVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        collectionVIew.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)//регистрируем ячейку
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->  Int { //Получаем точное количество элементов в разделе или сколько ячеек мы хотим отобразить в коллекции
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let articleToIndex = newsArticles[indexPath.row]
        cell.configure(articleForCells: articleToIndex)
        //создаем экземпляр ячейки с использованием многоразовой ячейки с идентификатором из списка представления коллекции
        //используем в withReuseIdentifier зарегистрированный идентификатор
        //в withReuseIdentifier указываем путь
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - Constants.CollectionView.horizontalDistanceCell, height: Constants.CollectionView.hightCell)
    }//устанавливаем размер ячейки
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("news \(indexPath.row + 1) is tapped")
//        indexNews = indexPath.row
        let articleToIndex = newsArticles[indexPath.row]
        tapCell(newsArticle: articleToIndex)
        
    }
    private func tapCell(newsArticle: Article) {
        let VC = SecondViewController(newsArticle: newsArticle)
        navigationController?.pushViewController(VC, animated: true)
        VC.modalPresentationStyle = .overFullScreen
        VC.modalTransitionStyle = .coverVertical
    }
    
    func obtainPosts() {
        let urlString = "https://newsapi.org/v2/everything?q=apple&from=2023-08-26&to=2023-08-26&sortBy=popularity&apiKey=be4975f02b964a008b5186c21ec7ccab"
        

        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
        //TODO:
        let dataTask = session.dataTask(with: url) { [self] (data, response, error) in
            
            //check for error 
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                     let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
                    print(newsFeed)
                    self.newsArticles = newsFeed.articles
                    DispatchQueue.main.async {
                        self.collectionVIew.reloadData()
                    }
                }
                catch {
                    print("Error in JSON parse")
                }
            }
        }
        dataTask.resume()
    }
}
