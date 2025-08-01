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

class Journey<T: TransportMethod> {
  var transportMethod: T

  init(transportMethod: T) {
    self.transportMethod = transportMethod
  }

  func startJourney() {
    print("여행을 시작합니다! 출발지: \(transportMethod.defaultCollectionPoint), 평균 속도: \(transportMethod.averageSpeedInKPH) KPH")
  }
}

let trainJourney = Journey(transportMethod: Train(defaultCollectionPoint: .stationA))
trainJourney.startJourney()


struct Car: TransportMethod {
  var defaultCollectionPoint: Road
  var averageSpeedInKPH: Double = 80.0
}

enum Road: TransportLocation {
  typealias CollectionPoint = CLLocation

  case car
  case motorbike
  case van
  case hgv

  // 사용자의 집 또는 현재 위치
  var defaultCollectionPoint: CLLocation {
    return CLLocation(latitude: 51.1, longitude: 0.1)
  }

  var location: CLLocation {
    return defaultCollectionPoint
  }

  var averageSpeedInKPH: Double {
    switch self {
    case .car: return 60
    case .motorbike: return 70
    case .van: return 55
    case .hgv: return 50
    }
  }
}
  
let carJourney = Journey(transportMethod: Car(defaultCollectionPoint: .car))
carJourney.startJourney()
