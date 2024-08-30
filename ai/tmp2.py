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


messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "의자==1, 책상==2, 의자*2?"},
]

# 첫 번째 요청 보내기
response = client.chat.completions.create(model="gpt-4o", messages=messages)

# 응답 추가
messages.append({"role": "assistant", "content": response.choices[0].message.content})

# 다음 사용자 요청 추가
messages.append({"role": "user", "content": "의자+책상?"})

# 두 번째 요청 보내기
response = client.chat.completions.create(model="gpt-4o", messages=messages)

# 응답 추가
messages.append({"role": "assistant", "content": response.choices[0].message.content})

print(messages)
