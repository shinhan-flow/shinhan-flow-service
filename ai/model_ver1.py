import os
from openai import OpenAI
from dotenv import load_dotenv
import json
import sys

mypath = sys.argv[0]
# MY_REQUEST = sys.argv[1]
MY_REQUEST = "매월 25일에 5만원을 111-113-111111 계좌에서 123-456-123123 계좌로 송금" 

root_path, myfile = os.path.split(mypath)



with open(f'{root_path}/prompt/explain_flow.json','r') as f:
    explain_flow = json.load(f)
with open(f'{root_path}/prompt/enumerate_data_options.json','r') as f:
    enumerate_data_options = json.load(f)
with open(f'{root_path}/prompt/enumerate_triggers.json','r') as f:
    enumerate_triggers = json.load(f)
with open(f'{root_path}/prompt/enumerate_actions.json','r') as f:
    enumerate_actions = json.load(f)
with open(f'{root_path}/prompt/set_format.json','r') as f:
    set_format= json.load(f)
system_prompt = [explain_flow, enumerate_data_options, enumerate_triggers, enumerate_actions, set_format]

load_dotenv()

client = OpenAI(
    api_key=os.getenv("API_KEY")
)

chat_completion = client.chat.completions.create(
    messages=[
        *system_prompt,
        {
            "role": "user",
            "content": MY_REQUEST,
        }
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)