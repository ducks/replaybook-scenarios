from http.server import HTTPServer, BaseHTTPRequestHandler


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        self.send_response(410)
        self.end_headers()
        self.wfile.write(b"gone: backend-canary was decommissioned, see MIGRATION.md\n")

    def log_message(self, fmt, *args):
        print(f"canary (decommissioned): {self.address_string()} {fmt % args}", flush=True)


if __name__ == "__main__":
    print("backend-canary listening on :9000 (decommissioned, why am I still running?)", flush=True)
    HTTPServer(("0.0.0.0", 9000), Handler).serve_forever()
