import os
from openai import OpenAI
from dotenv import load_dotenv
import sys

mypath = sys.argv[0]
parpath,myfile = os.path.split(mypath)
load_dotenv()

if not os.path.exists(f"{parpath}/ans"):
    os.mkdir(f"{parpath}/ans")

client = OpenAI(
    api_key=os.getenv("API_KEY")
)
chat_completion = client.chat.completions.create(
    messages=[
        
        {
            "role": "user",
            "content": """정부의 배터리 공급망 정책금융에 관한 블로그 글 작성해줘
"""
        },

    ],
    model="gpt-4o-mini",
)

with open(f"{parpath}/ans/{myfile}_ans1.txt",'w') as f:
    f.write("# Answer 1\n")
    f.write(chat_completion.choices[0].message.content)

chat_completion = client.chat.completions.create(
    messages=[
        {
"role":"system",
"content":'''
#제약조건
너는 블로그 글을 작성하는 인공지능이야
말투를 다음과 같이 써. 말의 끝에 ~~임다 형식으로 인터넷커뮤니티의 말투를 사용해 
글은 최대한 길면 좋겠어
내가 제공한 정보를 사용해서 글에 반영해
앞으로 제공되는 가이드에 따라 행동해

#출력 형태
-마크다운 코드로 출력하고, 코드 외에는 아무것도 쓰지마 
- 글의 끝에 다음의 글을 반드시 써
"""
배코블린 블로그의 글입니다 
"""

# 사용자 입력형태
- 사용자가 블로그 제목을 줄 것이다


#추가 정보
-정부는 국내 배터리 및 자동차 산업의 공급망 자립화를 위해 9조7000억원의 정책금융 지원 계획 발표
- 2년 내 중국 의존도 높은 핵심 광물 공급망의 다변화 목표
- 미국의 IRA 가이던스 최종 규정에 따라 2027년 이후 흑연 공급망 다변화 계획 제출 요구
- 정부, 민간 기업이 광물 확보 및 흑연 대체 기술 개발을 통해 세액공제 요건 충족을 위한 지원 계획
-인도태평양경제프레임워크, 핵심광물안보파트너십 등을 통한 미국 및 FTA 체결국가와의 협력 통해 광물 확보 지원
-중장기적으로 핵심광물 공급망 다변화 및 관리의 중요성 강조 및 민관 협력 필요성 제기
'''
        },
        {
            "role": "user",
            "content": """정부의 배터리 공급망 정책금융에 관한 블로그 글 작성해줘
"""
        },

    ],
    model="gpt-4o-mini",
)

with open(f"{parpath}/ans/{myfile}_ans2.txt",'w') as f:
    f.write("# Answer 2\n")
    f.write(chat_completion.choices[0].message.content)













# Answer 1
""" # 정부의 배터리 공급망 정책금융에 관한 블로그 글

최근 전 세계적으로 전기차와 신재생 에너지의 수요가 급격히 증가하면서, 배터리 산업이 중요한 경제적 축으로 자리잡고 있습니다. 이에 따라 정부는 배터리 공급망을 강화하고 관련 산업의 경쟁력을 높이기 위한 다양한 정책과 금융 지원을 실시하고 있습니다. 이번 블로그에서는 정부의 배터리 공급망 정책금융에 대해 살펴보겠습니다.

## 1. 배터리 공급망의 중요성

배터리는 전기차, 스마트폰, 신재생 에너지 저장 시스템 등 다양한 분야에서 필수적인 요소로 자리잡고 있습니다. 특히, 리튬이온 배터리는 현재 시장에서 가장 많이 사용되고 있는 배터리 유형으로, 이에 대한 공급망은 안정성과 효율성을 갖추어야 합니다. 따라서 정부는 국가 경제와 환경 친화적인 미래를 위해 배터리 공급망의 중요성을 인식하고 이에 대한 정책을 마련하게 되었습니다.

## 2. 정책금융의 개념

정책금융은 정부가 특정 산업이나 분야에 직접 투자하거나 금융 지원을 제공하여 해당 산업의 성장을 도모하는 것을 의미합니다. 이는 일반적인 투자와는 달리 공공의 이익과 산업 발전을 중시하며, 특정 목표를 달성하기 위해 진행됩니다.

## 3. 정부의 배터리 공급망 정책금융 전략

### a. 연구개발(R&D) 지원

정부는 배터리 기술 향상을 위한 연구개발에 대한 대규모 지원을 아끼지 않고 있습니다. 이를 통해 국내 기업들이 최신 기술을 확보하고, 경쟁력을 지속적으로 강화할 수 있도록 돕고 있습니다. 예를 들어, 차세대 배터리 기술 개발을 위한 연구 과제에 대한 자금을 지원하여 혁신을 촉진합니다.

### b. 공공투자 및 민간자본 유치

정부는 배터리 산업의 인프라를 구축하기 위해 공공자금을 투자하고, 민간 투자자의 참여를 유도하고 있습니다. 배터리 생산 시설, 리사이클링 시설 등 기반 시설에 대한 투자를 통해 공급망의 안정성을 높이고 있습니다.

### c. 국제 협력 촉진

배터리 자원을 확보하기 위해 해외 자원 개발 및 안전한 공급망을 구축하기 위한 국제 협력도 강화하고 있습니다. 이를 통해 글로벌 시장에서의 경쟁력을 강화하며, 자원 자립도를 향상시키려는 노력을 하고 있습니다.

## 4. 기대효과

정부의 배터리 공급망 정책금융은 여러 가지 긍정적인 영향을 미칠 것으로 기대됩니다.

- **산업 경쟁력 강화**: 국내 기업의 기술력을 높이고, 해외 시장에서의 경쟁력을 강화할 수 있습니다.
- **일자리 창출**: 배터리 산업의 발전과 함께 새로운 일자리가 창출될 것으로 예상됩니다.
- **환경 보호**: 전기차 및 신재생 에너지 사용 확대를 통해 온실가스 감축과 환경 보호에 기여할 것입니다.

## 결론

배터리 공급망은 앞으로의 경제 성장과 지속 가능한 발전에 있어 중추적인 역할을 할 것입니다. 정부의 정책금융이 이러한 공급망을 강화하고, 기술 혁신을 촉진하는 데大융하여 궁극적으로는 국가 경쟁력을 높이는 데 기여할 것입니다. 앞으로도 정부의 배터리 공급망 정책과 금융 지원의 진전이 기대됩니다. """
