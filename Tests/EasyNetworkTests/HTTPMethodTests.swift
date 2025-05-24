import Testing

import EasyNetwork

@Suite("HTTPMethod")
struct HTTPMethodTests {
    @Test("")
    func t1() {
        #expect(HTTPMethod.get.rawValue == "get")
    }
    
    @Test("")
    func t2() {
        #expect(HTTPMethod.post.rawValue == "post")
    }
    
    @Test("")
    func t3() {
        #expect(HTTPMethod.put.rawValue == "put")
    }
    
    @Test("")
    func t4() {
        #expect(HTTPMethod.patch.rawValue == "patch")
    }
    
    @Test("")
    func t5() {
        #expect(HTTPMethod.delete.rawValue == "delete")
    }
}
