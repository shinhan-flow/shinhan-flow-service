import os
from openai import OpenAI
from dotenv import load_dotenv

load_dotenv()

client = OpenAI(
    api_key=os.getenv("API_KEY")
)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "난 이제 지쳤어요",
        }
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "user",
            "content": "난 이제 지쳤어요🎤",
        }
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)