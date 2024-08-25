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
            "content": """다음의 합 알려줘 1,2,3,4,5,6
"""
        },

    ],
    model="gpt-4o-mini",
)

print("# Answer 1")
print('\"\"\"',chat_completion.choices[0].message.content,'\"\"\"')
print()

chat_completion = client.chat.completions.create(
    messages=[
        
        {
            "role": "user",
            "content": """나는 너한테 리스트를 전달할꺼야. 리스트의 합을 알려줘
            List:
            [1,2,3,4,5,6]

"""
        },

    ],
    model="gpt-4o-mini",
)
print("# Answer 2")
print('\"\"\"',chat_completion.choices[0].message.content,'\"\"\"')
print()

