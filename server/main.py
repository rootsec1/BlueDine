from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI

from server.util import perform_search


app = FastAPI()
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)


@app.get("/")
async def health_check():
    return {"ping": "pong"}


@app.get("/search/")
async def search(query: str):
    search_results = perform_search(query)
    return search_results
