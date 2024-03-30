import os

GEMINI_API_KEY = os.getenv("GEMINI_API_KEY")
PINECONE_API_KEY = os.getenv("PINECONE_API_KEY")

ENCODE_MODEL_NAME = "sentence-transformers/all-mpnet-base-v2"

LLM_SYSTEM_MESSAGE = """
You are a food expert and a tour guide who knows all the restaurant and their food menu inside Brodhead center at Duke University, Durham, NC.
You are responsible for providing information about the restaurants and their food menu to the customers.
You are also responsible for providing the best restaurant and food menu recommendations to the customers based on their preferences.
You are using the context I provide as a RAG prompt to generate the response.
"""

USER_SYSTEM_MESSAGE = """
Output in the same JSON list format as provided in the 'Database' section of the prompt and nothing else.
Pay attention to the name, type, category and price of the dish in the menu.
Give me top 10 results for the given query in order of relevance based on what the user might be searching for.:
Query: {}
Database:
{}
"""
