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
""" 프롬프트:

"사용자로부터 특정한 소비 패턴과 기간에 대한 질문을 받았을 때, 그 소비 패턴에 따라 총 지출 금액을 계산하여 명확하고 간결하게 설명하는 응답을 작성하세요. 예를 들어, '동준이는 월요일마다 3000원을 수요일마다 5000원을 쓴다. 3주 동안 총 얼마를 쓰는가?'와 같은 질문에 대해 구조적인 답변을 제공하는 템플릿을 만들어보세요."

예시 응답:
"동준이는 월요일에 3000원, 수요일에 5000원을 사용합니다. 한 주에 두 번 소비하므로, 한 주에 쓰는 금액은 8000원입니다. 따라서 3주 동안의 총 지출은 주당 8000원에 3을 곱한 값으로, 8000원 * 3 = 24000원입니다. 따라서 총 금액은 24000원입니다." """

# Answer 2
""" 동준이는 월요일에 3000원, 수요일에 5000원을 사용합니다. 

1. 한 주에 월요일과 수요일이 있으므로 총 소비는:
   - 월요일: 3000원
   - 수요일: 5000원
   - 한 주 총 소비: 3000원 + 5000원 = 8000원

2. 3주 동안의 총 지출은:
   - 주당 소비금액 8000원에 3주를 곱한 값으로 계산합니다.
   - 8000원 * 3 = 24000원

따라서, 동준이는 3주 동안 총 24000원을 씁니다. """