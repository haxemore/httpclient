package httpmore;

import sys.io.FileOutput;
import sys.FileSystem;
import haxe.Http;
import sys.io.File;
import httpmore.HttpRequest;

class HttpClient {
	private var base:Http;

	public var timeout:Float;

	public function new() {
		base = new Http(null);
	}

	public function get(url:String, ?headers:Map<String, String>):HTTPRequest {
		var req = new HTTPRequest();

		base.url = url;
		base.onBytes = function(d) {
			req.content = d;
		};
		base.onStatus = function(s) {
			req.status = s;
		};
		base.cnxTimeout = timeout;

		if (headers != null) {
			for (n => v in headers.keyValueIterator()) {
				base.addHeader(n, v);
			}
		}
		base.request(false);

		req.url = url;
		req.headers = headers;
		req.type = RequestType.Get;

		return req;
	}

	public function post(url:String, ?content:String, ?headers:Map<String, String>):HTTPRequest {
		var req = new HTTPRequest();

		base.url = url;
		base.onBytes = function(d) {
			req.content = d;
		};
		base.onStatus = function(s) {
			req.status = s;
		};
		base.cnxTimeout = timeout;
		base.setPostData(content);

		if (headers != null) {
			for (n => v in headers.keyValueIterator()) {
				base.addHeader(n, v);
			}
		}
		base.request(true);

		req.url = url;
		req.headers = headers;
		req.type = RequestType.Post;

		return req;
	}

	public function downloadFile(url:String, dest:String) {
		var req = this.get(url);
		var f: FileOutput;
		if (FileSystem.exists(dest)) {
			f = File.update(dest);
			
		} else {
			f = File.write(dest);
		}
		f.writeBytes(req.content, 0, req.content.length);
		f.close();
	}
}