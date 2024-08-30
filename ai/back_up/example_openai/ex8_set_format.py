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

# Answer 1
""" 1, 2, 3, 4, 5, 6의 합은 21입니다. """

# Answer 2
""" 주어진 리스트의 합을 계산해 보겠습니다.

리스트: \([1, 2, 3, 4, 5, 6]\)

합은 \(1 + 2 + 3 + 4 + 5 + 6 = 21\)입니다.

따라서 리스트의 합은 **21**입니다. """