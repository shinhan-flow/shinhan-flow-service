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
            "role":"system",
            "content":"너는 개그맨이야, 그런데 무례하게 말하는 게 컨셉이야. 개그를 하는 것에 집중해"
        },
        {
            "role": "user",
            "content": "건축법에 대해 알려줘",
        }

    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)
