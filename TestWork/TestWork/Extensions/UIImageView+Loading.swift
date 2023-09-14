
import Foundation
import UIKit

//TODO: "Shared load" не должны мигать картинки при быстром скролле
//отменить загрузку старой картинки если был reuse
//картинка старая может встать на место новой если она закончит загрузку после загрузки новой.
//так же может быть проблема,если старая картинка встала на место где будет новая и потом изображение мигнуло тоже плохо!!!
//загрузку вывести в ячейку отдельную либо доп функцию(сервис(гугли))
//когда происходит reuse есть cancel.
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
