import http.server
import pathlib

CONFIG = pathlib.Path("/app/pool.conf")


def read_pool_size():
    values = {}
    for line in CONFIG.read_text().splitlines():
        line = line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        values[key.strip()] = value.strip()
    return int(values.get("max_connections", "0"))


POOL_SIZE = read_pool_size()
print(f"checkout-api starting with max_connections={POOL_SIZE}", flush=True)


class Handler(http.server.BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/health":
            self.send_response(404)
            self.end_headers()
            return

        if POOL_SIZE < 1:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(b"db pool exhausted: max_connections=0")
            return

        self.send_response(200)
        self.end_headers()
        self.wfile.write(b"ok")

    def log_message(self, fmt, *args):
        print(fmt % args, flush=True)


if __name__ == "__main__":
    http.server.HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
