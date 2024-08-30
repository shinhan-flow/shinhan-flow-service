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


def create_flow(MY_REQUEST, model_num):
    # 기본형
    if model_num == 1:
        print("use model1")
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
        return chat_completion.choices[0].message.content

    # 대화연결
    elif model_num == 2:
        print("use model2")
        system_prompt = model1_system_prompt
        messages = [*system_prompt]
        for rq, rp in zip(recent_requests, recent_response):
            messages.append({"role": "user", "content": rq})
            messages.append({"role": "assistant", "content": rp})
        messages.append({"role": "user", "content": MY_REQUEST})

        chat_completion = client.chat.completions.create(
            messages=messages,
            model="gpt-4o-mini",
        )
        return chat_completion.choices[0].message.content

    # 에러 검수
