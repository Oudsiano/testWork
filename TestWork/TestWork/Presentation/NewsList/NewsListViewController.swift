import UIKit

//TODO:
final class NewsListViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    var newsArticles: [Article] = []
    
    enum Constants {
        enum CollectionView {
            static let backgroundColor = UIColor.white
            static let rightOffset = -10 as CGFloat
            static let leftOffset = 10 as CGFloat
            static let topOffset = 30 as CGFloat
            static let horizontalDistanceCell = 30 as CGFloat
            static let hightCell = 200 as CGFloat
            static let cellCount = 20
        }
        enum HeadingTop {
            static let backgroundColor = UIColor.white
            static let headingText = "More For You"
            static let fontSize = 40
        }
    }
    let sessionConfiguration = URLSessionConfiguration.default
    let session = URLSession.shared
    let decoder = JSONDecoder()
    
    private lazy var collectionVIew: UICollectionView = {
        let view = UICollectionView()
        return view
    }()
    
    private lazy var headingTop: UILabel = {
        let view = UILabel()
        view.backgroundColor = UIColor.white
        view.text = Constants.HeadingTop.headingText
        view.numberOfLines = 0
        view.textAlignment = NSTextAlignment.left
        view.font = UIFont.boldSystemFont(ofSize: CGFloat(Constants.HeadingTop.fontSize))
        return view
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = UIColor.white
        obtainPosts()
        setupCollectionView()
        setupHeading()
    }
    func setupHeading() {
        view.addSubview(headingTop)
        headingTop.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headingTop.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            headingTop.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            headingTop.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
    }
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        collectionVIew = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.addSubview(collectionVIew)
        view.addSubview(headingTop)
        collectionVIew.translatesAutoresizingMaskIntoConstraints = false
        collectionVIew.backgroundColor = Constants.CollectionView.backgroundColor
        //ставим кастомные
        collectionVIew.topAnchor.constraint(equalTo: headingTop.bottomAnchor, constant: Constants.CollectionView.topOffset).isActive = true
        collectionVIew.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Constants.CollectionView.leftOffset).isActive = true
        collectionVIew.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Constants.CollectionView.rightOffset).isActive = true
        collectionVIew.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        
        
        collectionVIew.dataSource = self
        collectionVIew.delegate = self
        collectionVIew.register(CustomCollectionViewCell.self, forCellWithReuseIdentifier: CustomCollectionViewCell.identifier)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) ->  Int {
        return newsArticles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.identifier, for: indexPath) as! CustomCollectionViewCell
        let articleToIndex = newsArticles[indexPath.row]
        cell.configure(articleForCells: articleToIndex)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width - Constants.CollectionView.horizontalDistanceCell, height: Constants.CollectionView.hightCell)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

        let articleToIndex = newsArticles[indexPath.row]
        tapCell(newsArticle: articleToIndex)
        
    }
    private func tapCell(newsArticle: Article) {
        let VC = SecondViewController(newsArticle: newsArticle)
        VC.modalPresentationStyle = .pageSheet
        navigationController?.pushViewController(VC, animated: true)
    }
    
    //TODO: Вынести в presentor (Архитектура MVP)
    //MARK: URL
    
    func obtainPosts() {
        let urlString = "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=be4975f02b964a008b5186c21ec7ccab"
        

        guard let url = URL(string: urlString) else {
            return
        }
        let session = URLSession.shared
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
//TODO: - Refactoring
//MARK: - UICollectionViewDataSource
extension NewsListViewController: UICollectionViewDataSource {
    
}
