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
            "content": """너는 프롬프트를 생성하는 인공지능이야.
            chatgpt의 system을 위한 프롬프트를 작성해줘
            입력: 동준이는 월요일마다 3000원을 수요일마다 5000원을 쓴다
            3주동안 총 얼마를 쓰는가

            출력 : 동준이는 월요일에 3000원, 수요일에 5000원을 사용합니다. 한주에 두 번 돈을 쓰므로, 한주에 쓰는 금액은 8000원입니다.
            3주동안의 지출은 주당 8000원에 3을 곱한 값입니다. 즉, 8000원 * 3 = 24000원입니다. 따라서 총 금액은 24000원입니다.
"""
        },

    ],
    model="gpt-4o-mini",
)

print("# Answer 1")
print('\"\"\"',chat_completion.choices[0].message.content,'\"\"\"')
print()
tmp = chat_completion.choices[0].message.content

chat_completion = client.chat.completions.create(
    messages=[
        {
            "role":"system",
            "content":tmp
        },
        {
            "role": "user",
            "content": """동준이는 월요일마다 3000원을 수요일마다 5000원을 쓴다
            3주동안 총 얼마를 쓰는가

"""
        },

    ],
    model="gpt-4o-mini",
)
print("# Answer 2")
print('\"\"\"',chat_completion.choices[0].message.content,'\"\"\"')
print()

# Answer 1
""" 프롬프트 작성을 위한 시스템 지침:

- 사용자 입력: "동준이는 월요일마다 3000원을 수요일마다 5000원을 쓴다. 3주동안 총 얼마를 쓰는가"
- 출력 포맷:
  1. 동준이의 월요일 및 수요일 지출액을 명시합니다.
  2. 한 주 동안의 총 지출액을 계산합니다.
  3. 3주 동안의 총 지출액을 구하기 위해 한 주의 지출액에 3을 곱한 값을 제시합니다.
  4. 총 지출액을 한 줄로 요약합니다.

예시 출력:
"동준이는 월요일에 3000원, 수요일에 5000원을 사용합니다. 한 주에 두 번 돈을 쓰므로, 한 주에 쓰는 금액은 8000원입니다. 3주 동안의 지출은 주당 8000원에 3을 곱한 값입니다. 즉, 8000원 * 3 = 24000원입니다. 따라서 총 금액은 24000원입니다." """