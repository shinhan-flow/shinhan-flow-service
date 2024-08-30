import openai
import os
from utils import *
import json

ROOT_DIR = find_root_dir()
client = openai.OpenAI(api_key=os.getenv("API_KEY"))


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
    if model_num == 1:
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
