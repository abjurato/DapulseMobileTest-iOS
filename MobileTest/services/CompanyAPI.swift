import Alamofire
import SwiftyJSON

protocol CompanyAPIType {
    func fetch(completion: @escaping (Company)->())
}

class CompanyAPI: CompanyAPIType {
    func fetch(completion: @escaping (Company) -> ()) {
        Alamofire.request("http://dapulse-mobile-test.herokuapp.com", method: .get)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .success(let value):
                    let json = JSON(value)
                    let company = Company(json: json)
                    completion(company)

                case .failure(let error):
                    // TODO: show error UI
                    print("------ error on data loading -------")
                    print(error)
                }

        }
    }
    
    func avatar(from url: URL, completion: @escaping (UIImage?)->Void) {
        Alamofire.request(url).validate().responseData { response in
            guard response.result.isSuccess,
                let data = response.value,
                let image = UIImage(data: data) else
            {
                completion(nil)
                return
            }
            
            completion(image)
        }
    }
}
