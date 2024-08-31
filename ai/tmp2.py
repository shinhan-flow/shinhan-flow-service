import openai
import os
from utils import *
import json
from collections import Counter, defaultdict

ROOT_DIR = find_root_dir()
client = openai.OpenAI(api_key=os.getenv("API_KEY"))
assistant = client.beta.assistants.create(
    model="gpt-4o",
)
user_id = ""
recent_requests = []
recent_response = []

# 시스템 설정 로드
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

model1_system_prompt = [
    explain_flow,
    set_data_format,
    enumerate_triggers,
    enumerate_actions,
    set_output_format,
]
result = []
result_tri = Counter()
result_act = Counter()
result_err = Counter()
for i in range(5):
    MY_REQUEST = "달러 환율이 15이고 내 계좌 123123123123의 잔액이 1000원 미만일때 나에게 '안녕하세요' 알림을 줘"
    system_prompt = model1_system_prompt
    chat_completion = client.chat.completions.create(
        messages=[
            *system_prompt,
            {
                "role": "user",
                "content": MY_REQUEST,
            },
        ],
        model="gpt-4o-mini",
        temperature=1,
    )

    tmp = chat_completion.choices[0].message.content
    try:
        tmp = eval(tmp)
        key = "_".join(sorted([tr["type"] for tr in tmp["triggers"]]))
        result[key] += 1
    except:
        result["output_format_error"] += 1

    print(result)
