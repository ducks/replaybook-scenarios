"""A 'nightly batch job' that opens connections and never closes them.

Retries until it has drained the pool - postgres may still be booting when
the fault is injected - then holds the connections forever.
"""

import time

import pg8000.native

conns = []
attempts = 0
while len(conns) < 12 and attempts < 120:
    attempts += 1
    try:
        conns.append(
            pg8000.native.Connection(
                user="postgres",
                password="password",
                host="db",
                database="appdb",
                timeout=3,
                application_name="nightly-batch",
            )
        )
        print(f"holding {len(conns)} connections", flush=True)
    except Exception as e:
        print(f"connect failed ({e}), retrying", flush=True)
        time.sleep(1)

print(f"batch 'processing' with {len(conns)} connections held", flush=True)
while True:
    time.sleep(60)
