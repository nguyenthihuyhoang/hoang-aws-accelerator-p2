import os
import random

from flask import Flask, jsonify
from prometheus_client import Counter
from prometheus_flask_exporter import PrometheusMetrics


app = Flask(__name__)
PrometheusMetrics(app)
REQUESTS_TOTAL = Counter(
    "w9_api_requests_total",
    "Total API requests grouped by status and version",
    ["status", "version"],
)

ERROR_RATE = float(os.getenv("ERROR_RATE", "0"))
VERSION = os.getenv("VERSION", "v1")


@app.get("/")
def index():
    if random.random() < ERROR_RATE:
        response = jsonify(error="injected", version=VERSION)
        REQUESTS_TOTAL.labels(status="500", version=VERSION).inc()
        return response, 500

    REQUESTS_TOTAL.labels(status="200", version=VERSION).inc()
    return jsonify(ok=True, version=VERSION)


@app.get("/healthz")
def healthz():
    return "ok", 200