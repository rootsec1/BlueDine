from fastapi.middleware.cors import CORSMiddleware
from fastapi import FastAPI, Request

from server.constants import LLM_SYSTEM_MESSAGE
from server.util import get_chat_response_from_llm, perform_search

in_memory_cache = {}

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
    query = query.strip().lower()
    if query in in_memory_cache:
        return in_memory_cache[query]
    search_results = perform_search(query)
    in_memory_cache[query] = search_results
    return search_results


@app.post("/chat/")
async def chat(request: Request):
    data = await request.json()
    query = data.get("query", "").strip().lower()
    message_history = data.get("message_history", [])
    agent_response = get_chat_response_from_llm(query, message_history)
    return {
        "response": agent_response
    }
