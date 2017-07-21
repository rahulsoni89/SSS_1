import PerfectLib
import PerfectHTTP
import PerfectHTTPServer
import PerfectMustache

let server = HTTPServer()
server.serverPort = 8080
server.documentRoot = "webroot"


var objRoutes = Routes()

struct MustacheHelper: MustachePageHandler {
    var values: MustacheEvaluationContext.MapType
    
    func extendValuesForResponse(context contxt: MustacheWebEvaluationContext, collector: MustacheEvaluationOutputCollector) {
        contxt.extendValues(with: values)
        
        do{
            try contxt.requestCompleted(withCollector: collector)
        } catch{
            
            let response = contxt.webResponse
            response.appendBody(string: "\(error)")
                .completed(status: .internalServerError)
        }
    }
}

func helloMustache(request: HTTPRequest, response: HTTPResponse){
    let values = MustacheEvaluationContext.MapType()
    mustacheRequest(request: request, response: response, handler: MustacheHelper(values: values), templatePath: request.documentRoot + "/Hello.mustache")
}

objRoutes.add(method: .get, uri: "/helloMustache", handler: helloMustache)

server.addRoutes(objRoutes)

do{
    try server.start()
}
catch PerfectError.networkError(let err, let msg){
    print("Error: \(err)");
}

objRoutes.add(method: .get, uri: "/", handler: {
    request, response in
    response.setBody(string: "Hello! url calling...")
        .completed()
})
