import PerfectLib
import PerfectHTTP
import PerfectHTTPServer

let objServer = HTTPServer()
objServer.serverPort = 8080
objServer.documentRoot = "webroot"

do
{
    try objServer.start()
}
catch PerfectError.networkError(let err, let msg){
    print("Error: \(err)");
}


//var objRoutes = Routes()
//objRoutes.add(method: .get, uri: "/", handler: {
//    request, response in
//    response.setBody(string: "Hello! url calling...")
//        .completed()
//})


print("Hello, world!")
