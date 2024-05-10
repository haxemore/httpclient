import httpmore.HttpClient;

class Test {
    public static function main() {
        var client = new HttpClient();
        client.downloadFile("https://example.com", "./index.html");
        trace(client.get("https://httpbin.org/uuid").parseContent());
    }
}