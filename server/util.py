import json
import re
import torch
import google.generativeai as genai

from pinecone import Pinecone
from nltk.tokenize import word_tokenize
from nltk.corpus import stopwords
from sentence_transformers import SentenceTransformer

# Local
from server.constants import LLM_SYSTEM_MESSAGE, PINECONE_API_KEY, ENCODE_MODEL_NAME, GEMINI_API_KEY, USER_SYSTEM_MESSAGE


device = 'cuda' if torch.cuda.is_available() else 'cpu'
model = SentenceTransformer(ENCODE_MODEL_NAME, device=device)

pc = Pinecone(api_key=PINECONE_API_KEY)
pc_index = pc.Index('items')

genai.configure(api_key=GEMINI_API_KEY)
gemini_model = genai.GenerativeModel("gemini-pro")


def preprocess_text(text):
    # Convert text to lowercase
    text = text.lower()
    # Remove extra spaces
    text = re.sub(r'\s+', ' ', text).strip()
    # Tokenize text
    tokens = word_tokenize(text)
    # Remove stopwords
    stop_words = set(stopwords.words('english'))
    filtered_tokens = [token for token in tokens if token not in stop_words]
    # remove all special characters except spaces
    filtered_tokens = [
        re.sub(r'[^a-zA-Z0-9\s]', '', token)
        for token in filtered_tokens
    ]
    # Re-join tokens into a string
    processed_text = ' '.join(filtered_tokens)
    processed_text = processed_text.strip()
    return processed_text


def encode_model(query):
    """
    This function takes a query and returns the embeddings of the query
    """
    embeddings = model.encode(query, convert_to_tensor=True)
    embeddings = embeddings.tolist()
    return embeddings


def metadata_from_pinecone(embeddings):
    """
    This function takes a query and returns the metadata of the query
    """
    response = pc_index.query(
        vector=embeddings,
        top_k=25,
        include_metadata=True
    )
    matches_list = response.get('matches', [])
    metadata_list = []
    for match in matches_list:
        metadata = match.get('metadata', {})
        metadata_list.append(metadata)
    return metadata_list


def get_LLM_Response(query, metadata) -> str:
    metadata = json.dumps(metadata)
    prompt = f"""
    {LLM_SYSTEM_MESSAGE}

    {USER_SYSTEM_MESSAGE.format(query, metadata)}
    """
    response = gemini_model.generate_content(prompt)
    return response.text


def perform_search(query: str) -> list[dict]:
    """
    This function takes a query and returns the search results
    """
    query = preprocess_text(query)
    embeddings = encode_model(query)
    metadata_list = metadata_from_pinecone(embeddings)
    llm_response = get_LLM_Response(query, metadata_list)
    llm_response = json.loads(llm_response)
    return llm_response
