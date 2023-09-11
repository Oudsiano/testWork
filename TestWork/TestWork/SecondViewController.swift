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
        articleNews.publishedAt 
    }
    var linkToSourceInput: String {
        articleNews.url ?? "net ssilki"
    }
    var newsPicture3: String {
        articleNews.urlToImage ?? " "
    }

    enum Constants {
        enum TextLabel {
            static let height = 50 as CGFloat
            static let width = 150
            static let backgroundColor = UIColor.white
            static let textColor = UIColor.black
            static let offsetToLeftSafeArea = 0 as CGFloat
            static let offsetToRightSafeArea = 0 as CGFloat
            static let offsetToTopSafeArea = 0 as CGFloat
            static let offsetTopBotSafeAre = 0 as CGFloat
        }
        enum Image {
            static let cornerRadius = 20 as CGFloat
            static let imageWidth = 100 as CGFloat
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
        imageView.contentMode = .scaleAspectFill
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

    private lazy var descriptionNews: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.TextLabel.backgroundColor
        view.text = self.textForNews
        view.numberOfLines = 0
        view.textAlignment = .left
        return view
    }()
    private lazy var headingNews: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.Heading.backgroundColor
        view.text = self.textForHeadingInput
        view.numberOfLines = 0
        view.font = UIFont(name: "Avenir Next", size: CGFloat(Constants.Heading.fontSize))
        view.textAlignment = NSTextAlignment.left
        view.font = UIFont.boldSystemFont(ofSize: 40.0)
        return view
    }()
    
    
    private lazy var ffgr: String = " "
    
    // MARK: - Lifecycle
    
    init(newsArticle: Article) {
        self.articleNews = newsArticle
        super.init(nibName: nil, bundle: nil)
        setupImageNews()
        view.backgroundColor = UIColor.white
        setupLinkToSource()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
//        print(ffgr)
//        print(newsPicture3)
    }
    // MARK: - Private
    
    private func setupUI() {
        setupDescription()
        setupImageNews()
        setupHeading()
        setupDatePublication()
        setupLinkToSource()
    }
    
    internal override func setupHeading() {
        view.addSubview(headingNews)
        
        headingNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            headingNews.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headingNews.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 400 as CGFloat),
            headingNews.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            headingNews.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor,constant: Constants.Heading.leftOffsetHeading)
        ])
    }
    private func setupDatePublication() {
        view.addSubview(datePublication)
        view.addSubview(descriptionNews)
        view.addSubview(linkToSource)
        datePublication.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            datePublication.topAnchor.constraint(equalTo: descriptionNews.bottomAnchor),
            datePublication.bottomAnchor.constraint(equalTo: linkToSource.topAnchor),
            datePublication.leftAnchor.constraint(equalTo: view.leftAnchor),
            datePublication.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        datePublication.layer.cornerRadius = Constants.DatePublication.cornerRadius //устанавливаем скругление картинки
        datePublication.layer.masksToBounds = true
    }
    private func setupLinkToSource() {
        view.addSubview(linkToSource)
        view.addSubview(datePublication)
        linkToSource.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            linkToSource.leftAnchor.constraint(equalTo: view.leftAnchor),
            linkToSource.rightAnchor.constraint(equalTo: view.rightAnchor),
            linkToSource.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    private func setupImageNews() {
        view.addSubview(newsImage)
        view.addSubview(headingNews)
        newsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: headingNews.bottomAnchor),
            newsImage.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            newsImage.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            newsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: Constants.Image.imageWidth),
            newsImage.bottomAnchor.constraint(equalTo: headingNews.bottomAnchor, constant: 200 as CGFloat)
        ])
        
        newsImage.layer.cornerRadius = Constants.Image.cornerRadius //устанавливаем скругление картинки
        newsImage.layer.masksToBounds = true
        
        let imageUrlString = newsPicture3
        guard let imageUrl:URL = URL(string: imageUrlString) else {
            return
        }
        newsImage.loadImage(url: imageUrl)
        
 
//        self.view = view
        
    }
    
    
    
    private func setupDescription() {
        view.addSubview(descriptionNews)
        view.addSubview(headingNews)
        descriptionNews.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            descriptionNews.leftAnchor.constraint(equalTo: view.leftAnchor, constant: Constants.TextLabel.offsetToLeftSafeArea),
            descriptionNews.rightAnchor.constraint(equalTo: view.rightAnchor, constant: Constants.TextLabel.offsetToRightSafeArea),
            descriptionNews.topAnchor.constraint(equalTo: headingNews.bottomAnchor, constant: 200 as CGFloat)
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

