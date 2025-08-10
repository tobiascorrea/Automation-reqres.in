import os, json, pathlib

ENV = os.getenv("ENV", "dev")
BASES = {
    "dev": "https://reqres.in",
    "stage": "https://reqres.in",
    "prod": "https://reqres.in"
}
BASE_URL = BASES.get(ENV, BASES["dev"])

DEFAULT_TIMEOUT = 10

_here = pathlib.Path(__file__).parent
with open(_here / "headers.json", "r", encoding="utf-8") as f:
    DEFAULT_HEADERS = json.load(f)
