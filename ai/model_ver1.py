import os
from openai import OpenAI
from dotenv import load_dotenv
import json
import sys

mypath = sys.argv[0]
MY_REQUEST = sys.argv[1]
root_path, myfile = os.path.split(mypath)



with open(f'{root_path}/prompt/system_ver1.json','r') as f:
    data = json.load(f)

load_dotenv()

client = OpenAI(
    api_key=os.getenv("API_KEY")
)

chat_completion = client.chat.completions.create(
    messages=[
        data,
        {
            "role": "user",
            "content": MY_REQUEST,
        }
    ],
    model="gpt-4o-mini",
)
print(chat_completion.choices[0].message.content)