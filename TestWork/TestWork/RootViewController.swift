import UIKit

class RootViewController: UIViewController, UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var newsTitles: [String] = []
    var newsHeadings: [String] = []
    var newsDates: [String] = []
    var newsLinkToSources: [String] = []
    var imageNewses: [String] = []
//    var imageNewsesArrayImage: [UIImage] = []
    
    var newsDescription = ""
    var newsHeading = ""
    var newsDate = ""
    var newsLinkToSource = ""
    var newsImageIndex: String = ""
//    var lastImageNews: UIImage = UIImage(systemName: "house")!

    
    var indexNews = 0
    var newsCount: Int = 20
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
    
    var collectionVIew: UICollectionView! //для создания коллекции сначала нужен ее экземпляр
    
    override func viewDidLoad() {
        setupCollectionView()
        obtainPosts()
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
        return Constants.CollectionView.cellCount
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell //создаем экземпляр ячейки с использованием многоразовой ячейки с идентификатором из списка представления коллекции
        //используем в withReuseIdentifier зарегистрированный идентификатор
        //в withReuseIdentifier указываем путь
        return cell
    }
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width/2 - Constants.CollectionView.horizontalDistanceCell, height: Constants.CollectionView.hightCell)
    }//устанавливаем размер ячейки
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("news \(indexPath.row + 1) is tapped")
        
        indexNews = indexPath.row
        print(newsDescription.count + 25)
        newsDescription = newsTitles[indexNews]
        newsHeading = newsHeadings[indexNews]
        newsDate = newsDates[indexNews]
        newsLinkToSource = newsLinkToSources[indexNews]
//        newsImageIndex = imageNewses[indexNews]
//        lastImageNews = imageNewsesArrayImage[0]
        
        tapCell()
        
    }
    private func tapCell() {
        let VC = SecondViewController(textForNews: newsDescription,textForHeadingInput: newsHeading,textForDate: newsDate,linkToSourceInput: newsLinkToSource)
        navigationController?.pushViewController(VC, animated: true)
        VC.modalPresentationStyle = .overFullScreen
        VC.modalTransitionStyle = .coverVertical
    }
    
    func obtainPosts() {
        let urlString = "https://newsapi.org/v2/everything?q=tesla&from=2023-07-16&sortBy=publishedAt&apiKey=be4975f02b964a008b5186c21ec7ccab"
        let url = URL(string: urlString)
        
        guard url != nil else {
            return
        }
        let session = URLSession.shared
        
        let dataTask = session.dataTask(with: url!) { [self] (data, response, error) in
            
            //check for error 
            if error == nil && data != nil {
                let decoder = JSONDecoder()
                do {
                    let newsFeed = try decoder.decode(NewsFeed.self, from: data!)
//                    print(newsFeed)
//                    print(newsFeed.articles?.count)
//                    print(newsFeed.articles?[0].title)
//                    self.article = newsFeed.articles?[0].description
                    
                    print(newsFeed.articles.count)
                    for i in 0...newsCount {
                        if (newsFeed.articles[i].description != nil) {
                            newsTitles.append(newsFeed.articles[i].description!)
                            newsHeadings.append(newsFeed.articles[i].title!)
                            newsDates.append(newsFeed.articles[i].publishedAt!)
                            newsLinkToSources.append(newsFeed.articles[i].url!)
                            imageNewses.append(newsFeed.articles[i].urlToImage ?? "net")
//                            print(newsFeed.articles[0].urlToImage)
                        }
                    }
                }
                catch {
                    print("Error in JSON parse")
                }
            }
        }
        
        dataTask.resume()
        
    }
//    private func newsImageAdded(link: String) {
//        let url = URL(string: link)
//        let data = try? Data(contentsOf: url!)
////        imageNewsesArrayImage.append(((UIImage(data: data!) ?? UIImage(systemName: "house"))!))
//    }
}
