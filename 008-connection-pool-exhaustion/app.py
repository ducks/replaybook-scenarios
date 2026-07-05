from http.server import HTTPServer, BaseHTTPRequestHandler

import pg8000.native


def db_check():
    conn = pg8000.native.Connection(
        user="postgres",
        password="password",
        host="db",
        database="appdb",
        timeout=3,
        application_name="checkout",
    )
    try:
        conn.run("SELECT 1")
    finally:
        conn.close()


class Handler(BaseHTTPRequestHandler):
    def do_GET(self):
        if self.path != "/health":
            self.send_response(404)
            self.end_headers()
            return
        try:
            db_check()
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"ok")
        except Exception as e:
            self.send_response(503)
            self.end_headers()
            self.wfile.write(f"db error: {e}".encode())
            print(f"db error: {e}", flush=True)

    def log_message(self, *args):
        pass


if __name__ == "__main__":
    print("app listening on :8080", flush=True)
    HTTPServer(("0.0.0.0", 8080), Handler).serve_forever()
