package httpmore;

import haxe.io.Bytes;
import haxe.Json;

class HTTPRequest {
    public var url: String;
    public var type: RequestType;
    public var status: Int;
    public var content: Bytes;
    public var headers: Map<String, String>;

    public function new() {}

    public function parseContent(): Dynamic {
        return Json.parse(this.content.toString());
    }
}

enum RequestType {
    Get;
    Post;
}