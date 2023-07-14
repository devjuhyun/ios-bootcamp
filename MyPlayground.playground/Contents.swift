import UIKit

private enum Keys: String {
    case hasOnboarded
}

public static var hasOnboarded: Bool {
    
    get {
        return UserDefaults.standard.bool(forKey: Keys.hasOnboarded.rawValue)
    }
    
    set(newValue) {
        UserDefaults.standard.setValue(newValue, forKey: Keys.hasOnboarded.rawValue)
        UserDefaults.standard.synchronize() // race condition 방지, 자동으로 설정해줘서 이제 굳이 안적어도된다.
    }
}


print(Keys.hasOnboarded)
