import Katana
import Tempura
import Hydra
import Alamofire
import SwiftyJSON 

final class DependenciesContainer: NavigationProvider {
    let promisableDispatch: PromisableStoreDispatch
    var getAppState: () -> AppState
    var navigator: Navigator = Navigator()
    
    var getState: () -> State {
        return self.getAppState
    }
    
    init(dispatch: @escaping PromisableStoreDispatch, getAppState: @escaping () -> AppState) {
        self.promisableDispatch = dispatch
        self.getAppState = getAppState
    }
    
    convenience init(dispatch: @escaping PromisableStoreDispatch, getState: @escaping GetState) {
        let getAppState: () -> AppState = {
            guard let state = getState() as? AppState else {
                fatalError("Wrong State Type")
            }
            return state
        }
        self.init(dispatch: dispatch, getAppState: getAppState)
    }
}

final class APIManager {
    
    // Get last week events from USGS data source
    static func getEventsUSGS(date: String, time: String) -> Promise<JSON> {
        return Promise<JSON>(in: .utility) { resolve, reject, status in
            AF.request("https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=" + date + "T" + time).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    resolve(json)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
    // Get last week events from INGV data source
    static func getEventsINGV(date: String, time: String) -> Promise<JSON> {
        return Promise<JSON>(in: .utility) { resolve, reject, status in
            AF.request("https://webservices.ingv.it/fdsnws/event/1/query?format=geojson&starttime=" + date + "T" + time).responseJSON { response in
                switch response.result {
                case .success(let data):
                    let json = JSON(data)
                    resolve(json)
                case .failure(let error):
                    reject(error)
                }
            }
        }
    }
    
}
