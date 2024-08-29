import openai
import os
from utils import *
import json

ROOT_DIR = find_root_dir()
client = openai.OpenAI(api_key=os.getenv("API_KEY"))
with open(f"{ROOT_DIR}/prompt/ver1/explain_flow.json", "r") as f:
    explain_flow = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/set_data_format.json", "r") as f:
    set_data_format = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/enumerate_triggers.json", "r") as f:
    enumerate_triggers = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/enumerate_actions.json", "r") as f:
    enumerate_actions = json.load(f)
with open(f"{ROOT_DIR}/prompt/ver1/set_output_format.json", "r") as f:
    set_output_format = json.load(f)
system_prompt = [
    explain_flow,
    set_data_format,
    enumerate_triggers,
    enumerate_actions,
    set_output_format,
]
chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "system",
            "content": "너는 점검자야. 사용자가 너에게 요청을 보낼거야. 내가 말하는 확인사항들을 체크해\n 에러사항 1.사용자의 요청에서 계좌관련 요청이지만, 계좌번호가 없다면 '에러'출력\n 2. 요청에 언급된 날짜가 달력에 존재하지 않는 날짜라면 '에러2'출력\n 3. 25시 67분 처럼 존재하지 않는 시간이라면 에러3 출력\n 4. 외화는 USD, EUR, JPY, CNY, GBP, CHF, CAD의 6개만 서비스가 가능하다. 그 외의 외화에 대한 요청을 한다면 '에러4'출력\n 5. 은행상품은 입출금, 예금, 저축, 대출 이렇게 4가지가 있다. 사용자가 상품관련 요청을 했을때, 예금,입출금,저축,대출 4가지 외에 다른 상품을 언급 하면 '에러 5'출력",
        },
        {
            "role": "user",
            "content": """
저축상품의 이자율이 25이상일때 사랑해라고 알려줘. 
            """,
        },
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)
