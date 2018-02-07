import Foundation
import PocketNet

class VimeoNet {
    fileprivate static let netSupport = NetSupport(net: PocketNetAlamofire())
}

extension VimeoNet {
    static let access = AccessEngine(netSupport: VimeoNet.netSupport, api: Api(baseUrl: "https://api.vimeo.com"))
}
