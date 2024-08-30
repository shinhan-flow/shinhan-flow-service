import openai
import os
from utils import *
import json

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
MY_REQUEST = "내가 잘생겼으면"
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
)
tmp = chat_completion.choices[0].message.content
print(tmp)
chat_completion = client.chat.completions.create(
    messages=[
        {
            "role": "system",
            "content": "너는 점검자야. user가 입력한 json을 점검할거야.\n1. actions 리스트에 아무것도 없다면 'no action'라고 말해.\n 2. triggers 리스트에 조건이 없다면 'no trigger'라고 말해",
        },
        {
            "role": "user",
            "content": tmp,
        },
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)
