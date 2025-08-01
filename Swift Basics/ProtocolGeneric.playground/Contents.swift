import CoreLocation

protocol TransportLocation {
  var location: CLLocation { get }
}

protocol TransportMethod {
  // TransportLocation 프로토콜을 준수하는 타입의 제네릭을 사용하도록 규정
  associatedtype T: TransportLocation
  var defaultCollectionPoint: T { get }
  var averageSpeedInKPH: Double { get }
}

struct Train: TransportMethod {
  var defaultCollectionPoint: TrainStation
  var averageSpeedInKPH: Double = 120.0
}

enum TrainStation: TransportLocation {
  case stationA
  case stationB

  var location: CLLocation {
    switch self {
    case .stationA:
      return CLLocation(latitude: 37.7749, longitude: -122.4194) // 샌프란시스코
    case .stationB:
      return CLLocation(latitude: 34.0522, longitude: -118.2437) // 로스앤젤레스
    }
  }
}
