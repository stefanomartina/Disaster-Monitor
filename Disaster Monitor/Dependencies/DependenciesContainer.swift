import Foundation
import Katana
import Tempura
import Hydra
import Alamofire
import SwiftyJSON 

final class DependenciesContainer: NavigationProvider {
    let promisableDispatch: PromisableStoreDispatch
    var getAppState: () -> AppState
    var navigator: Navigator = Navigator()
    let ApiManager = APIManager()
    
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
    func getEventsUSGS(date: String, time: String) -> Promise<JSON> {
        return Promise<JSON>(in: .background) { resolve, reject, status in
            AF.request("https://earthquake.usgs.gov/fdsnws/event/1/query?format=geojson&starttime=" + date + "T" + time).responseJSON { response in
                if let data = response.data {
                    if let json = try? JSON(data: data) {
                        resolve(json)
                    }
                }
            }
        }
    }
    
    // Get last week events from INGV data source
    func getEventsINGV(date: String, time: String) -> Promise<JSON> {
        return Promise<JSON>(in: .background) { resolve, reject, status in
            AF.request("https://webservices.ingv.it/fdsnws/event/1/query?starttime=" + date + "T" + time + "&format=geojson").responseJSON { response in
                if let data = response.data {
                    if let json = try? JSON(data: data) {
                        resolve(json)
                    }
                }
            }
        }
    }
}
