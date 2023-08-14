import UIKit

final class SecondViewController: RootViewController {
    let textForPass: String
    
    enum Constants {
        enum TextLabel {
            static let height = 50 as CGFloat
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
    }
    
    // Properties
    private let newsImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = (UIImage(systemName: "house")) //устанавливаем изображение
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private lazy var labelForMenu: UILabel = {
        let view = UILabel()
        view.backgroundColor = Constants.TextLabel.backgroundColor
        view.text = self.textForPass
        view.numberOfLines = 0
        return view
    }()
    
    
    private lazy var ffgr: String = " "
    
    // MARK: - Lifecycle
    
    init(textForPass: String) {
        self.textForPass = textForPass
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        print(ffgr)
    }
    // MARK: - Private
    
    private func setupUI() {
        setupLabel()
        setupImageNews()
    }
    
    private func setupImageNews() {
        view.addSubview(newsImage)

        newsImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newsImage.topAnchor.constraint(equalTo: view.topAnchor, constant: Constants.TextLabel.offsetToTopSafeArea),
            newsImage.bottomAnchor.constraint(equalTo: view.centerYAnchor),
            newsImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            newsImage.widthAnchor.constraint(equalToConstant: Constants.Image.imageWidth)
//            newsImage.centerYAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        newsImage.layer.cornerRadius = Constants.Image.cornerRadius //устанавливаем скругление картинки
        newsImage.layer.masksToBounds = true
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
    
    //enum Constants {
    //    enum ChikenButton {
    //        static let offsetToLeftSafeArea = 20 as CGFloat
    //        static let height = 50 as CGFloat
    //        static let offsetToCenterView = -20 as CGFloat
    //        static let backgroundColor = UIColor.green
    //        static let text = "Chiken"
    //        static let textColor = UIColor.black
    //    }
    //    enum FishButton {
    //        static let offsetToRightSafeArea = -20 as CGFloat
    //        static let height = 50 as CGFloat
    //        static let offsetToCenterView = 20 as CGFloat
    //        static let backgroundColor = UIColor.green
    //        static let text = "Fish"
    //        static let textColor = UIColor.black
    //    }
    //    enum ShrimpsButton {
    //        static let offsetToLeftSafeArea = 20 as CGFloat
    //        static let height = 50 as CGFloat
    //        static let offsetToRightSafeArea = -20 as CGFloat
    //        static let offsetToChikenButtonBotom = 16 as CGFloat
    //        static let backgroundColor = UIColor.green
    //        static let text = "Shrimps"
    //        static let textColor = UIColor.black
    //    }
    //}
    //
    //// Properties
    //private let chikenButton: UIButton = {
    //    let view = UIButton()
    //    view.setTitle(Constants.ChikenButton.text, for: .normal)
    //    view.backgroundColor = Constants.ChikenButton.backgroundColor
    //    view.setTitleColor(Constants.ChikenButton.textColor, for: .normal)
    //    return view
    //}()
    //private let fishButton: UIButton = {
    //    let view = UIButton()
    //    view.setTitle(Constants.FishButton.text, for: .normal)
    //    view.backgroundColor = Constants.FishButton.backgroundColor
    //    view.setTitleColor(Constants.FishButton.textColor, for: .normal)
    //    return view
    //}()
    //private let shrimpsButton: UIButton = {
    //    let view = UIButton()
    //    view.setTitle(Constants.ShrimpsButton.text, for: .normal)
    //    view.backgroundColor = Constants.ShrimpsButton.backgroundColor
    //    view.setTitleColor(Constants.ShrimpsButton.textColor, for: .normal)
    //    return view
    //}()
    //
    //// MARK: - Lifecycle
    //
    //override func viewDidLoad() {
    //    super.viewDidLoad()
    //    view.backgroundColor = .blue
    //    title = "back"
    //    setupUI()
    //}
    //
    //// MARK: - Private
    //
    //private func setupUI() {
    //    setupChikenButton()
    //    setupFishButton()
    //    setupShrimpsButton()
    //}
    //
    //private func setupChikenButton() {
    //    view.addSubview(chikenButton)
    //    chikenButton.translatesAutoresizingMaskIntoConstraints = false
    //    NSLayoutConstraint.activate([
    //        chikenButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.ChikenButton.offsetToLeftSafeArea),
    //        chikenButton.rightAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.ChikenButton.offsetToCenterView),
    //        chikenButton.heightAnchor.constraint(equalToConstant: Constants.ChikenButton.height),
    //        chikenButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    //    ])
    //    chikenButton.addTarget(self, action: #selector(didTapChikenButton), for: .touchUpInside)
    //}
    //
    //private func setupFishButton() {
    //    view.addSubview(fishButton)
    //    fishButton.translatesAutoresizingMaskIntoConstraints = false
    //    NSLayoutConstraint.activate([
    //        fishButton.leftAnchor.constraint(equalTo: view.centerXAnchor, constant: Constants.FishButton.offsetToCenterView),
    //        fishButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.FishButton.offsetToRightSafeArea),
    //        fishButton.heightAnchor.constraint(equalToConstant: Constants.FishButton.height),
    //        fishButton.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
    //    ])
    //    fishButton.addTarget(self, action: #selector(didTapFishButton), for: .touchUpInside)
    //}
    //
    //private func setupShrimpsButton() {
    //    view.addSubview(shrimpsButton)
    //    shrimpsButton.translatesAutoresizingMaskIntoConstraints = false
    //    NSLayoutConstraint.activate([
    //        shrimpsButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: Constants.ShrimpsButton.offsetToLeftSafeArea),
    //        shrimpsButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: Constants.ShrimpsButton.offsetToRightSafeArea),
    //        shrimpsButton.heightAnchor.constraint(equalToConstant: Constants.ShrimpsButton.height),
    //        shrimpsButton.topAnchor.constraint(equalTo: chikenButton.bottomAnchor, constant: Constants.ShrimpsButton.offsetToChikenButtonBotom)
    //    ])
    //    shrimpsButton.addTarget(self, action: #selector(didTapShrimpsButton), for: .touchUpInside)
    //}
    //
    //@objc private func didTapChikenButton() {
    //    tapButton(s2de: "Chiken very pozitive ")
    //
    //}
    //
    //@objc private func didTapFishButton() {
    //    tapButton(s2de: "Fish is a good")
    //}
    //
    //@objc private func didTapShrimpsButton() {
    //    tapButton(s2de: "krivetki it's a king")
    //}
    //
    //private func tapButton(s2de: String) {
    //    let VC = ThirdViewController(textForPass: " \(s2de)")
    //    VC.modalPresentationStyle = .overFullScreen
    //    VC.modalTransitionStyle = .coverVertical
    //    present(VC, animated: true)
    //}
    //}
}
