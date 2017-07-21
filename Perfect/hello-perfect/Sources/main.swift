import PerfectLib
import PerfectHTTP
import PerfectHTTPServer


let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"


var objRoutes = Routes()
objRoutes.add(method: .get, uri: "/", handler: {
    request, response in
    response.setBody(string: "Hello! url calling...")
    .completed()
})




//var routes = Routes()
//routes.add(method: .get, uri: "/", handler: {
//    request, response in
//    response.setBody(string: "Hello Moto, How are you")
//    .completed()
//})
////server.addRoutes(routes)
//
//
//
//func returnJson(strMsg: String, objResponse: HTTPResponse) {
//    do{
//    try objResponse.setBody(json: ["Message", strMsg])
//        .completed()
//    }
//    catch{
//        objResponse.setBody(string: "Error: \(error)")
//        .completed(status: .internalServerError)
//    }
//}
//
//routes.add(method: .get, uri: "/Json", handler: {
//    request, response in
//    returnJson(strMsg: "This is json response", objResponse: response)
//})
//server.addRoutes(routes)

objRoutes.add(method: .get, uri: "/getParam/{strUname}/{strPass}", 	handler: {
    request,response in
    
    let strUname = request.urlVariables["strUname"]
    let strPass = request.urlVariables["strPass"]
    
    response.setBody(string: "Passed data is: \(strUname! + strPass!)")
    response.completed()
    
})

objRoutes.add(method: .post, uri: "/post", handler: {
    
    request, response in
    let strEmail = request.param(name: "email")
    let strUDID = request.param(name: "udid")
    response.setBody(string: "Success")
    response.completed()
})

server.addRoutes(objRoutes)

do{
    try server.start()
}
catch PerfectError.networkError(let err, let msg){
    print("Error: \(err)");
}
