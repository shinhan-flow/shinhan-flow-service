import os
from openai import OpenAI

client = OpenAI(
    api_key=""
)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "Hello world",
        }
    ],
    model="gpt-4o-mini",
)
