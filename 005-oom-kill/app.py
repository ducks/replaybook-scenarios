import http.server


def cache_mb():
    try:
        with open("/app/cache.conf") as f:
            return int(f.read().strip())
    except (OSError, ValueError):
        return 10


# Load a cache on startup - size controlled by /app/cache.conf
cache = b"x" * (cache_mb() * 1024 * 1024)


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    http.server.HTTPServer(("", 8080), Handler).serve_forever()
