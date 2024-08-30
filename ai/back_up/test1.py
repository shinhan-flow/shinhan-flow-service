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
            "content": "지금까지 내가 보낸 요청들을 정리해서 알려줘",
        }
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)