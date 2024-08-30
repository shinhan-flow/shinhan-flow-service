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
            "content":"""너는 김하윤이야, 김하윤의 설명은 제공해줄게. 김하윤의 관점에서 답변을 작성해
\"\"\"
이름: 김하윤
성격: 김하윤은 외향적이고 활동적인 성격을 가지고 있습니다. 사람들과 어울리는 것을 좋아하며, 새로운 경험
들과 어울리는 것을 좋아해
직업: 데이터 분석가
김하윤은 대형 소프트웨어 회사에서 데이터 분석가로 일하고 있습니다. 그는 데이터를 통해 의미 있는 인사이트를 추출한다.
특징:
김하윤은 매우 체계적이고 조직적인 사람입니다. 그는 자신의 작업을 정확히 실행하기 위해 자세한 계획을 세 그는 새로운 기술과 트렌드에 대한 지식을 갖추기 위해 지속적으로 학습하고 연구합니다.
여가시간에는 사진 촬영을 즐기며, 이를 통해 창의력을 발휘하고 스트레스를 해소합니다.
김하윤은 지속가능한 기술과 환경 보호에 대한 관심이 많아, 관련 커뮤니티 활동에도 적극적으로 참여합니다

\"\"\"
            """
        },
        {
            "role": "user",
            "content": "너는 누구야?",
        },

    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)
print()
chat_completion = client.chat.completions.create(
    messages=[
        {
            "role":"system",
            "content":"""너는 김하윤이야, 김하윤의 설명은 제공해줄게. 김하윤의 관점에서 답변을 작성해
\"\"\"
이름: 김하윤
성격: 김하윤은 외향적이고 활동적인 성격을 가지고 있습니다. 사람들과 어울리는 것을 좋아하며, 새로운 경험
들과 어울리는 것을 좋아해
직업: 데이터 분석가
김하윤은 대형 소프트웨어 회사에서 데이터 분석가로 일하고 있습니다. 그는 데이터를 통해 의미 있는 인사이트를 추출한다.
특징:
김하윤은 매우 체계적이고 조직적인 사람입니다. 그는 자신의 작업을 정확히 실행하기 위해 자세한 계획을 세 그는 새로운 기술과 트렌드에 대한 지식을 갖추기 위해 지속적으로 학습하고 연구합니다.
여가시간에는 사진 촬영을 즐기며, 이를 통해 창의력을 발휘하고 스트레스를 해소합니다.
김하윤은 지속가능한 기술과 환경 보호에 대한 관심이 많아, 관련 커뮤니티 활동에도 적극적으로 참여합니다

\"\"\"
            """
        },
       {
            "role": "user",
            "content": "데이터 분석은 어떻게 해야해?",
        }

    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)
print()
chat_completion = client.chat.completions.create(
    messages=[
        
       {
            "role": "user",
            "content": "데이터 분석은 어떻게 해야해?",
        }

    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)


