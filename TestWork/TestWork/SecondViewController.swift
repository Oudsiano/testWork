import UIKit

final class SecondViewController: RootViewController {
    var articleNews: Article
    var textForNews: String {
        articleNews.description ?? "net novosti"
    }
    var textForHeadingInput: String {
        articleNews.title ?? "net zagolovka"
    }
    var textForDate: String {
        articleNews.publishedAt ?? "net dati"
    }
    var linkToSourceInput: String {
        articleNews.url ?? "net ssilki"
    }
    var newsPicture3: String {
        articleNews.urlToImage ?? " "
    }

    enum Constants {
        enum TextLabel {
            static let heighte = 50 as CGFloat
            static let width = 150
            static let backgroundColor = UIColor.green
            static let textColor = UIColor.black
            static let offsetToLeftSafeArea = 0 as CGFloat
            static let offsetToRightSafeArea = 0 as CGFloat
            static let offsetToTopSafeArea = 0 as CGFloat
            static let offsetTopBotSafeAre = 0 as CGFloat
        }
        enum Image {
            static let cornerRadius = 20 as CGFloat
            static let imageWidth = 300 as CGFloat
        }
        enum Heading {
            static let text = "Heading"
            static let backgroundColor = UIColor.white
            static let offsetToTopSafeArea = 100 as CGFloat
            static let fontSize = 25
            static let leftOffsetHeading = 5 as CGFloat
        }
        enum DatePublication {
            static let text = "12.06.2023"
            static let backgroundColor = UIColor.white
            static let offsetToBotSafeArea = -50 as CGFloat
            static let offsetToLeftSafeArea = 50 as CGFloat
            static let cornerRadius = 5 as CGFloat
        }
        enum LinkToSourse {
            static let text = "https:"
            static let backgroundColor = UIColor.white
            static let leftOffsetToDatePublication = 50 as CGFloat
            static let cornerRadius = 5 as CGFloat
        }
    }
    
    // Properties
    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private lazy var datePublication: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.DatePublication.backgroundColor
        view.text = self.textForDate
        view.numberOfLines = 0
        return view
    }()
    private lazy var linkToSource: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.DatePublication.backgroundColor
        view.text = self.linkToSourceInput
        view.numberOfLines = 0
        return view
    }()

    private lazy var labelForMenu: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.TextLabel.backgroundColor
        view.text = self.textForNews
        view.numberOfLines = 0
        return view
    }()
    private lazy var headingNews: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.Heading.backgroundColor
        view.text = self.textForHeadingInput
        view.numberOfLines = 0
        view.font = UIFont(name: "Avenir Next", size: CGFloat(Constants.Heading.fontSize))
        view.textAlignment = NSTextAlignment.center
        return view
    }()
    
    
    private lazy var ffgr: String = " "
    
    // MARK: - Lifecycle
    
    init(newsArticle: Article) {
        self.articleNews = newsArticle
        super.init(nibName: nil, bundle: nil)
        setupImageNews()
        
        setupLinkToSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        print(ffgr)
        print(newsPicture3)
    }
    // MARK: - Private
    
    private func setupUI() {
        setupLabel()
        setupImageNews()
        setupHeading()
        setupDatePublication()
        setupLinkToSource()
    }
    
    private func setupHeading() {
        view.addSubview(headingNews)
        
        headingNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headingNews.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.Heading.offsetToTopSafeArea),
            headingNews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingNews.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: Constants.Heading.leftOffsetHeading)
        ])
    }
    private func setupDatePublication() {
        view.addSubview(datePublication)
        
        datePublication.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePublication.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.DatePublication.offsetToBotSafeArea),
            datePublication.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.DatePublication.offsetToLeftSafeArea)
        ])
        datePublication.layer.cornerRadius = Constants.DatePublication.cornerRadius //устанавливаем скругление картинки
        datePublication.layer.masksToBounds = true
    }
    private func setupLinkToSource() {
        view.addSubview(linkToSource)
        view.addSubview(datePublication)
        linkToSource.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkToSource.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.DatePublication.offsetToBotSafeArea),
            linkToSource.leftAnchor.constraint(equalTo: datePublication.rightAnchor, constant: Constants.DatePublication.offsetToLeftSafeArea)
        ])
    }
    private func setupImageNews() {
        view.addSubview(newsImage)
        view.addSubview(headingNews)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: headingNews.bottomAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: 200 as CGFloat),
            newsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: Constants.Image.imageWidth),
        ])
        
        newsImage.layer.cornerRadius = Constants.Image.cornerRadius //устанавливаем скругление картинки
        newsImage.layer.masksToBounds = true
//
//        let imageView = UIImageView()
//        newsImage.contentMode = UIView.ContentMode.scaleAspectFit
//                view.addSubview(newsImage)
//
                // Create URL
                let imageUrlString = newsPicture3
                guard let imageUrl:URL = URL(string: imageUrlString) else {
                    return
                }
        newsImage.loadImage(url: imageUrl)
         
                self.view = view
    }
    
    
    
    private func setupLabel() {
        view.addSubview(labelForMenu)
        labelForMenu.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelForMenu.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.TextLabel.offsetToLeftSafeArea),
            labelForMenu.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.TextLabel.offsetToRightSafeArea),
            labelForMenu.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.TextLabel.offsetToTopSafeArea),
            labelForMenu.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: Constants.TextLabel.offsetTopBotSafeAre)
        ])
    }
}
extension UIImageView {
    func loadImage(url: URL) {
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

